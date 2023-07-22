// ignore_for_file: prefer_typing_uninitialized_variables, unused_import, avoid_print

import 'dart:math';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'recent_tracks_provider.dart';

class AudioPlayerController with ChangeNotifier {
  var trackID = 0;
  var player = AudioPlayer();
  var playType;
  late Duration currentPosition;
  // var episodeTitle;
  // var showTitle;
  // var showPic;

  void nextID() {
    trackID++;
  }

  void disposePlayer() {
    player.dispose();
  }

  void stopPlayer(context) async {
    Provider.of<RecentTrackProvider>(context, listen: false)
        .currentTrackPosition = player.position;
    Provider.of<RecentTrackProvider>(context, listen: false).updateTrack(
        Provider.of<SearchData>(context, listen: false).showTitle,
        Provider.of<SearchData>(context, listen: false).episodeTitle);
    player.stop();
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  initPlayer({episodeURL, episodeTitle, showTitle, showPic, context}) async {
    try {
      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(episodeURL),
          tag: MediaItem(
              id: trackID.toString(),
              album: episodeTitle,
              title: showTitle,
              artUri: Uri.parse(showPic)),
        ),
      );
      player.play();
    } catch (e) {
      print("Error loading audio source: $e");
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('Error loading episode audio'),
        ),
      );
    }
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
