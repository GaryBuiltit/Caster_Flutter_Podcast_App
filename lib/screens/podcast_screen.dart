// ignore_for_file: avoid_print

import 'package:caster/utilities/episode_card.dart';
import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:sizer/sizer.dart';
import 'package:async/async.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({Key? key, @required this.showURL}) : super(key: key);
  static String id = '/podcastScreen';
  final String? showURL;

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  bool moreText = false;
  int maxLines = 4;
  String? showPic;
  String? showTitle;
  List<Episode>? episodes;
  String? showDescription;
  String? episodeCount;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

// funcion to fetch podcast data which is ran in initstate
  initData() async {
    return _memoizer.runOnce(() async {
      try {
        var feedData = await Podcast.loadFeed(url: widget.showURL!.toString());
        return feedData;
      } catch (e) {
        print('podcastScreenDataError: $e');
        // throw Exception('podcastScreenDataError: $e');
      }
    });
  }

// funtion to check if show image link provided is null or not
  picCheck(var pic) {
    if (pic != '') {
      return NetworkImage(pic);
    } else {
      return const AssetImage('assets/images/image_error.jpg');
    }
  }

// funtion to format how the episode lengths are displayed
  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

// function to parse episode and put them in a list
  List<Widget> getEpisodes() {
    List<Widget> episodeList = [];
    for (Episode episode in episodes ?? []) {
      try {
        var episodeCard = EpisodeCard(
          showURL: widget.showURL.toString(),
          episodeImage: episode.imageUrl,
          showTitle: showTitle.toString(),
          showImage: showPic.toString(),
          episodeTitle: episode.title,
          episodeDescription: episode.description,
          episodeURL: episode.contentUrl!,
          episodeLen: formatDuration(episode.duration ??
              const Duration(
                hours: 0,
                minutes: 0,
                seconds: 0,
              )),
        );
        episodeList.add(episodeCard);
      } catch (e) {
        print("Error creating episode card: $e");
      }
    }
    return episodeList;
  }

// function to toggle between show description summary and full description
  toggleDescription() {
    if (moreText == false) {
      setState(() {
        moreText = true;
      });
      return;
    }
    if (moreText == true) {
      setState(() {
        moreText = false;
      });
      return;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await initData().then((value) {
          setState(() {
            showPic = value.image ?? '';
            showTitle = value.title ?? '';
            showDescription = value.description ?? '';
            episodes = value.episodes ?? [];
            episodeCount =
                value.episodes != null ? value.episodes?.length.toString() : '';
          });
        });
      } catch (e) {
        print('initPodScreenError: $e');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey[100],
        ),
        body: FutureBuilder(
          future: initData(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 3.h),
                                child: SizedBox(
                                  height: 21.h,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image(
                                              fit: BoxFit.cover,
                                              height: 17.h,
                                              width: 17.h,
                                              image: picCheck(showPic)
                                              // NetworkImage    (showPic ?? ''),
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 2.w),
                                          child: Text(
                                            showTitle!,
                                            maxLines: 2,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                showDescription.toString(),
                                maxLines: moreText == true ? null : maxLines,
                                softWrap: true,
                                overflow: moreText == true
                                    ? null
                                    : TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            toggleDescription();
                          },
                          child: Text(
                            moreText == false ? 'More' : 'Less',
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Text(
                            '$episodeCount episodes',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Column(
                        children: getEpisodes(),
                      ),
                    ],
                  ),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }
}

// these 2 function were my attempt to toggle the need for  more button if maxlines is exceeded or not

// toggleMoreButton() {
//   return LayoutBuilder(
//     builder: ((context, size) {
//       var span = TextSpan(
//         text: showDescription,
//       );

//       var tp = TextPainter(
//         maxLines: maxLines,
//         text: span,
//       );

//       tp.layout(maxWidth: size.maxWidth);

//       bool exceeded = tp.didExceedMaxLines;

//       return exceeded
//           ? Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   toggleDescription();
//                 },
//                 child: Text.rich(
//                   span,
//                 ),
//                 // Text(
//                 //   moreText == false ? 'More' : 'Less',
//                 //   style: const TextStyle(
//                 //     color: Colors.blue,
//                 //   ),
//                 // ),
//               ),
//             )
//           : const SizedBox();
//     }),
//   );
// }

// toggleMoreButton() {
//   if (exceedMaxLines() == true) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: () {
//           toggleDescription();
//         },
//         child: Text(
//           moreText == false ? 'More' : 'Less',
//           style: TextStyle(
//             color: Colors.blue,
//           ),
//         ),
//       ),
//     );
//   }

//   if (exceedMaxLines() == false) {
//     return SizedBox();
//   }
// }
