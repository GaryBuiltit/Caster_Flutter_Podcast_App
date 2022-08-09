// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecentlyPlayedCard extends StatelessWidget {
  const RecentlyPlayedCard({
    Key? key,
    this.showTitle,
    this.episodeTitle,
    this.episodePic,
  }) : super(key: key);

  final showTitle;
  final episodeTitle;
  final episodePic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.h),
      child: Card(
        elevation: 20,
        child: Row(
          children: [
            Expanded(
              child: Image(
                // height: 20.h,
                // width: 20.w,
                image: NetworkImage(episodePic),
                ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      showTitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      episodeTitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
