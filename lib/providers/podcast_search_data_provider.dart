// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables, unused_import, unused_field, await_only_futures
// import 'dart:html';

import 'dart:convert';
import 'dart:math';
import 'package:caster/models/recent_track.dart';
import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/providers/podcast_data.dart';
import 'package:caster/providers/recent_tracks_provider.dart';
import 'package:caster/screens/loading_screen.dart';
import 'package:caster/screens/search_result_screen.dart';
import 'package:caster/utilities/episode_card.dart';
import 'package:caster/utilities/show_card.dart';
import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import '../utilities/result_card.dart';

class SearchData with ChangeNotifier {
  int limit = 100;
  int searchLimit = 20;

  // final List<String> _recentSearches = [];
  List<Widget> keywordResults = [];
  List<Widget> keywordResultsEpisodes = [];
  List<Widget> topShows = [];

  late Podcast show;
  var currentSearch;
  var searchType = 'discovery';
  late bool searching;

  var showTitle;
  var showPic;
  var showFeed;
  var episodeTitle;
  var episodePic;
  var episodeURL;
  var episodeLen;
  var episodeDescription;
  var showURL;

  normalPlayVariableSet(
      {showTitle,
      showPic,
      episodeTitle,
      episodePic,
      episodeURL,
      episodeLen,
      episodeDescription,
      showURL}) {
    this.showTitle = showTitle;
    this.episodeDescription = episodeDescription;
    this.showPic = showPic;
    this.episodeTitle = episodeTitle;
    this.episodePic = episodePic;
    this.episodeLen = episodeLen;
    this.showURL = showURL;
    this.episodeURL = episodeURL;
  }

// *********Function to get genres and generate genre cards for homescreen*********
  getGenres(context) {
    List<Widget> genreBlocks = [];
    var search = Search();
    var genres = search.genres();
    for (var genre in genres) {
      if (genre != '') {
        var genreBlock = GestureDetector(
          onTap: () {
            if (searchType == 'search') {
              // currentSearch = genre;
              keywordSearch(context, genre: genre);
              Navigator.pushNamed(context, SearchResultsScreen.id);
            }
            if (searchType == 'discovery') {
              Provider.of<AudioPlayerController>(context, listen: false)
                  .playType = 'discovery';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadingScreen(genre: genre),
                ),
              );
            }
          },
          child: Card(
            elevation: 10,
            color: Colors.lightBlue,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/genre_bg2.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              height: 100,
              width: 100,
              child: Center(
                child: Text(
                  genre,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        );
        genreBlocks.add(genreBlock);
      }
    }
    return genreBlocks;
  }

  getPopular() async {
    var search = Search();
    var charts = await search.charts(country: Country.UNITED_STATES, limit: 20);
    topShows.clear();
    for (var result in charts.items) {
      try {
        var show = await Podcast.loadFeed(
          url: result.feedUrl.toString(),
        );
        RssFeed showData = await PodcastData().getdata(show.url ?? '');
        var card = Padding(
          padding: EdgeInsets.only(right: 15),
          child: ShowCard(
            showFeed: showData,
            showURL: result.feedUrl.toString(),
          ),
        );
        topShows.add(card);
      } catch (e) {
        print('PopularShowsError: $e');
      }
      notifyListeners();
    }
  }

// *************function to perform discovery mode search***************
  Future discoverySearch({genre}) async {
    var search = Search();

    // _________discovery by keyword search if no genre is given_____________
    if (genre == null) {
      SearchResult results = await search.search(currentSearch,
          country: Country.UNITED_STATES, limit: limit);

      int showPicked = Random().nextInt(limit);

      try {
        show = await Podcast.loadFeed(
          url: results.items[showPicked].feedUrl.toString(),
        );
      } catch (e) {
        print("Error setting variable show: $e");
      }

      int episodePicked = Random().nextInt(show.episodes!.length);

      showTitle = await show.title;
      print(showTitle);
      episodeTitle = await show.episodes?[episodePicked].title;
      episodePic = await show.episodes?[episodePicked].imageUrl;
      episodeURL = await show.episodes?[episodePicked].contentUrl;
      episodeLen = await show.episodes?[episodePicked].duration;
      episodeDescription = await show.episodes?[episodePicked].description;
      showPic = await show.image;
      showFeed = PodcastData().getdata(show.url!);
      showURL = show.url;

      notifyListeners();
    }

    // ____________search by genre if genre is not null_____________
    if (genre != null) {
      currentSearch = genre;

      SearchResult results = await search.search(
        genre,
        country: Country.UNITED_STATES,
        attribute: Attribute.GENRE_TERM,
        limit: limit,
      );

      int showPicked = Random().nextInt(limit);

      try {
        show = await Podcast.loadFeed(
          url: results.items[showPicked].feedUrl.toString(),
        );
      } catch (e) {
        print("Error setting variable show: $e");
      }

      int episodePicked = Random().nextInt(show.episodes!.length);

      showTitle = await show.title;
      episodeTitle = await show.episodes?[episodePicked].title;
      episodePic = await show.episodes?[episodePicked].imageUrl;
      episodeURL = await show.episodes?[episodePicked].contentUrl;
      episodeLen = await show.episodes?[episodePicked].duration;
      episodeDescription = await show.episodes?[episodePicked].description;
      showPic = await show.image;
      showFeed = PodcastData().getdata(show.url!);
      showURL = results.items[showPicked].feedUrl.toString();

      notifyListeners();
    }
  }

// *************Funtion to perform keyword search in serch mode**************
  keywordSearch(context, {genre}) async {
    keywordResults.clear();
    searching = true;
    var search = Search();
    Podcast? show;

    // _____________search by typed keyword if genre is not provided___________
    if (genre == null) {
      SearchResult results = await search.search(currentSearch,
          country: Country.UNITED_STATES, limit: 200);

      for (var result in results.items) {
        try {
          show = await Podcast.loadFeed(
            url: result.feedUrl.toString(),
          );
        } catch (e) {
          print("Error setting variable show: $e");
        }
        var showFeed = await PodcastData().getdata(show!.url ?? '');
        var showResult = ResultCard(
          showFeed: showFeed,
          showURL: result.feedUrl.toString(),
        );
        keywordResults.add(showResult);

        if (searching == true) {
          searching = false;
        }
        notifyListeners();
      }
    }

    // _____________search by genre if genre is provided___________
    if (genre != null) {
      SearchResult results = await search.search(
        genre,
        country: Country.UNITED_STATES,
        limit: 200,
        attribute: Attribute.GENRE_TERM,
      );
      for (var result in results.items) {
        try {
          show = await Podcast.loadFeed(
            url: result.feedUrl.toString(),
          );
        } catch (e) {
          print("Error setting variable show: $e");
        }
        var showFeed = await PodcastData().getdata(show!.url ?? '');
        var showResult = ResultCard(
          showFeed: showFeed,
          showURL: result.feedUrl.toString(),
        );
        keywordResults.add(showResult);

        if (searching == true) {
          searching = false;
        }
        notifyListeners();
      }
    }
    // if (searching == true) {
    //   searching = false;
    // }
    // notifyListeners();
  }

// **********function to generate episode results for keyword search in search mode************
  // listenNotesSearch() async {
  //   var url = 'http://10.0.0.2:5000/search/$currentSearch';
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     var results = jsonDecode(response.body)['results'];
  //     for (var result in results) {
  //       showTitle = result['podcast']['title_original'];
  //       showPic = result['podcast']['image'];
  //       episodeTitle = result['title_original'];
  //       episodePic = result['thumbnail'];
  //       episodeURL = result['audio'];
  //       episodeLen = result['audio_length_sec'];
  //       var showHost = result['podcast']['publisher_original'];
  //       var episodeDescription = result['description_highlighted'];
  //       var episode = EpisodeCard(
  //           episodeImage: episodePic,
  //           showTitle: showTitle,
  //           showHost: showHost,
  //           episodeTitle: episodeTitle,
  //           episodeDescription: episodeDescription,
  //           episodeURL: episodeURL);
  //       keywordResultsEpisodes.add(episode);
  //     }

  //   } catch (e) {
  //     print('listenNotesSearchError: $e');
  //   }
  //   if (searching == true) {
  //       searching = false;
  //     }
  //     notifyListeners();
  // }

  // searchTst() {
  //   var search = Search();

  //   var results = search.search('', queryParams: {});
  // }
}
