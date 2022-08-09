// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables, unused_import, unused_field, await_only_futures
// import 'dart:html';

import 'dart:convert';
import 'dart:math';
import 'package:caster/models/recent_track.dart';
import 'package:caster/providers/recent_tracks_provider.dart';
import 'package:caster/utilities/show_card.dart';
import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchData with ChangeNotifier {
  int limit = 30;

  final List<String> _recentSearches = [];
  final List<Widget> topShows = [];

  late Podcast show;
  var currentSearch;

  List get recentSearches => _recentSearches;
  // List get recentlyPlayed => _recentlyPlayed;

  // var player;
  var showTitle;
  var showPic;
  var episodeTitle;
  var episodePic;
  var episodeURL;
  var episodeLen;

  getGenres() {
    List<Widget> genreBlocks = [];
    var search = Search();
    var genres = search.genres();
    for (var genre in genres) {
      var genreBlock = Card(
        elevation: 10,
        color: Colors.lightBlue,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/genre_bg2.jpg'), 
            fit: BoxFit.fill,
            ),
          ),
          height: 100,
          width: 100,
          child: Center(child: Text(genre,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          ),),),
      );
      genreBlocks.add(genreBlock);
    }
    return genreBlocks;
  }

  getPopular() async {
    var search = Search();

    var charts = await search.charts(country: Country.UNITED_STATES, limit: 20);
    topShows.clear();
    for (var show in charts.items) {
      try {
        var card = Padding(
          padding: EdgeInsets.only(right: 15),
          child: ShowCard(
            showTitle: await show.trackName,
            showPic: await show.bestArtworkUrl,
            onTap: () {},
          ),
        );
        topShows.add(card);
      } catch (e) {
        print('PopularShowsError: $e');
      }
    }
  }

  Future podcastSearch() async {
    var search = Search();

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

    _recentSearches.add(currentSearch);

    int episodePicked = Random().nextInt(show.episodes!.length);

    showTitle = await show.title;
    episodeTitle = await show.episodes?[episodePicked].title;
    episodePic = await show.episodes?[episodePicked].imageUrl;
    episodeURL = await show.episodes?[episodePicked].contentUrl;
    episodeLen = await show.episodes?[episodePicked].duration;
    showPic = await show.image;

    var newTrack = RecentTrack(episodePic, showTitle, episodeTitle).toJson();
    RecentTrackProvider().addRecentTrack(newTrack);
    // Map<String, String> newTrack = {
    //   "Show": showTitle,
    //   "Episode Title": episodeTitle,
    //   "Episode Pic": episodePic,
    // };

    // _recentlyPlayed.add(newTrack);

    notifyListeners();
    // return show;
  }

  listenNotesSearch() async {
    var url = 'http://10.0.2.2:5000/search/$currentSearch';
    try {
      var response = await http.get(Uri.parse(url));
      var result = jsonDecode(response.body)['results'];
      showTitle = result[1]['podcast']['title_original'];
      showPic = result[1]['podcast']['image'];
      episodeTitle = result[1]['title_original'];
      episodePic = result[1]['thumbnail'];
      episodeURL = result[1]['audio'];
      episodeLen = result[1]['audio_length_sec'];
    } catch (e) {
      print('listenNotesSearchError: $e');
    }
    var newTrack = RecentTrack(episodePic, showTitle, episodeTitle).toJson();
    RecentTrackProvider().addRecentTrack(newTrack);
    notifyListeners();
  }
}
