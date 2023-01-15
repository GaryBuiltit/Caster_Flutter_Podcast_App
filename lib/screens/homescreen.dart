// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import

import 'package:caster/providers/audio_player_controller_provider.dart';
import 'package:caster/screens/loading_screen.dart';
import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/screens/search_result_screen.dart';
import 'package:caster/components/player_controls.dart';
import 'package:caster/components/player_controls_toggle.dart';
import 'package:caster/components/show_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";
  // String searchType = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var topShowsList = context.watch<SearchData>().topShows;
    var player =
        Provider.of<AudioPlayerController>(context, listen: true).player;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Image.asset(
            "assets/images/CASTER_LOGO2.png",
            height: 22.h,
          ),
          // actions: [
          //   TextButton(
          //     style: TextButton.styleFrom(
          //       fixedSize: Size(100, 25),
          //     ),
          //     onPressed: () {},
          //     child: Text(
          //       'Just Listen',
          //     ),
          //   )
          // ],
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ***************  Search Section  **************************
              Padding(
                padding: EdgeInsets.only(top: 3.5.h, bottom: 3.5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //  ______________Mode Selection___________
                    Text('Mode:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              context.read<SearchData>().searchType =
                                  'discovery';
                            });
                          },
                          child: Text(
                            'Discovery Shuffle',
                            style: TextStyle(
                              color: context.read<SearchData>().searchType ==
                                      'discovery'
                                  ? Colors.black
                                  : Colors.blue,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              context.read<SearchData>().searchType = 'search';
                            });
                          },
                          child: Text(
                            'Search',
                            style: TextStyle(
                              color: context.read<SearchData>().searchType ==
                                      'search'
                                  ? Colors.black
                                  : Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ____________textfield_______________
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SizedBox(
                          height: 7.h,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.done,
                            onChanged: (text) {
                              setState(
                                () {
                                  searchText = text;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    // ________Search/Discovery Button____________
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[400],
                            elevation: 10,
                            padding: EdgeInsets.only(right: 10.w, left: 5.w)),
                        onPressed: () {
                          context.read<SearchData>().currentSearch = searchText;
                          if (context.read<SearchData>().searchType ==
                              'search') {
                            context.read<SearchData>().keywordSearch(context);
                            // context.read<SearchData>().listenNotesSearch();
                            Navigator.pushNamed(
                                context, SearchResultsScreen.id);
                          }
                          if (context.read<SearchData>().searchType ==
                              'discovery') {
                            if (player.playing) {
                              player.stop();
                            }
                            context.read<AudioPlayerController>().playType =
                                'discovery';

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoadingScreen(),
                              ),
                            );
                            // Future.delayed(Duration.zero, () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => LoadingScreen(),
                            //     ),
                            //   );
                            // });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: context.read<SearchData>().searchType ==
                                  'discovery'
                              ? Text(
                                  'Discover Something New',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                )
                              : Text(
                                  'Search',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ****************** Popular shows Section *****************
              Text(
                'Popular Now',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 15),
                  height: 175,
                  // width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: topShowsList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return topShowsList[index];
                      })
                  // ListView(
                  //   padding: EdgeInsets.symmetric(horizontal: 5),
                  //   scrollDirection: Axis.horizontal,
                  //   children: context.watch<SearchData>().topShows,
                  // ),
                  ),
              // ****************** Genres Section ********************
              Text(
                'Explore by Genre',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Wrap(
                  spacing: 3.h,
                  children: Provider.of<SearchData>(context).getGenres(context),
                  direction: Axis.horizontal,
                ),
              )
              // PlayerControlsToggle(
              //   player: player,
              //   // playerState: player.playerState
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
