import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/screens/homescreen.dart';
import 'package:caster/screens/play_screen.dart';
import 'package:caster/screens/recently_played_screen.dart';
import 'package:caster/screens/subscriptions_screen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'nav_item.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var playerController =
        Provider.of<AudioPlayerController>(context, listen: false);

    Widget showPlayerIcon(PlayerState? playerState) {
      var processingState = playerState?.processingState;
      if (playerController.player.playing ||
          processingState == ProcessingState.ready ||
          processingState == ProcessingState.buffering ||
          processingState == ProcessingState.loading) {
        return NavItem(
          //Player Screen
          icon: const Icon(Icons.speaker),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayScreen(),
              ),
            );
          },
        );
      } else {
        return const SizedBox();
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.orange[800],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NavItem(
            //Search screen
            icon: const Icon(Icons.search),
            onPressed: () {
              // playerContoller.stop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          NavItem(
            // Recentley played
            icon: const Icon(Icons.track_changes),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecentlyPlayedScreen(),
                ),
              );
            },
          ),
          StreamBuilder<PlayerState>(
              stream: playerController.player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                return showPlayerIcon(playerState);
              }),
          NavItem(
            //Subscription Screen
            icon: const Icon(Icons.subscriptions),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubscriptionsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
