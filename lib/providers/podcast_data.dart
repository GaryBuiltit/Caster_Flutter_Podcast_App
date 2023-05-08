// import 'package:flutter/material.dart';

import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class PodcastData {
  getdata(String url) async {
    RssFeed rssFeed;
    try {
      var feedresponse = await http.get(Uri.parse(url));
      rssFeed = RssFeed.parse(feedresponse.body);
      // print(rssFeed.title);
      return rssFeed;
    } catch (e) {
      print('ErrorParsingRssFeed: $e');
    }
  }
}
