import 'package:feeds/helper/app_constants.dart';
import 'package:flutter/material.dart';

extension ContextExtentions on BuildContext {
  double getHeight() => MediaQuery.of(this).size.height;
  double getWidth() => MediaQuery.of(this).size.width;
  MediaQueryData getQuery() => MediaQuery.of(this);

  Color white() => AppConstants.white;
  Color black() => AppConstants.black;
  Color primaryColor() => AppConstants.primaryColor;
  Color primaryColorLight() => const Color(0xff7457C4);
  Color subTitleColor() => const Color(0xff959595);
  Color dividerColor() => const Color(0xfff3f3f3);
  Color greyTextColor() => const Color(0xffD5D4D5);
  Color greenTextColor() => textGreenColor;
  Color darkTextColor() => const Color(0xff8f8f91);
  Color greyBgColor() => const Color(0xfff8f8f8);
  Color tealColor() => const Color(0xffD6F1E2);
  Color accentColor() => AppConstants.accentColor;
  Color greenColor() => const Color(0xff49C830);
  TextStyle customStyle({
    FontWeight? fontWeight,
    Color? color,
    double? size,
    TextDecoration? decoration,
    FontStyle? style,
  }) =>
      AppConstants.customNormal(
        color: color,
        size: size,
        weight: fontWeight,
        style: style,
      );
  TextStyle customFont({
    FontWeight? fontWeight,
    Color? color,
    double? size,
    TextDecoration? decoration,
  }) =>
      AppConstants.customNormal(
        color: color,
        size: size,
        weight: fontWeight,
      );
}

extension StringExtensions on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension Capitalized on String {
  String capitalized() =>
      substring(0, 1).toUpperCase() + substring(1).toLowerCase();
}
