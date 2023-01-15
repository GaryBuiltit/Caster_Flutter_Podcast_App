import 'package:caster/screens/podcast_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webfeed/webfeed.dart';

class ResultCard extends StatelessWidget {
  static String id = '/podcastSreen';
  ResultCard({
    Key? key,
    required this.showFeed,
    required this.showURL,
  }) : super(key: key);
  final RssFeed showFeed;
  final String showURL;
  late final String? showImage =
      showFeed.image != null ? showFeed.image!.url : '';
  late final String? showTitle = showFeed.title ?? '';
  late final String? showDescription = showFeed.description ?? '';

  picCheck(var pic) {
    if (pic != '') {
      return NetworkImage(pic);
    } else {
      return const AssetImage('assets/images/image_error.jpg');
    }
  }

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
                              showURL: showURL,
                            ))));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: .8.h),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            fit: BoxFit.cover,
                            height: 13.h,
                            width: 13.h,
                            image: picCheck(showImage),
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
