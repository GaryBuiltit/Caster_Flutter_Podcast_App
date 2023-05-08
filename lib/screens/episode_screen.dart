// import 'package:caster/screens/podcast_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EpisodeScreen extends StatelessWidget {
  static String id = '/episodeScreen';
  EpisodeScreen(
      {this.episodePic,
      this.episodeDescription,
      this.episodeTitle,
      // this.showHost,
      this.showTitle});

  final String? episodePic;
  final String? episodeTitle;
  final String? showTitle;
  final String? episodeDescription;

  // funtion to check if show image link provided is null or not
  picCheck(pic) {
    if (pic != '') {
      return NetworkImage(pic);
    } else {
      return const AssetImage('assets/images/image_error.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey[100],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.5.h),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                fit: BoxFit.cover,
                                height: 17.h,
                                width: 17.h,
                                image: picCheck(episodePic),
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
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        episodeTitle ?? '',
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Text(
                          episodeDescription ?? '',
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
