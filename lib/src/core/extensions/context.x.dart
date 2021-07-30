import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_task/all.exports.dart';

extension BuildContextX on BuildContext {
  AppTheme get theme => AppTheme.of(this);

  TextTheme get textTheme => AppTheme.of(this).themeData.textTheme;

  AppLocalizations get local => AppLocalizations.of(this)!;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  TextStyle get headline1 =>
      AppTheme.of(this).themeData.textTheme.headline1 ??
      Typography.whiteMountainView.headline1!;

  TextStyle get headline2 =>
      AppTheme.of(this).themeData.textTheme.headline2 ??
      Typography.whiteMountainView.headline2!;

  TextStyle get headline3 =>
      AppTheme.of(this).themeData.textTheme.headline3 ??
      Typography.whiteMountainView.headline3!;

  TextStyle get headline4 =>
      AppTheme.of(this).themeData.textTheme.headline4 ??
      Typography.whiteMountainView.headline4!;

  TextStyle get headline5 =>
      AppTheme.of(this).themeData.textTheme.headline5 ??
      Typography.whiteMountainView.headline5!;

  TextStyle get headline6 =>
      AppTheme.of(this).themeData.textTheme.headline6 ??
      Typography.whiteMountainView.headline6!;

  TextStyle get bodyText1 =>
      AppTheme.of(this).themeData.textTheme.bodyText1 ??
      Typography.whiteMountainView.bodyText1!;

  TextStyle get bodyText2 =>
      AppTheme.of(this).themeData.textTheme.bodyText2 ??
      Typography.whiteMountainView.bodyText2!;

  TextStyle get subtitle1 =>
      AppTheme.of(this).themeData.textTheme.subtitle1 ??
      Typography.whiteMountainView.subtitle1!;

  TextStyle get subtitle2 =>
      AppTheme.of(this).themeData.textTheme.subtitle2 ??
      Typography.whiteMountainView.subtitle2!;

  TextStyle get caption =>
      AppTheme.of(this).themeData.textTheme.caption ??
      Typography.whiteMountainView.caption!;

  TextStyle get button =>
      AppTheme.of(this).themeData.textTheme.button ??
      Typography.whiteMountainView.button!;

  TextStyle get overline =>
      AppTheme.of(this).themeData.textTheme.overline ??
      Typography.whiteMountainView.overline!;

  void setFocus({FocusNode? node}) {
    if (node == null) {
      FocusScope.of(this).dispose();
      return;
    }
    FocusScope.of(this).requestFocus(node);
  }

  Future showMessage(String message,
      {String title = "Alert!",
      DisplayType type = DisplayType.FLASH,
      DisplayMode mode = DisplayMode.ERROR,
      List<DialogAction>? actions}) {
    switch (type) {
      case DisplayType.ALERT:
        return showDialog(
            context: this,
            builder: (context) {
              return MessageDialogX(
                  title: title,
                  message: message,
                  mode: mode,
                  actions: actions ?? [DialogAction.confirm]);
            });
      case DisplayType.FLASH:
        return showFlash(
          context: this,
          duration: const Duration(seconds: 3),
          builder: (_, controller) {
            return Flash(
              controller: controller,
              brightness: Brightness.dark,
              backgroundColor: getColorByDisplayMode(mode),
              boxShadows: getDefaultBoxShadow(
                  color: [getColorByDisplayMode(mode)],
                  elevation: -5,
                  blurr: 5),
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(bottom: this.isMobile ? 0 : 26.dp),
              forwardAnimationCurve: Curves.easeIn,
              reverseAnimationCurve: Curves.easeOut,
              child: FlashBar(
                title: Text(
                  title,
                  style: this.headline4.white,
                ),
                content: Text(
                  message,
                  style: this.headline5.white,
                ),
              ),
            );
          }, //
        );
    }
  }

  Color getColorByDisplayMode(DisplayMode displayMode) {
    switch (displayMode) {
      case DisplayMode.SUCCESS:
        return Colors.green;
      case DisplayMode.ERROR:
        return Colors.redAccent;
      case DisplayMode.INFO:
        return Colors.cyan;
      case DisplayMode.WARNING:
        return Colors.amber;
    }
  }

  bool get isDesktop => displayMode() == Mode.DESKTOP;

  bool get isTabPortrait => displayMode() == Mode.TABLET_PORTRAIT;

  bool get istabLandscape => displayMode() == Mode.TABLET_LANDSCAPE;

  bool get isMobile => displayMode() == Mode.MOBILE;

  bool get isMobileFriendly =>
      displayMode() == Mode.MOBILE || displayMode() == Mode.TABLET_PORTRAIT;

  Mode displayMode() {
    final width = MediaQuery.of(this).size.width;
    if (width > 1200) {
      return Mode.DESKTOP;
    }

    if (width > 992) {
      return Mode.TABLET_LANDSCAPE;
    }

    if (width > 767) {
      return Mode.TABLET_PORTRAIT;
    }
    return Mode.MOBILE;
  }
}
