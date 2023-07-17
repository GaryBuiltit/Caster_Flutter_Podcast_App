// import 'package:caster/file_manager.dart';
import 'package:caster/models/recent_track.dart';
import 'package:caster/components/recently_played_card.dart';
import 'package:flutter/material.dart';
import 'package:caster/caster_database.dart';

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

  void insertTrack({
    episodeImage,
    showTitle,
    showImage,
    episodeTitle,
    episodeDescription,
    episodeURL,
    episodeLen,
    showURL,
    completed,
    currentPosition,
  }) async {
    final db = await DataBase().initializedDB();
    final List<Map> tracks = await db.query('recent_tracks');
    try {
      RecentTrack newtrack = RecentTrack(
        id: tracks.isNotEmpty ? tracks.last['id'] + 1 + 0.0 : 1 + 0.0,
        episodeImage: episodeImage ?? '',
        showTitle: showTitle ?? '',
        showImage: showImage ?? '',
        episodeTitle: episodeTitle ?? '',
        episodeDescription: episodeDescription ?? '',
        episodeURL: episodeURL ?? '',
        episodeLen: episodeLen.runtimeType == Duration
            ? formatDuration(episodeLen ??
                const Duration(
                  hours: 0,
                  minutes: 0,
                  seconds: 0,
                ))
            : episodeLen,
        showURL: showURL,
        completed: completed,
        currentPosition: formatDuration(const Duration(
          hours: 0,
          minutes: 0,
          seconds: 0,
        )),
      );

      await db.insert('recent_tracks', newtrack.toMap());
    } catch (e) {
      print('Insert Track Error: $e');
    }
    getTracks();
  }

  void getTracks() async {
    final db = await DataBase().initializedDB();

    final List<Map<String, dynamic>> trackMaps =
        await db.query('recent_tracks');
    recentCards.clear();
    // print(trackMaps.length);
    try {
      for (var i = 0; i < trackMaps.length; i++) {
        // print(trackMaps[i]['show_title']);
        recentCards.add(RecentlyPlayedCard(
          episodeImage: trackMaps[i]['episode_image'],
          showTitle: trackMaps[i]['show_title'] ?? '',
          showImage: trackMaps[i]['show_image'] ?? '',
          episodeTitle: trackMaps[i]['episode_title'] ?? '',
          episodeDescription: trackMaps[i]['episode_description'] ?? '',
          episodeURL: trackMaps[i]['episode_url'] ?? '',
          episodeLen: trackMaps[i]['episode_length'] ?? '',
          showURL: trackMaps[i]['showURL'] ?? '',
        ));
      }

      // List.generate(
      //     trackMaps.length,
      //     (i) => {
      //           print(trackMaps[i]['showTitle']),
      //           // recentCards.add(RecentlyPlayedCard(
      //           //   episodeImage: trackMaps[i]['episodeImage'],
      //           //   showTitle: trackMaps[i]['showTitle'] ?? '',
      //           //   showImage: trackMaps[i]['showImage'] ?? '',
      //           //   episodeTitle: trackMaps[i]['episodeTitle'] ?? '',
      //           //   episodeDescription: trackMaps[i]['episodeDescription'] ?? '',
      //           //   episodeURL: trackMaps[i]['episodeURL'] ?? '',
      //           //   episodeLen: trackMaps[i]['episodeLen'] ?? '',
      //           //   showURL: trackMaps[i]['showURL'] ?? '',
      //           // )),
      //         });
    } catch (e) {
      print('Error getting recents: $e');
    }

    notifyListeners();
  }

  void updateTrack(String showTitle, String episodeTitle) async {
    final db = await DataBase().initializedDB();
    final List<Map<String, dynamic>> tracks = await db.query('recent_tracks');
    final Map<String, dynamic> track = tracks.firstWhere((e) =>
        e['show_title'] == showTitle && e['episode_title'] == episodeTitle);
    track['current_position'] = '';
    db.update('recent_tracks', track,
        where: 'id = ?', whereArgs: [track['id']]);
  }

  // void addRecentTrack(
  //     {episodeImage,
  //     showTitle,
  //     showImage,
  //     episodeTitle,
  //     episodeDescription,
  //     episodeURL,
  //     episodeLen,
  //     showURL}) async {
  //   List<dynamic> tracks = [];
  //   var recents = await FileManager().readRecentsFile();
  //   if (recents != null) {
  //     try {
  //       tracks = recents['recent tracks'];
  //       RecentTrack newtrack = RecentTrack(
  //         episodeImage: episodeImage,
  //         showTitle: showTitle,
  //         showImage: showImage,
  //         episodeTitle: episodeTitle,
  //         episodeDescription: episodeDescription,
  //         episodeURL: episodeURL,
  //         episodeLen: episodeLen.runtimeType == Duration
  //             ? formatDuration(episodeLen ??
  //                 const Duration(
  //                   hours: 0,
  //                   minutes: 0,
  //                   seconds: 0,
  //                 ))
  //             : episodeLen,
  //         showURL: showURL,
  //       );
  //       tracks.add(newtrack);
  //       Map<String, List<dynamic>> recentsFileFormat = {
  //         "recent tracks": tracks
  //       };
  //       await FileManager().writeRecentsToFile(recentsFileFormat);
  //     } catch (e) {
  //       print('AddRecentTrackError: $e');
  //     }
  //   } else {
  //     try {
  //       RecentTrack newtrack = RecentTrack(
  //         episodeImage: episodeImage,
  //         showTitle: showTitle,
  //         showImage: showImage,
  //         episodeTitle: episodeTitle,
  //         episodeDescription: episodeDescription,
  //         episodeURL: episodeURL,
  //         episodeLen: episodeLen,
  //         showURL: showURL,
  //       );
  //       tracks.add(newtrack);
  //       Map<String, List<dynamic>> recentsFileFormat = {
  //         "recent tracks": tracks
  //       };
  //       await FileManager().writeRecentsToFile(recentsFileFormat);
  //     } catch (e) {
  //       print('error while adding recent track: $e');
  //     }
  //   }
  //   makeRecentCards();
  //   // notifyListeners();
  // }

  // makeRecentCards() async {
  //   var recents = await FileManager().readRecentsFile();
  //   if (recents != null) {
  //     recentCards.clear();
  //     List<dynamic> recentsList = await getTracks();
  //     for (var recentTrack in recentsList) {
  //       var trackMap = recentTrack as Map;
  //       try {
  //         String episodeImage = trackMap['episodeImage'];
  //         String showTitle = trackMap['showTitle'];
  //         String showImage = trackMap['showImage'];
  //         String episodeTitle = trackMap['episodeTitle'];
  //         String episodeDescription = trackMap['episodeDescription'];
  //         String episodeURL = trackMap['episodeURL'];
  //         String episodeLen = trackMap['episodeLen'];
  //         String showURL = trackMap['showURL'];

  //         var recentCard = RecentlyPlayedCard(
  //           episodeImage: episodeImage,
  //           showTitle: showTitle,
  //           showImage: showImage,
  //           episodeTitle: episodeTitle,
  //           episodeDescription: episodeDescription,
  //           episodeURL: episodeURL,
  //           episodeLen: episodeLen,
  //           showURL: showURL,
  //         );
  //         recentCards.add(recentCard);
  //       } catch (e) {
  //         print('Error creating recents card: $e');
  //       }
  //     }
  //     notifyListeners();
  //   }
  // }
}
