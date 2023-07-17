// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, unused_import

import 'package:caster/providers/recent_tracks_provider.dart';
import 'package:caster/screens/main_nav.dart';
import 'package:caster/screens/play_screen.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/screens/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({this.genre});
  final genre;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // var searchType;

  void showData() async {
    var searchData = Provider.of<SearchData>(context, listen: false);

    if (Provider.of<AudioPlayerController>(context, listen: false).playType ==
        'discovery') {
      if (widget.genre != null) {
        await context.read<SearchData>().discoverySearch(genre: widget.genre);
      }

      if (widget.genre == null) {
        await context.read<SearchData>().discoverySearch();
      }

      context.read<AudioPlayerController>().initPlayer(
            episodeURL: searchData.episodeURL,
            episodeTitle: searchData.episodeTitle,
            showTitle: searchData.showTitle,
            showPic: searchData.showPic,
            context: context,
          );

      try {
        Provider.of<RecentTrackProvider>(context, listen: false).insertTrack(
            episodeImage: searchData.episodePic,
            showTitle: searchData.showTitle,
            showImage: searchData.showPic,
            episodeTitle: searchData.episodeTitle,
            episodeDescription: searchData.episodeDescription,
            episodeURL: searchData.episodeURL,
            episodeLen: searchData.episodeLen,
            showURL: searchData.showURL);
      } catch (e) {
        print('insert track error(loading screen): $e');
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainNav(
              startIndex: 2,
            );
          },
        ),
      );
    }

    // if (Provider.of<AudioPlayerController>(context, listen: false).playType ==
    //     'normal') {
    //   context.read<AudioPlayerController>().initPlayer(
    //         episodeURL: SearchData().episodeURL,
    //         episodeTitle: SearchData().episodeTitle,
    //         showTitle: SearchData().showTitle,
    //         showPic: SearchData().showPic,
    //       );

    //   Provider.of<RecentTrackProvider>(context, listen: false).addRecentTrack(
    //       episodeImage: SearchData().episodePic,
    //       showTitle: SearchData().showTitle,
    //       showImage: SearchData().showPic,
    //       episodeTitle: SearchData().episodeTitle,
    //       episodeDescription: SearchData().episodeDescription,
    //       episodeURL: SearchData().episodeURL,
    //       episodeLen: SearchData().episodeLen,
    //       showURL: SearchData().showURL);

    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return MainNav(
    //           startIndex: 2,
    //         );
    //       },
    //     ),
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();
    showData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotatePulse,
        ),
      ),
    );
  }
}
