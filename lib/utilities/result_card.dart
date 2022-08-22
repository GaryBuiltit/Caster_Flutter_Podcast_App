// import 'package:caster/screens/episode_screen.dart';
import 'package:caster/screens/podcast_screen.dart';
import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';
// import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:webfeed/webfeed.dart';

class ResultCard extends StatelessWidget {
  static String id = '/podcastSreen';
  ResultCard({
    Key? key,
    required this.showFeed,
  }) : super(key: key);
  final RssFeed showFeed;
  late final String? showImage = showFeed.image!.url;
  late final String? showTitle = showFeed.title;
  // late String? showHost = show.;
  // String episodeTitle;
  late final String? showDescription = showFeed.description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => PodcastScreen(
                              showURL: showFeed.itunes?.newFeedUrl,
                            ))));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: .8.h),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            fit: BoxFit.cover,
                            height: 13.h,
                            width: 13.h,
                            image: NetworkImage(showImage ?? ''),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Text(
                              showTitle ?? '',
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    showDescription ?? '',
                    softWrap: true,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
