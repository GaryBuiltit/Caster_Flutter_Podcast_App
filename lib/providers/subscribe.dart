import 'package:caster/models/subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:caster/utilities/subscription_card.dart';
import 'package:caster/file_manager.dart';

class Subscribe with ChangeNotifier {
  List<Widget> subscriptionCards = [];

  void addSubscription(Podcast show) async {
    List<dynamic> subs = [];
    Map<String, dynamic> subscription =
        Subscription(show.image!, show.title!, show.url!).toJson();
    var subdata = await FileManager().readFile();

    if (subdata != null) {
      try {
        subs = subdata['subscriptions'];
        subs.add(subscription);
        Map<String, List<dynamic>> subFileFormat = {"subscriptions": subs};
        await FileManager().writeToFile(subFileFormat);
      } catch (e) {
        print('addSubscriptonError: $e');
      }
    } else {
      try {
        subs.add(subscription);
        Map<String, List<dynamic>> subFileFormat = {"subscriptions": subs};
        await FileManager().writeToFile(subFileFormat);
      } catch (e) {
        print('error while adding sub: $e');
      }
    }
    makeSubCards();
    notifyListeners();
  }

  unsubscribe(String showTitle) async {
    List<dynamic> subList = [];
    var subdata = await FileManager().readFile();
    subList = subdata['subscriptions'];
    for (var sub in subList) {
      var subscription = sub as Map;
      if (subscription['showTitle'] == showTitle) {
        // int subIndex = subList.indexOf(sub);
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
      for (var subscriptionData in subList) {
        var subscription = subscriptionData as Map;
        // print(subscription);
        var showPic = subscription['showPic'];
        var showTitle = subscription['showTitle'];
        var subcard = SubscriptionCard(
          showTitle: showTitle,
          showPic: showPic,
        );
        subscriptionCards.add(subcard);
      }
      print(subscriptionCards.length);
      notifyListeners();
    }
  }
}
