import 'package:caster/file_manager.dart';
import 'package:caster/models/recent_track.dart';
// import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/utilities/recently_played_card.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class RecentTrackProvider extends ChangeNotifier {
  List<Widget> recentCards = [];

  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void addRecentTrack(
      {episodeImage,
      showTitle,
      showImage,
      episodeTitle,
      episodeDescription,
      episodeURL,
      episodeLen,
      showURL}) async {
    List<dynamic> tracks = [];
    var recents = await FileManager().readRecentsFile();
    if (recents != null) {
      try {
        tracks = recents['recent tracks'];
        RecentTrack newtrack = RecentTrack(
          episodeImage: episodeImage,
          showTitle: showTitle,
          showImage: showImage,
          episodeTitle: episodeTitle,
          episodeDescription: episodeDescription,
          episodeURL: episodeURL,
          episodeLen: episodeLen.runtimeType == Duration
              ? formatDuration(episodeLen ??
                  const Duration(
                    hours: 0,
                    minutes: 0,
                    seconds: 0,
                  ))
              : episodeLen,
          showURL: showURL,
        );
        tracks.add(newtrack);
        Map<String, List<dynamic>> recentsFileFormat = {
          "recent tracks": tracks
        };
        await FileManager().writeRecentsToFile(recentsFileFormat);
      } catch (e) {
        print('AddRecentTrackError: $e');
      }
    } else {
      try {
        RecentTrack newtrack = RecentTrack(
          episodeImage: episodeImage,
          showTitle: showTitle,
          showImage: showImage,
          episodeTitle: episodeTitle,
          episodeDescription: episodeDescription,
          episodeURL: episodeURL,
          episodeLen: episodeLen,
          showURL: showURL,
        );
        tracks.add(newtrack);
        Map<String, List<dynamic>> recentsFileFormat = {
          "recent tracks": tracks
        };
        await FileManager().writeRecentsToFile(recentsFileFormat);
      } catch (e) {
        print('error while adding recent track: $e');
      }
    }
    makeRecentCards();
    // notifyListeners();
  }

  makeRecentCards() async {
    var recents = await FileManager().readRecentsFile();
    if (recents != null) {
      recentCards.clear();
      List<dynamic> recentsList = recents['recent tracks'];
      for (var recentTrack in recentsList) {
        var trackMap = recentTrack as Map;
        try {
          String episodeImage = trackMap['episodeImage'];
          String showTitle = trackMap['showTitle'];
          String showImage = trackMap['showImage'];
          String episodeTitle = trackMap['episodeTitle'];
          String episodeDescription = trackMap['episodeDescription'];
          String episodeURL = trackMap['episodeURL'];
          String episodeLen = trackMap['episodeLen'];
          String showURL = trackMap['showURL'];

          var recentCard = RecentlyPlayedCard(
            episodeImage: episodeImage,
            showTitle: showTitle,
            showImage: showImage,
            episodeTitle: episodeTitle,
            episodeDescription: episodeDescription,
            episodeURL: episodeURL,
            episodeLen: episodeLen,
            showURL: showURL,
          );
          recentCards.add(recentCard);
        } catch (e) {
          print('Error creating recents card: $e');
        }
      }
      notifyListeners();
    }
  }
}
