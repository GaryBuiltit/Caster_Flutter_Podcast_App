// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/providers/recent_tracks_provider.dart';
import 'package:caster/screens/episode_screen.dart';
import 'package:caster/screens/main_nav.dart';
import 'package:caster/providers/subscribe.dart';
import 'package:caster/screens/podcast_screen.dart';
import 'package:caster/screens/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchData()),
        ChangeNotifierProvider(create: (_) => AudioPlayerController()),
        ChangeNotifierProvider(create: (_) => Subscribe()),
        ChangeNotifierProvider(create: (_) => RecentTrackProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Subscribe>(context, listen: false).makeSubCards();
    Provider.of<SearchData>(context, listen: false).getPopular();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Sizer(builder: (context, portiat, mobile) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Caster',
          theme: ThemeData(
              // primaryColor: Colors.black54,
              // primarySwatch: Colors.blue,
              ),
          initialRoute: '/',
          routes: {
            '/': (context) => MainNav(),
            '/searchResultsScreen': (context) => SearchResultsScreen(),
            '/podcastScreen': (context) => PodcastScreen(),
            '/episodeScreen': (context) => EpisodeScreen(),
          },
        );
      }),
    );
  }
}
