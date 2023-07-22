import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:flutter/material.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'caster.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE recent_tracks(id INTEGER PRIMARY KEY, show_title TEXT NOT NULL, show_url TEXT NOT NULL, show_image TEXT NOT NULL, episode_title TEXT NOT NULL,episode_description TEXT NOT NULL, episode_length INTEGER NOT NULL, episode_image TEXT NOT NULL, episode_url TEXT NOT NULL, current_position INTEGER)",
        );

        await db.execute(
          "CREATE TABLE subscriptions(id INTEGER PRIMARY KEY, show_title TEXT NOT NULL, show_url TEXT NOT NULL, show_image TEXT NOT NULL)",
        );
      },
    );
  }
}
