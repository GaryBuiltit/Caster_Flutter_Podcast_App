import 'package:caster/providers/podcast_data.dart';
import 'package:caster/utilities/episode_card.dart';
import 'package:flutter/material.dart';
// import 'package:podcast_search/podcast_search.dart';
import 'package:sizer/sizer.dart';
import 'package:webfeed/webfeed.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({Key? key, @required this.showURL}) : super(key: key);
  static String id = '/podcastScreen';
  // final RssFeed? showData;
  final String? showURL;

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  @override
  void initState() {
    try {
      showData = initData();
    } catch (e) {
      print('initPodScreenError: $e');
    }
    super.initState();
  }

  RssFeed? showData;

  initData() async {
    try {
      RssFeed data = await PodcastData().getdata(widget.showURL!);
      return data;
    } catch (e) {
      print('podcastScreenDataError: $e');
    }
  }

  // late Podcast show = widget.show!;

  bool moreText = false;
  int maxLines = 4;

  late String? showPic = showData != null ? showData?.image?.url : '';
  late String? showTitle = showData != null ? showData?.title : '';
  late List? episodes = showData != null ? showData?.items : [];
  late String? showHost = showData != null ? showData?.itunes?.author : '';
  late String? showDescription = showData != null ? showData?.description : '';
  late String? episodeCount =
      showData != null ? showData?.items?.length.toString() : '';

  // inputTypeChecker(var showDetail, var subscriptionDetail) {
  //   if (widget.show == null) {
  //     return showDetail;
  //   } else {
  //     return subscriptionDetail;
  //   }
  // }

  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  List<Widget> getEpisodes() {
    List<Widget> episodeList = [];
    for (var episode in showData?.items ?? []) {
      var episodeCard = EpisodeCard(
        episodeImage: episode.itunes!.image?.href,
        showTitle: showTitle ?? '',
        showImage: showPic ?? '',
        episodeTitle: episode.title ?? '',
        episodeDescription: episode.description ?? '',
        episodeURL: episode.media!.contents![0].url ?? '',
        episodeLen: formatDuration(episode.itunes!.duration ??
            const Duration(
              hours: 0,
              minutes: 0,
              seconds: 0,
            )),
      );
      episodeList.add(episodeCard);
    }
    return episodeList;
  }

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 3.h),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                fit: BoxFit.cover,
                                height: 17.h,
                                width: 17.h,
                                image: NetworkImage(showPic ?? ''),
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
                      Text(
                        showDescription!,
                        maxLines: moreText == true ? null : maxLines,
                        softWrap: true,
                        overflow:
                            moreText == true ? null : TextOverflow.ellipsis,
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
