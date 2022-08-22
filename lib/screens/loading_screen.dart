// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, unused_import

import 'package:caster/screens/main_nav.dart';
import 'package:caster/screens/play_screen.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/screens/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({this.genre});
  final genre;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var searchType;

  void showData() async {
    if (widget.genre != null) {
      await context.read<SearchData>().discoverySearch(genre: widget.genre);
    }

    context.read<AudioPlayerController>().initPlayer(
          episodeURL: context.read<SearchData>().episodeURL,
          episodeTitle:
              Provider.of<SearchData>(context, listen: false).episodeTitle,
          showTitle: Provider.of<SearchData>(context, listen: false).showTitle,
          showPic: Provider.of<SearchData>(context, listen: false).showPic,
        );

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

    // if (searchType == 'search') {
    //   Navigator.pushNamed(context, SearchResultsScreen.id);
    // }
  }

  @override
  void initState() {
    super.initState();
    searchType = context.read<SearchData>().searchType;
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
