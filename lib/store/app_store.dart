import 'dart:async';
import 'dart:convert';

import 'package:feeds/helper/app_prefs.dart';
import 'package:feeds/helper/extension.dart';
import 'package:feeds/helper/flash_helper.dart';
import 'package:feeds/main.dart';
import 'package:feeds/models/feeds.dart';
import 'package:feeds/services/services.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoading = false;

  @observable
  FeedEntity? feeds;

  @action
  Future<void> init() async {
    getFeeds();
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
