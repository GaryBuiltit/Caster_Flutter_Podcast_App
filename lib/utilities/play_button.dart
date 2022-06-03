// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

Widget playerButton(PlayerState? playerState, AudioPlayer player) {
  final processingState = playerState?.processingState;
  if (processingState == ProcessingState.loading ||
      processingState == ProcessingState.buffering) {
    // 2
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 64.0,
      height: 64.0,
      child: CircularProgressIndicator(),
    );
  } else if (player.playing != true) {
    // 3
    return IconButton(
      icon: Icon(Icons.play_arrow),
      iconSize: 64.0,
      onPressed: player.play,
    );
  } else {
    // 4
    return IconButton(
      icon: Icon(Icons.pause),
      iconSize: 64.0,
      onPressed: player.pause,
    );
  }
}
