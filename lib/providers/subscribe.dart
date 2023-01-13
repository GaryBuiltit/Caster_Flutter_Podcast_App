// import 'package:caster/models/subscription.dart';

import 'package:caster/providers/podcast_data.dart';
// import 'package:caster/providers/podcast_search_data_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:podcast_search/podcast_search.dart';
import 'package:caster/utilities/show_card.dart';
import 'package:caster/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

class Subscribe with ChangeNotifier {
  List<Widget> subscriptionCards = [];

  void addSubscription(String showURL) async {
    List<dynamic> subs = [];
    // Map<String, dynamic> subscription =
    //     Subscription(show.image!, show.title!, show.url!).toJson();
    var subdata = await FileManager().readFile();
    if (subdata != null) {
      try {
        subs = subdata['subscriptions'];
        subs.add(showURL);
        Map<String, List<dynamic>> subFileFormat = {"subscriptions": subs};
        await FileManager().writeToFile(subFileFormat);
      } catch (e) {
        print('addSubscriptonError: $e');
      }
    } else {
      try {
        subs.add(showURL);
        Map<String, List<dynamic>> subFileFormat = {"subscriptions": subs};
        await FileManager().writeToFile(subFileFormat);
      } catch (e) {
        print('error while adding sub: $e');
      }
    }
    makeSubCards();
    notifyListeners();
  }

  unsubscribe(String showURL) async {
    List<dynamic> subList = [];
    var subdata = await FileManager().readFile();
    subList = subdata['subscriptions'];
    for (var sub in subList) {
      if (sub == showURL) {
        try {
          subList.remove(sub);
          Map<String, List<dynamic>> subFileFormat = {"subscriptions": subList};
          await FileManager().writeToFile(subFileFormat);
          break;
        } catch (e) {
          print('removeSubErro: $e');
        }
      }
    }
    makeSubCards();
  }

  makeSubCards() async {
    var subData = await FileManager().readFile();
    if (subData != null) {
      subscriptionCards.clear();
      List<dynamic> subList = subData['subscriptions'];
      for (var subscription in subList) {
        // var subscription = Subscription.fromJson(subscriptionData);
        // print(subscription);
        // var showPic = subscription['showPic'];
        // var showTitle = subscription.showTitle;
        var showURL = subscription;
        RssFeed showFeed = await PodcastData().getdata(showURL);
        var subcard = InkWell(
          splashColor: Colors.grey,
          child: ShowCard(
            showFeed: showFeed,
            showURL: showURL,
            subscriptionCard: true,
          ),
        );
        subscriptionCards.add(subcard);
      }
      // print(subscriptionCards.length);
      notifyListeners();
    }
  }
}
