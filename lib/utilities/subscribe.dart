import 'package:flutter/cupertino.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:caster/utilities/subscription_card.dart';

class Subscribe with ChangeNotifier {
  List<Podcast> rawSubscriptions = [];

  void addSubscription(Podcast show) {
    rawSubscriptions.add(show);
  }

  List<Widget> addsubscriptionCard() {
    List<Widget> subscriptionCards = [];
    for (var subscription in rawSubscriptions) {
      var showTitle = "Test Title";
      var showPic =
          'https://media.istockphoto.com/photos/photo-depicting-the-person-who-focuses-on-the-target-picture-id1249041775?b=1&k=20&m=1249041775&s=170667a&w=0&h=Pt6ltIPqpMrceX3FCtAEg69BjzrRJv4ZWh0n5rr3Uqs=';
      var subscriptionCard = SubscriptionCard(
        showTitle: showTitle,
        showPic: showPic,
      );
      subscriptionCards.add(subscriptionCard);
    }
    return subscriptionCards;
  }
}
