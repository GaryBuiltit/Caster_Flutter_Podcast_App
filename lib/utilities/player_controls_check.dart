// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:caster/utilities/player_controls.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

class PlayerControlsToggle extends StatelessWidget {
  const PlayerControlsToggle(
      {Key? key, this.player, this.playerState, this.episodePic})
      : super(key: key);

  final player;
  final playerState;
  final episodePic;

  @override
  Widget build(BuildContext context) {
    // final ProcessingState processingState = playerState!.processingState;
    return Container(
      child: player?.playing == true
          // || processingState == ProcessingState.ready
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
