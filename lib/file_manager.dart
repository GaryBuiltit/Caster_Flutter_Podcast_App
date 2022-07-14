import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<File> get _localeFile async {
    final directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    return File("$path/caster.json");
  }

  writeToFile(Map<String, List> json) async {
    File file = await _localeFile;
    try {
      file.writeAsString(jsonEncode(json));
    } catch (e) {
      print('writeFileError: $e');
    }
  }

  readFile() async {
    File file = await _localeFile;
    String fileData = '';
    if (await file.exists()) {
      try {
        fileData = await file.readAsString();
        return jsonDecode(fileData);
      } catch (e) {
        print('readFileError: $e');
      }
    } else {
      print("file don't exist");
    }
    return null;
  }
}
