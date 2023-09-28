import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:feeds/helper/app_prefs.dart';
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
  ObservableList<String> jokes = ObservableList<String>();

  ScrollController scrollController = ScrollController();

  CountDownController countController = CountDownController();

  @action
  Future<void> init() async {
    getFeeds();
    countController.restart(duration: 60);
  }

  void scroll() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @action
  Future<void> getFeeds() async {
    final jsonData = locator<AppPrefs>().jokes.getValue();
    if (jokes.isEmpty) {
      jokes.addAll(jsonData.values.toList().map((e) => e.toString()).toList());
      scroll();
    }
    final response = await Services().getFeeds();
    countController.restart(duration: 60);
    if (response.statusCode < 400) {
      final jsonResp = json.decode(response.body);
      Feeds joke = Feeds.fromJson(jsonResp);
    } else {
      FlashHelper.errorBar(message: 'Please try again...');
    }
  }
}
