// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/utilities/nav_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({Key? key}) : super(key: key);

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  List playedShow = [];

  List<Widget> recentTrackCard() {
    List<Widget> recentCards = [];
    for (var show in playedShow) {
      var showTitle = show["Show"];
      var episodeTitle = show["Episode Title"];
      var episodePic = show["Episode Pic"];
      RecentlyPlayedCard newCard = RecentlyPlayedCard(
        showtitle: showTitle,
        episodePic: episodePic,
        episodeTitle: episodeTitle,
      );
      recentCards.add(newCard);
    }
    return recentCards;
  }

  @override
  void initState() {
    playedShow = Provider.of<SearchData>(context, listen: false).recentlyPlayed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[700],
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Recently played Episodes'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text(
            //   "Recently Played Episodes",
            //   style: TextStyle(
            //     fontSize: 30,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            Expanded(
              child: ListView(
                children: recentTrackCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentlyPlayedCard extends StatelessWidget {
  const RecentlyPlayedCard({
    Key? key,
    this.showtitle,
    this.episodeTitle,
    this.episodePic,
  }) : super(key: key);

  final showtitle;
  final episodeTitle;
  final episodePic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        // shape: ,
        elevation: 20,
        child: Row(
          children: [
            Expanded(
              child: Image(image: NetworkImage(episodePic)),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      showtitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      episodeTitle,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
