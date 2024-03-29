// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, prefer_const_constructors, unused_import

import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/providers/subscribe.dart';
import 'package:caster/components/flipcard_details.dart';
import 'package:caster/components/player_controls_toggle.dart';
import 'package:caster/components/track_info.dart';
import 'package:caster/components/track_progress_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:podcast_search/podcast_search.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:caster/components/player_controls.dart';
import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
import 'package:flip_card/flip_card.dart';

class PlayScreen extends StatelessWidget {
  bool checkSearchStatus(context) {
    bool status =
        Provider.of<SearchData>(context, listen: true).currentSearch != null
            ? true
            : false;
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[400],
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.bookmark_add),
            onPressed: () {
              context
                  .read<Subscribe>()
                  .addSubscription(context.read<SearchData>().showURL);
            },
          ),
          title: Text('Now Playing'),
        ),
        body: checkSearchStatus(context) == true ||
                context.read<AudioPlayerController>().playType == 'normal'
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 10.h,
                        left: 6.w,
                        right: 6.w,
                        bottom: 6.h,
                      ),
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: FlipCard(
                          fill: Fill.fillBack,
                          front:
                              (context.watch<SearchData>().episodePic != null)
                                  ? Image(
                                      fit: BoxFit.fill,
                                      width: 300,
                                      height: 300,
                                      image: NetworkImage(
                                        context.watch<SearchData>().episodePic,
                                      ))
                                  : Container(
                                      margin: EdgeInsets.only(top: 45.h),
                                      width: 30.w,
                                      height: 30.h,
                                      child: CircularProgressIndicator(),
                                    ),
                          back: (context.watch<SearchData>().episodePic != null)
                              ? EpisodeFlipCard()
                              : SizedBox(),
                        ),
                      ),
                    ),
                  ),
                  TrackInfo(),
                  TrackProgressBar(),
                  PlayerControls(),
                ],
              )
            : SizedBox(),
      ),
    );
  }
}
