
import 'package:feeds/helper/app_constants.dart';
import 'package:feeds/helper/extension.dart';
import 'package:feeds/main.dart';
import 'package:feeds/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Helper {

  static padding({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      EdgeInsets.symmetric(
        vertical: vertical,
        horizontal: horizontal,
      );

  static paddingOption({
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      );


  static divider({double left = 12.0,
    right = 12.0,
    double thickness = 1.0,
    double height = 2.0,
    Color? color}) =>
      Divider(
        endIndent: left,
        indent: right,
        thickness: thickness,
        height: height,
        color: color ?? AppConstants.black.withOpacity(0.2),
      );

  static setUIOverlayStyle({required Color color, bool dark = false}) {
    if (dark) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: color, statusBarBrightness: Brightness.dark),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
            statusBarColor: color, statusBarBrightness: Brightness.light),
      );
    }
  }

  static bool isRequestSuccess(int? statusCode) {
    return statusCode == 200 || statusCode == 204;
  }

}
  Widget loadingIcon(
      {Color color = AppConstants.primaryColor, bool isFull = false}) =>
      isFull
          ? Container(
        height: locator<NavigationService>()
            .navigatorKey
            .currentContext!
            .getHeight() *
            0.7,
        alignment: Alignment.center,
        child: SpinKitThreeBounce(
          color: color,
          size: 20.0,
        ),
      )
          : SpinKitThreeBounce(
        color: color,
        size: 20.0,
      );