import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class TrackInfo extends StatelessWidget {
  const TrackInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: SizedBox(
              // width: 200,
              height: 50,
              child: Marquee(
                  velocity: 25,
                  text: context.watch<SearchData>().episodeTitle != null ?context.watch<SearchData>().episodeTitle : '' ,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  )),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                context.watch<SearchData>().showTitle != null?context.watch<SearchData>().showTitle : '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
