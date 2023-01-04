// ignore_for_file: prefer_if_null_operators

import 'package:caster/providers/podcast_data.dart';
import 'package:caster/providers/subscribe.dart';
import 'package:caster/screens/podcast_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:webfeed/webfeed.dart';

class ShowCard extends StatelessWidget {
  ShowCard({
    Key? key,
    // required this.showTitle,
    // required this.showPic,
    // this.subscription,
    // this.show,
    this.onLongPress,
    this.onTap,
    required this.showFeed,
  }) : super(key: key);

  // late final String? showPic = ;
  // late String? showTitle = show?.title;
  // final Podcast? show;
  // final Map? subscription;
  final RssFeed showFeed;
  final onLongPress;
  final onTap;
  late var showPic = showFeed.image != null ? showFeed.image?.url : '';

  picCheck(var pic) {
    if (pic != '') {
      return NetworkImage(pic);
    } else {
      return const AssetImage('assets/images/image_error.jpg');
    }
  }

  // inputTypeChecker(String showDetail, String subscriptionDetail) {
  //   if (subscription == null) {
  //     return showDetail;
  //   } else {
  //     return subscriptionDetail;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null
          ? () {
              // PodcastData().getdata(subscription!['showURL']);
              // print(showFeed.itunes!.newFeedUrl);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => PodcastScreen(
                            showURL: showFeed.itunes != null
                                ? showFeed.itunes!.newFeedUrl
                                : '',
                          ))));
            }
          : onTap,
      onLongPress: onLongPress,
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
