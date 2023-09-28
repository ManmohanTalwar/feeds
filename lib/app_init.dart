import 'dart:async';
import 'dart:developer';

import 'package:feeds/helper/app_prefs.dart';
import 'package:feeds/injection.dart';
import 'package:feeds/presentation/screens/splash/static_splashscreen.dart';
import 'package:feeds/routes/route_list.dart';
import 'package:feeds/store/app_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      /// Load Local Storage config
      prefs = locator<AppPrefs>();

      /// Initialize api service
      Services().setAppServices();
      await Future.delayed(
        Duration.zero,
        () async {
          /// prefetch data
          context.read<AppStore>().init();
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
      duration: 2200,
      isLottie: true,
      onNextScreen: onNextScreen(),
    );
  }

  String onNextScreen() {
    return RouteList.home;
  }
}
