import 'package:flutter/material.dart';

class AppStyle {
  static BuildContext? _ctx;

  static const kDefaultPagePaddingSides = 0.1;
  static const kDefaultPagePaddingTop = 0.08;
  static const kDefaultPagePaddingBottom = 0.2;

  AppStyle.withTheme(BuildContext ctx) {
    _ctx = ctx;
  }

  EdgeInsets get kDefaultPagePadding => _ctx == null
      ? const EdgeInsets.all(0)
      : EdgeInsets.fromLTRB(
          MediaQuery.of(_ctx!).size.width * kDefaultPagePaddingSides,
          MediaQuery.of(_ctx!).size.height * kDefaultPagePaddingTop,
          MediaQuery.of(_ctx!).size.width * kDefaultPagePaddingSides,
          MediaQuery.of(_ctx!).size.height * kDefaultPagePaddingBottom,
        );
}
