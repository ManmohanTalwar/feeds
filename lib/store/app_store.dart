import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feeds/helper/app_prefs.dart';
import 'package:feeds/helper/flash_helper.dart';
import 'package:feeds/main.dart';
import 'package:feeds/models/feeds.dart';
import 'package:feeds/services/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoading = false;

  @observable
  FeedEntity? feeds;

  @observable
  ObservableList<FeedData>? searchedFeeds;

  @computed
  List<FeedData>? get feedList => feeds == null
      ? null
      : feeds != null && feeds!.rows != null && feeds!.rows!.isNotEmpty
          ? feeds!.rows!
          : [];

  @action
  Future<void> init() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      checkConnection();
    });
    checkConnection();
    getFeeds();
  }

  Future<void> checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    locator<AppPrefs>().isNetworkError.setValue(!result);
    if (result) {
      getFeeds();
    }
  }

  @action
  Future<void> searchFeed({required String query}) async {
    searchedFeeds = null;
    searchedFeeds = ObservableList<FeedData>();
    log('query -> $query ${feedList?.length}');
    feedList?.forEach((data) {
      log('title -> ${data.title} --query -> ${query} CONTAINS -> ${data.title != null && data.title!.toLowerCase().contains(query.toLowerCase())}');
      if (data.title != null &&
          data.title!.toLowerCase().contains(query.toLowerCase())) {
        searchedFeeds!.add(data);
      }
    });
    log('searched -> $query ${searchedFeeds?.length}');
    log('searched -> $query ${searchedFeeds?.map((element) => element.title).toList()}');
  }

  @action
  Future<void> getFeeds() async {
    final FeedEntity entity = locator<AppPrefs>().feeds.getValue();
    if (entity.title != null && entity.title!.isNotEmpty) {
      feeds ??= entity;
    }
    final response = await Services().getFeeds();
    if (response.statusCode < 400) {
      final jsonResp = json.decode(response.body);
      FeedEntity feed = FeedEntity.fromJson(jsonResp);
      feeds = feed;
    } else {
      FlashHelper.errorBar(message: 'Please try again...');
    }
  }
}
