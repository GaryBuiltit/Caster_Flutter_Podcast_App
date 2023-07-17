// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/screens/episode_screen.dart';
import 'package:caster/screens/main_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';

class RecentlyPlayedCard extends StatelessWidget {
  static String id = '/podcastSreen';
  const RecentlyPlayedCard({
    Key? key,
    required this.episodeImage,
    required this.showTitle,
    required this.showImage,
    required this.episodeTitle,
    required this.episodeDescription,
    required this.episodeURL,
    required this.episodeLen,
    required this.showURL,
  }) : super(key: key);
  final String? episodeImage;
  final String showTitle;
  final String showImage;
  final String episodeTitle;
  final String episodeDescription;
  final String episodeURL;
  final String episodeLen;
  final String showURL;

  picCheck(pic) {
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
                        builder: ((context) => EpisodeScreen(
                              episodePic: episodeImage ?? showImage,
                              episodeTitle: episodeTitle,
                              episodeDescription: episodeDescription,
                            ))));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            fit: BoxFit.cover,
                            height: 13.h,
                            width: 13.h,
                            image: picCheck(episodeImage ?? showImage),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Text(
                              episodeTitle,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    episodeDescription,
                    softWrap: true,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                fixedSize: Size(34.w, 4.h),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                context.read<AudioPlayerController>().playType = 'normal';

                context.read<SearchData>().normalPlayVariableSet(
                    showTitle: showTitle,
                    showPic: showImage,
                    episodeTitle: episodeTitle,
                    episodePic: episodeImage ?? showImage,
                    episodeURL: episodeURL,
                    episodeLen: episodeLen,
                    episodeDescription: episodeDescription,
                    showURL: showURL);

                context.read<AudioPlayerController>().initPlayer(
                      episodeURL: context.read<SearchData>().episodeURL,
                      episodeTitle:
                          Provider.of<SearchData>(context, listen: false)
                              .episodeTitle,
                      showTitle: Provider.of<SearchData>(context, listen: false)
                          .showTitle,
                      showPic: Provider.of<SearchData>(context, listen: false)
                          .showPic,
                    );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MainNav(
                        startIndex: 2,
                      );
                    },
                  ),
                );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => LoadingScreen(),
                //   ),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.play_arrow,
                    size: 3.5.h,
                    color: Colors.black,
                  ),
                  Text(
                    episodeLen,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                    ),
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






// import 'package:caster/providers/podcast_data.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:podcast_search/podcast_search.dart';

// class RecentlyPlayedCard extends StatelessWidget {
//   RecentlyPlayedCard({
//     Key? key,
//     required this.showURL,
//     required this.showFeed
//   }) : super(key: key);

//   final String showURL;
//   final Podcast showFeed;
//   late String showTitle;
//   late String episodeTitle;
//   late String episodePic;

  

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(1.h),
//       child: Card(
//         elevation: 20,
//         child: Row(
//           children: [
//             Expanded(
//               child: Image(
//                 // height: 20.h,
//                 // width: 20.w,
//                 image: NetworkImage(episodePic),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 1.w),
//                     child: Text(
//                       showTitle,
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 1.w),
//                     child: Text(
//                       episodeTitle,
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
