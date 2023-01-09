import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/screens/episode_screen.dart';
import 'package:caster/screens/podcast_screen.dart';
import 'package:flutter/material.dart';
// import 'package:podcast_search/podcast_search.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EpisodeFlipCard extends StatelessWidget {
  const EpisodeFlipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                    child: SizedBox(
                      height: 17.h,
                      width: 17.h,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            context.watch<SearchData>().episodePic),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: .3.h),
                            child: Text(
                              context.watch<SearchData>().showTitle,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => PodcastScreen(
                                      showURL:
                                          context.watch<SearchData>().showURL)),
                                ),
                              );
                            },
                            child: const Text('View Show'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              context.watch<SearchData>().episodeTitle,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              context.watch<SearchData>().episodeDescription,
              softWrap: true,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => EpisodeScreen(
                                  showTitle:
                                      context.watch<SearchData>().showTitle,
                                  episodePic:
                                      context.watch<SearchData>().episodePic,
                                  episodeTitle:
                                      context.watch<SearchData>().episodeTitle,
                                  episodeDescription: context
                                      .watch<SearchData>()
                                      .episodeDescription,
                                ))));
                  },
                  child: const Text(
                    'More',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
