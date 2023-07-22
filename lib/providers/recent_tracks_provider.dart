// import 'package:caster/file_manager.dart';
import 'package:caster/models/recent_track.dart';
import 'package:caster/components/recently_played_card.dart';
import 'package:flutter/material.dart';
import 'package:caster/caster_database.dart';

class RecentTrackProvider extends ChangeNotifier {
  late Duration currentTrackPosition;
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
        episodeLen: episodeLen,
        // episodeLen: episodeLen.runtimeType == Duration
        //     ? formatDuration(episodeLen ??
        //         const Duration(
        //           hours: 0,
        //           minutes: 0,
        //           seconds: 0,
        //         ))
        //     : episodeLen,
        showURL: showURL,
        currentPosition: '0',
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
        // print(trackMaps[i]['episode_length'].toString());
        // print(trackMaps[i]['current_position'].toString());
        recentCards.add(RecentlyPlayedCard(
          episodeImage: trackMaps[i]['episode_image'],
          showTitle: trackMaps[i]['show_title'] ?? '',
          showImage: trackMaps[i]['show_image'] ?? '',
          episodeTitle: trackMaps[i]['episode_title'] ?? '',
          episodeDescription: trackMaps[i]['episode_description'] ?? '',
          episodeURL: trackMaps[i]['episode_url'] ?? '',
          episodeLen: trackMaps[i]['episode_length'].toString(),
          showURL: trackMaps[i]['showURL'] ?? '',
          currentPosition: trackMaps[i]['current_position'].toString(),
        ));
      }
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
    final Map<String, dynamic> trackMapClone = Map.of(track);
    try {
      trackMapClone.update('current_position',
          (value) => currentTrackPosition.inSeconds.toString());
      db.update('recent_tracks', trackMapClone,
          where: 'id = ?', whereArgs: [trackMapClone['id']]);
    } catch (e) {
      print('update track error: $e');
    }
  }
}
