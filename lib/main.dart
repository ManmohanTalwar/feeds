import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:feeds/helper/app_constants.dart';
import 'package:feeds/helper/app_prefs.dart';
import 'package:feeds/feeds.dart';
import 'package:feeds/services/navigation_service.dart';
import 'package:feeds/services/network_util.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

final GetIt locator = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await setupLocator();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppConstants.primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(const Feeds());
}

Future<void> setupLocator() async {
  final preferences = await StreamingSharedPreferences.instance;
  locator.registerLazySingleton<AppPrefs>(() => AppPrefs(preferences));
  locator.registerLazySingleton<NetworkUtil>(() => NetworkUtil());
  locator.registerLazySingleton(() => NavigationService());
}
