import 'dart:async';
import 'dart:developer';

import 'package:feeds/helper/app_prefs.dart';
import 'package:feeds/injection.dart';
import 'package:feeds/presentation/screens/static_splashscreen.dart';
import 'package:feeds/routes/route_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feeds/services/navigation_service.dart';
import 'package:feeds/store/app_store.dart';
import 'package:provider/provider.dart';
import 'services/services.dart';

class AppInit extends StatefulWidget {
  final String? onNext;

  const AppInit({Key? key, this.onNext}) : super(key: key);

  @override
  State<AppInit> createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  bool? hidePopUp;
  late AppPrefs prefs;

  @override
  void initState() {
    super.initState();
    hidePopUp = false;
    loadInitData();
  }

  void hideNotification(bool value) {
    setState(() {
      hidePopUp = value;
    });
  }

  Future loadInitData() async {
    try {
      /// Load App model config
      prefs = locator<AppPrefs>();
      Services().setAppServices();
      await Future.delayed(
        Duration.zero,
        () async {
          context.read<AppStore>().getFeeds();
        },
      );
    } catch (e, trace) {
      log(e.toString());
      log(trace.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StaticSplashScreen(
      duration: 3000,
      isLottie: true,
      onNextScreen: onNextScreen(),
    );
  }

  String onNextScreen() {
    return RouteList.home;
  }
}
