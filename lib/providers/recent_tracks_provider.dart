import 'package:caster/file_manager.dart';
import 'package:caster/models/recent_track.dart';
import 'package:caster/utilities/recently_played_card.dart';
import 'package:flutter/material.dart';

class RecentTrackProvider extends ChangeNotifier {
  List<Widget> recentCards = [];

  void addRecentTrack(newTrack) async {
    List<dynamic> tracks = [];
    var recents = FileManager().readRecentsFile();
    if (recents != null) {
      try {
        tracks = recents['tracks'];
        tracks.add(newTrack);
        Map<String, List<dynamic>> recentsFileFormat = {
          "recent tracks": tracks
        };
        await FileManager().writeToFile(recentsFileFormat);
      } catch (e) {
        print('AddRecentTrackError: $e');
      }
    } else {
      try {
        tracks.add(newTrack);
        Map<String, List<dynamic>> recentsFileFormat = {
          "recent tracks": tracks
        };
        await FileManager().writeToFile(recentsFileFormat);
      } catch (e) {
        print('error while adding recent track: $e');
      }
    }
    makeRecentCards();
    // notifyListeners();
  }

  makeRecentCards() async {
    var recents = await FileManager().readFile();
    if (recents != null) {
      recentCards.clear();
      List<dynamic> recentsList = recents['recent tracks'];
      for (var recentsData in recentsList) {
        Map recentTrack = recentsData as Map;
        String episodePic = recentTrack['episodePic'];
        String episodeTitle = recentTrack['episodeTitle'];
        String showTitle = recentTrack['showTitle'];
        var recentCard = RecentlyPlayedCard(
          episodePic: episodePic,
          episodeTitle: episodeTitle,
          showTitle: showTitle,
        );
        recentCards.add(recentCard);
      }
      notifyListeners();
    }
  }
}
