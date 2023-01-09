// ignore_for_file: prefer_typing_uninitialized_variables, unused_import, avoid_print

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerController with ChangeNotifier {
  var trackID = 0;
  var player = AudioPlayer();
  var playType;
  // var episodeTitle;
  // var showTitle;
  // var showPic;

  void nextID() {
    trackID++;
  }

  void disposePlayer() {
    player.dispose();
  }

  void stop() {
    player.stop();
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  initPlayer({episodeURL, episodeTitle, showTitle, showPic}) async {
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
    }
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
