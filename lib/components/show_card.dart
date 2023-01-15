// ignore_for_file: prefer_if_null_operators, prefer_typing_uninitialized_variables

// import 'package:caster/providers/podcast_data.dart';
// import 'package:caster/providers/subscribe.dart';
import 'package:caster/providers/subscribe.dart';
import 'package:caster/screens/podcast_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
// import 'package:podcast_search/podcast_search.dart';
import 'package:webfeed/webfeed.dart';

class ShowCard extends StatelessWidget {
  ShowCard({
    Key? key,
    // required this.showTitle,
    // required this.showPic,
    // this.subscription,
    // this.show,
    this.subscriptionCard = false,
    this.onLongPress,
    this.onTap,
    required this.showFeed,
    required this.showURL,
  }) : super(key: key);

  final String showURL;
  final RssFeed showFeed;
  final onLongPress;
  final subscriptionCard;
  final onTap;
  late var showPic = showFeed.image != null ? showFeed.image?.url : '';

  picCheck(var pic) {
    if (pic != '') {
      return NetworkImage(pic);
    } else {
      return const AssetImage('assets/images/image_error.jpg');
    }
  }

  unsubscribe(context) {
    if (subscriptionCard == true) {
      return showDialog(
        context: (context),
        builder: (context) => AlertDialog(
          content: Text('Unsubscribe from ${showFeed.title}'),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<Subscribe>(context, listen: false)
                      .unsubscribe(showURL);
                  Navigator.pop(context);
                },
                child: const Text('Unsubscribe'),
              ),
            )
          ],
        ),
      );
    } else {
      return Null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => PodcastScreen(
                            showURL: showURL,
                          ))));
            }
          : onTap,
      onLongPress: () => unsubscribe(context),
      child: SizedBox(
        height: 150,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                image: picCheck(showPic),
                // NetworkImage(showPic ?? ''),
              ),
            ),
            SizedBox(
              height: .3.h,
            ),
            Expanded(
              child: Text(
                showFeed.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
