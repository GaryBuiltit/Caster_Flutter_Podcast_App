import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
// ********** methods to manage file for subscriptions ************
// gets the local file to store subscriptions
  Future<File> get _localeSubFile async {
    final directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    return File("$path/caster_subsciptions.json");
  }

// writes to json file for subscriptions
  writeToFile(Map<String, List> json) async {
    File file = await _localeSubFile;
    try {
      file.writeAsString(jsonEncode(json));
    } catch (e) {
      print('writeSubsFileError: $e');
    }
  }

// reads json file for subscriptions
  readFile() async {
    File file = await _localeSubFile;
    String fileData = '';
    if (await file.exists()) {
      try {
        fileData = await file.readAsString();
        return jsonDecode(fileData);
      } catch (e) {
        print('readSubsFileError: $e');
      }
    } else {
      print("Subs file don't exist");
    }
    return null;
  }

// ******* methods to mange file for recently played tracks *******

// gets file for recently played tracks
  Future<File> get _localeRecentsFile async {
    final directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    return File("$path/caster_recently_played.json");
  }

// writes to json file for recently played tracks
  writeRecentsToFile(Map<String, List> json) async {
    File file = await _localeRecentsFile;
    try {
      file.writeAsString(jsonEncode(json));
    } catch (e) {
      print('writeRecentsFileError: $e');
    }
  }

  // reads json file for recently played tracks
  readRecentsFile() async {
    File file = await _localeRecentsFile;
    String fileData = '';
    if (await file.exists()) {
      try {
        fileData = await file.readAsString();
        return jsonDecode(fileData);
      } catch (e) {
        print('readRecentsFileError: $e');
      }
    } else {
      print("Recents file don't exist");
    }
    return null;
  }
}
