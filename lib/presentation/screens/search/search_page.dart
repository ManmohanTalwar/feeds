import 'package:feeds/helper/Helper.dart';
import 'package:feeds/helper/extension.dart';
import 'package:feeds/presentation/widgets/feed_card.dart';
import 'package:feeds/presentation/widgets/search_container.dart';
import 'package:feeds/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late AppStore store;
  bool isInitial = true;
  @override
  Widget build(BuildContext context) {
    store = context.watch<AppStore>();
    return Scaffold(
      backgroundColor: context.primaryColorLight(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'Search-Container',
              child: SearchContainer(
                isSearch: true,
                onSearched: (val) {
                  if (val.isEmpty) {
                    setState(() {
                      isInitial = true;
                    });
                  } else {
                    setState(() {
                      isInitial = false;
                    });
                    store.searchFeed(query: val);
                  }
                },
              ),
            ),
            if (!isInitial)
              Flexible(
                child: Observer(builder: (context) {
                  return store.searchedFeeds == null
                      ? loadingIcon(
                          isFull: true,
                        )
                      : store.searchedFeeds != null &&
                              store.searchedFeeds!.isNotEmpty
                          ? ListView.builder(
                              itemCount: store.searchedFeeds!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  store.searchedFeeds![index].isEmpty()
                                      ? const SizedBox.shrink()
                                      : FeedCard(
                                          data: store.searchedFeeds![index],
                                        ).animate().fadeIn(duration: 300.ms),
                            )
                          : const Center(
                              child: Text(
                                'No Result Found',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontFamily: 'Spartan',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                }),
              ).animate().fadeIn(duration: 350.ms).then().slideY(
                    duration: 300.ms,
                    begin: 0.3,
                    end: 0,
                  ),
          ],
        ),
      ),
    );
  }
}
