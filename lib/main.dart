// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';
// import 'package:caster/screens/loading_screen.dart';
import 'package:caster/screens/main_nav.dart';
// import 'package:caster/screens/play_screen.dart';
// import 'package:caster/screens/recently_played_screen.dart';
// import 'package:caster/screens/subscriptions_screen.dart';
import 'package:caster/utilities/subscribe.dart';
import 'package:flutter/material.dart';
// import 'package:caster/screens/homescreen.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caster',
      theme: ThemeData(
          // primaryColor: Colors.black54,
          // primarySwatch: Colors.blue,
          ),
      home: MainNav(),
      // routes: {
      //   'PlayScreen': (context) => PlayScreen(),
      //   'LoadingScreen': (context) => LoadingScreen(),
      //   'RecentlyPlayed': (context) => RecentlyPlayedScreen(),
      //   'SubscriptionScreen': (context) => SubscriptionsScreen(),
      // },
    );
  }
}
