// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, prefer_const_constructors, unused_import

import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/utilities/nav_menu.dart';
import 'package:caster/utilities/subscribe.dart';
import 'package:caster/utilities/track_info.dart';
import 'package:caster/utilities/track_progress_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:podcast_search/podcast_search.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:caster/utilities/player_controls.dart';
import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:marquee/marquee.dart';

class PlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Subscribe()
                        .addSubscription(context.read<SearchData>().show);
                  },
                  child: Text("Subscribe"),
                ),
              ],
            ),
            Expanded(
              // flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 35,
                  left: 20,
                  right: 20,
                  bottom: 30,
                ),
                child: SizedBox(
                  child: (context.watch<SearchData>().episodePic != null)
                      ? Image(
                          image: NetworkImage(
                          context.watch<SearchData>().episodePic,
                        ))
                      : Container(
                          margin: EdgeInsets.only(top: 150),
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ),
            TrackInfo(),
            TrackProgressBar(),
            PlayerControls(),
          ],
        ),
      ),
    );
  }
}
