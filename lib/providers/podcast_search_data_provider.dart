// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables, unused_import, unused_field, await_only_futures
// import 'dart:html';

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:provider/provider.dart';

class SearchData with ChangeNotifier {
  int limit = 30;

  final List<String> _recentSearches = [];
  final List<Map> _recentlyPlayed = [];

  late Podcast show;
  var currentSearch;

  List get recentSearches => _recentSearches;
  List get recentlyPlayed => _recentlyPlayed;

  // var player;
  var showTitle;
  var showPic;
  var episodeTitle;
  var episodePic;
  var episodeURL;
  var episodeLen;

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

    Map<String, String> newTrack = {
      "Show": showTitle,
      "Episode Title": episodeTitle,
      "Episode Pic": episodePic,
    };

    _recentlyPlayed.add(newTrack);

    notifyListeners();
    // return show;
  }
}
