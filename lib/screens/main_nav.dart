import 'package:audio_service/audio_service.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/screens/homescreen.dart';
import 'package:caster/screens/play_screen.dart';
import 'package:caster/screens/recently_played_screen.dart';
import 'package:caster/screens/subscriptions_screen.dart';
import 'package:caster/components/player_controls_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNav extends StatefulWidget {
  const MainNav({Key? key, this.startIndex = 0}) : super(key: key);
  final int startIndex;

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  late int selectedIndex;

  static List<Widget> screenOptions = [
    HomeScreen(),
    const RecentlyPlayedScreen(),
    PlayScreen(),
    const SubscriptionsScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange[400],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              label: "Recently Played",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.speaker),
              label: "Playing",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions),
              label: "Subscriptions",
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: screenOptions.elementAt(selectedIndex)),
            PlayerControlsToggle(
              episodePic: context.watch<SearchData>().episodePic,
            ),
          ],
        ),
      ),
    );
  }
}
