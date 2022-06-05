// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import

import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/screens/loading_screen.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/utilities/nav_menu.dart';
import 'package:caster/utilities/player_controls.dart';
import 'package:caster/utilities/player_controls_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    var player =
        Provider.of<AudioPlayerController>(context, listen: true).player;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(),
                child: Image.asset("assets/images/CASTER LOGO.png"),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: TextField(
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.done,
                        onChanged: (text) {
                          setState(() {
                            searchText = text;
                          });
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange[800],
                          elevation: 15,
                          padding: EdgeInsets.only(right: 40, left: 20)),
                      onPressed: () async {
                        if (player.playing) {
                          player.stop();
                        }
                        context.read<SearchData>().currentSearch = searchText;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoadingScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Start Casting',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // PlayerControlsToggle(
            //   player: player,
            //   // playerState: player.playerState
            // ),
          ],
        ),
      ),
    );
  }
}
