// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/utilities/player_controls.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:just_audio/just_audio.dart';

class PlayerControlsToggle extends StatelessWidget {
  PlayerControlsToggle({Key? key, this.episodePic}) : super(key: key);

  final player = AudioPlayerController().player;
  final playerState = AudioPlayerController().player.processingState;
  final episodePic;

  @override
  Widget build(BuildContext context) {
    // final ProcessingState processingState = playerState!.processingState;
    return Container(
      child: player.playing == true || playerState == ProcessingState.ready
          ? Row(
              children: [
                Expanded(
                  child: Image(
                    image: NetworkImage(episodePic),
                  ),
                ),
                PlayerControls(),
              ],
            )
          : const SizedBox(),
    );
  }
}

// Widget playerControl(PlayerState? playerState, AudioPlayer player) {
//   final processingState = playerState?.processingState;
//   if (processingState == ProcessingState.loading ||
//       processingState == ProcessingState.buffering) {
//     // 2
//     return Container(
//       margin: EdgeInsets.all(8.0),
//       width: 64.0,
//       height: 64.0,
//       child: CircularProgressIndicator(),
//     );
//   } else if (player.playing != true) {
//     // 3
//     return IconButton(
//       icon: Icon(Icons.play_arrow),
//       iconSize: 64.0,
//       onPressed: player.play,
//     );
//   } else {
//     // 4
//     return IconButton(
//       icon: Icon(Icons.pause),
//       iconSize: 64.0,
//       onPressed: player.pause,
//     );
//   }
// }
