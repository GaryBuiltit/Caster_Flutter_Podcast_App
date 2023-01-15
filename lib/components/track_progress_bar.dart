// ignore_for_file: prefer_const_constructors

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackProgressBar extends StatelessWidget {
  const TrackProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 15,
        ),
        child: StreamBuilder<PositionData>(
            stream: Provider.of<AudioPlayerController>(context, listen: true)
                .positionDataStream,
            builder: (context, snapshot) {
              final duration = snapshot.data;
              return ProgressBar(
                progress: duration?.position ?? Duration(seconds: 0),
                total: duration?.duration ?? Duration(seconds: 0),
                buffered: duration?.bufferedPosition ?? Duration(seconds: 0),
              );
            }),
      ),
    );
  }
}
