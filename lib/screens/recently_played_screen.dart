// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:caster/providers/recent_tracks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({Key? key}) : super(key: key);

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[400],
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Recently played Episodes'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 2.h),
                  itemCount:
                      context.watch<RecentTrackProvider>().recentCards.length,
                  itemBuilder: (context, index) =>
                      context.watch<RecentTrackProvider>().recentCards[index]),
            ),
          ],
        ),
      ),
    );
  }
}
