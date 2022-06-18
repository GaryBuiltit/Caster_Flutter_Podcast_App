import 'package:flutter/cupertino.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:caster/utilities/subscription_card.dart';

class Subscribe with ChangeNotifier {
  // List<Podcast> rawSubscriptions = [];
  List<Widget> subscriptionCards = [];

  // void addSubscription(Podcast show) {
  //   rawSubscriptions.add(show);
  // }

  void addSubscription(Podcast show) {
    // for (var subscription in rawSubscriptions) {
    // var showTitle = show.title;
    // var showPic = show.image;
    // 'https://media.istockphoto.com/photos/photo-depicting-the-person-who-focuses-on-the-target-picture-id1249041775?b=1&k=20&m=1249041775&s=170667a&w=0&h=Pt6ltIPqpMrceX3FCtAEg69BjzrRJv4ZWh0n5rr3Uqs=';
    var subscriptionCard = SubscriptionCard(
      showTitle: show.title,
      showPic: show.image,
    );
    subscriptionCards.add(subscriptionCard);
    notifyListeners();
    // }
  }
}
