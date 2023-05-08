import 'package:caster/providers/podcast_search_data_provider.dart';
import 'package:caster/screens/main_nav.dart';
// import 'package:caster/utilities/episode_card.dart';
// import 'package:caster/utilities/show_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);
  static String id = '/searchResultsScreen';

// getResults(context)async {
//     await context.read<SearchData>().
//   }

  bool checkSearchStatus(context) {
    bool status =
        Provider.of<SearchData>(context, listen: true).searching == true
            ? true
            : false;
    return status;
  }

  @override
  Widget build(BuildContext context) {
    var resultList =
        Provider.of<SearchData>(context, listen: true).keywordResults;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey[100],
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MainNav(
                        startIndex: 0,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Provider.of<SearchData>(context, listen: true).searching == false
            ? Column(
                children: [
                  Text(
                    'Results',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: resultList.length,
                          itemBuilder: (context, index) {
                            return resultList[index];
                          })),
                ],
              )
            : const Center(
                child: SizedBox(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              ),
      ),
    );
  }
}
