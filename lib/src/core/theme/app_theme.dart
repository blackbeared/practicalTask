import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

/// The minimum recommended contrast ratio for the visual representation of
/// text.
///
/// See https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html.
const double kTextContrastRatio = 4.5;

/// The minimum recommended contrast ratio for the visual representation of
/// large text.
///
/// See https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html.
const double kLargeTextContrastRatio = 3;

/// The default border radius used throughout the app.
const ShapeBorder kDefaultShapeBorder = RoundedRectangleBorder(
  borderRadius: kDefaultBorderRadius,
);
const BorderRadius kDefaultBorderRadius = BorderRadius.all(kDefaultRadius);
const Radius kDefaultRadius = Radius.circular(16);

class AppTheme {
  AppTheme.fromData({
    required AppThemeData data,
  }) {
    name = data.name;
    backgroundColors =
        data.backgroundColors.map((color) => Color(color)).toList();
    if (backgroundColors.isEmpty) {
      backgroundColors = [Colors.black];
    }
    primaryColor = Color(data.primaryColor);
    secondaryColor = Color(data.secondaryColor);
    statusBarColor = Color(data.statusBarColor);
    navBarColor = Color(data.navBarColor);

    _setupAverageBackgroundColor();
    _setupBrightness();
    _setupCardColor(data.cardColor);
    _setupButtonTextColor();
    _setupErrorColor();
    _setupForegroundColors();
    _setupSystemUiColors();
    _setupTextTheme();
    _setupThemeData();
  }

  // custom theme values
  late String name;
  late List<Color> backgroundColors;
  late Color primaryColor;
  late Color secondaryColor;
  late Color cardColor;
  late Color statusBarColor;
  late Color navBarColor;

  // colors chosen based on their background contrast
  late Color buttonTextColor;
  late Color errorColor;
  late Color favoriteColor;

  Color get infoColor => Color(0xff1aa8e8);

  Color get warningColor => Color(0xffffaa4e);

  Color get successColor => Color(0xff27c795);

  Color get complimentry => darkMode ? Colors.black : Colors.white;

  Color get complimentry10 => darkMode ? Color(0xff212121) : Color(0xfff5f5f5);

  Color get complimentry20 => darkMode ? Color(0xff424242) : Color(0xffEEEEEE);

  Color get complimentry30 => darkMode ? Color(0xff616161) : Color(0xffe0e0e0);

  Color get complimentry40 => darkMode ? Color(0xff757575) : Color(0xffbdbdbd);

  Color get complimentry50 => Color(0xff9e9e9e);

  Color get complimentry60 => darkMode ? Color(0xffbdbdbd) : Color(0xff757575);

  Color get complimentry70 => darkMode ? Color(0xffe0e0e0) : Color(0xff616161);

  Color get complimentry80 => darkMode ? Color(0xffEEEEE) : Color(0xff424242);

  Color get complimentry90 => darkMode ? Color(0xfff5f5f5) : Color(0xff212121);

  ButtonOptions get btnSecondary => ButtonOptions(
      buttonBorder: Border.fromBorderSide(noneBorder),
      backgroundColor: [secondaryColor, secondaryColor],
      textColor: complimentry);

  ButtonOptions get btnDanger => ButtonOptions(
      buttonBorder: Border.fromBorderSide(noneBorder),
      backgroundColor: [errorColor, errorColor],
      textColor: complimentry);

  ButtonOptions get btnWarning => ButtonOptions(
      buttonBorder: Border.fromBorderSide(noneBorder),
      backgroundColor: [warningColor, warningColor],
      textColor: complimentry);

  ButtonOptions get btnInfo => ButtonOptions(
      buttonBorder: Border.fromBorderSide(noneBorder),
      backgroundColor: [infoColor, infoColor],
      textColor: complimentry);

  ButtonOptions get btnLight => ButtonOptions(
      buttonBorder: Border.fromBorderSide(noneBorder),
      backgroundColor: [complimentry, complimentry],
      textColor: complimentry90);

  ButtonOptions get btnDark => ButtonOptions(
      buttonBorder: Border.fromBorderSide(noneBorder),
      backgroundColor: [complimentry90, complimentry90],
      textColor: complimentry);

  ButtonOptions get btnOutlineWhite => ButtonOptions(
      buttonBorder:
          Border.fromBorderSide(lineBorder.copyWith(color: Colors.transparent)),
      backgroundColor: [Colors.transparent, Colors.transparent],
      textColor: complimentry90);

  ButtonOptions get btnOutlineSecondary => ButtonOptions(
      buttonBorder:
          Border.fromBorderSide(lineBorder.copyWith(color: complimentry50)),
      backgroundColor: [Colors.transparent, Colors.transparent],
      textColor: complimentry50);

  ButtonOptions get btnOutlineDanger => ButtonOptions(
      buttonBorder:
          Border.fromBorderSide(lineBorder.copyWith(color: errorColor)),
      backgroundColor: [Colors.transparent, Colors.transparent],
      textColor: errorColor);

  ButtonOptions get btnOutlineWarning => ButtonOptions(
      buttonBorder:
          Border.fromBorderSide(lineBorder.copyWith(color: warningColor)),
      backgroundColor: [Colors.transparent, Colors.transparent],
      textColor: warningColor);

  ButtonOptions get btnOutlineInfo => ButtonOptions(
      buttonBorder:
          Border.fromBorderSide(lineBorder.copyWith(color: infoColor)),
      backgroundColor: [Colors.transparent, Colors.transparent],
      textColor: infoColor);

  ButtonOptions get btnOutlineLight => ButtonOptions(
      buttonBorder:
          Border.fromBorderSide(lineBorder.copyWith(color: Colors.transparent)),
      backgroundColor: [Colors.transparent, Colors.transparent],
      textColor: complimentry90);

  ButtonOptions get btnOutlineDark => ButtonOptions(
      buttonBorder:
          Border.fromBorderSide(lineBorder.copyWith(color: complimentry90)),
      backgroundColor: [Colors.transparent, Colors.transparent],
      textColor: complimentry90);

  ButtonOptions get btnPrimary => ButtonOptions(
      buttonBorder:
          Border.fromBorderSide(lineBorder.copyWith(color: Colors.transparent)),
      backgroundColor: [primaryColor, primaryColor],
      textColor: complimentry);

  // calculated values
  late Color averageBackgroundColor;
  late Color alternateCardColor;
  late Color solidCardColor1;
  late Color solidCardColor2;
  late Brightness brightness;
  late Color onSurface;
  late Color onPrimary;
  late Color onSecondary;
  late Color onBackground;
  late Color onError;
  late Brightness statusBarBrightness;
  late Brightness statusBarIconBrightness;
  late Brightness navBarIconBrightness;

  late ThemeData themeData;

  late TextTheme _textTheme;
  late double _backgroundLuminance;

  static AppTheme of(BuildContext context) {
    return ThemeSettingsModel.of(context).appTheme;
  }

  static const List<Color> paletteColors = [
    Colors.greenAccent,
    Colors.amberAccent,
    Colors.redAccent,
  ];

  Color get foregroundColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;

  /// Reduces the [backgroundColors] to a single interpolated color.
  void _setupAverageBackgroundColor() {
    averageBackgroundColor = backgroundColors.reduce(
      (value, element) => Color.lerp(value, element, .5)!,
    );
  }

  final PrefUtils appPrefs = sl();

  bool get darkMode => false; // appPrefs.getBool(keySelectedModeId);

  /// Calculates the background brightness by averaging the relative luminance
  /// of each background color.
  ///
  /// Similar to [ThemeData.estimateBrightnessForColor] for multiple colors.
  void _setupBrightness() {
    _backgroundLuminance = backgroundColors
            .map((color) => color.computeLuminance())
            .reduce((a, b) => a + b) /
        backgroundColors.length;

    // the Material Design color brightness threshold
    const kThreshold = 0.15;

    brightness = (_backgroundLuminance + 0.05) * (_backgroundLuminance + 0.05) >
            kThreshold
        ? Brightness.light
        : Brightness.dark;
  }

  void _setupCardColor(int? cardColorData) {
    cardColor = cardColorData != null
        ? Color(cardColorData)
        : Color.lerp(
            secondaryColor.withOpacity(.1),
            brightness == Brightness.dark
                ? Colors.white.withOpacity(.2)
                : Colors.black.withOpacity(.2),
            .1,
          )!;

    alternateCardColor =
        Color.lerp(cardColor, averageBackgroundColor, .9)!.withOpacity(.8);

    solidCardColor1 =
        Color.lerp(cardColor, averageBackgroundColor, .85)!.withOpacity(1);

    solidCardColor2 =
        Color.lerp(cardColor, averageBackgroundColor, .775)!.withOpacity(1);
  }

  void _setupButtonTextColor() {
    final ratio = _contrastRatio(
      _backgroundLuminance,
      foregroundColor.computeLuminance(),
    );
    buttonTextColor = ratio >= kTextContrastRatio
        ? averageBackgroundColor
        : brightness == Brightness.dark
            ? Colors.black
            : Colors.white;
  }

  void _setupErrorColor() {
    errorColor = _calculateBestContrastColor(
      colors: [
        const Color(0xFFD21404),
        Colors.red,
        Colors.redAccent,
        Colors.deepOrange,
      ],
      baseLuminance: _backgroundLuminance,
    );
  }

  void _setupForegroundColors() {
    onPrimary = _calculateBestContrastColor(
      colors: [Colors.white, Colors.black],
      baseLuminance: primaryColor.computeLuminance(),
    );

    onSurface = _calculateBestContrastColor(
      colors: [Colors.white, Colors.black],
      baseLuminance: cardColor.computeLuminance(),
    );

    onSecondary = _calculateBestContrastColor(
      colors: [Colors.white, Colors.black],
      baseLuminance: secondaryColor.computeLuminance(),
    );

    onBackground = _calculateBestContrastColor(
      colors: [Colors.white, Colors.black],
      baseLuminance: _backgroundLuminance,
    );

    onError = _calculateBestContrastColor(
      colors: [Colors.white, Colors.black],
      baseLuminance: errorColor.computeLuminance(),
    );
  }

  /// Sets the system ui colors and brightness values based on their color and
  /// transparency.
  ///
  /// If the status bar color has transparency, the estimated color on the
  /// background will be used to determine the brightness.
  void _setupSystemUiColors() {
    statusBarBrightness = ThemeData.estimateBrightnessForColor(
      Color.lerp(
        statusBarColor,
        backgroundColors.first,
        1 - statusBarColor.opacity,
      )!,
    );

    statusBarIconBrightness = _complementaryBrightness(statusBarBrightness);

    navBarIconBrightness = _complementaryBrightness(
      ThemeData.estimateBrightnessForColor(
        Color.lerp(
          navBarColor,
          backgroundColors.last,
          1 - navBarColor.opacity,
        )!,
      ),
    );
  }

  void _setupTextTheme() {
    const displayFont = 'TTCommons';

    final textColor = foregroundColor;

    final fontSizeDelta = 1.0;

    _textTheme = brightness == Brightness.light
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    _textTheme = _textTheme
        .apply(fontFamily: displayFont)
        .copyWith(
          // headline
          headline1: TextStyle(
              fontSize: 42.dp,
              fontFamily: displayFont,
              color: complimentry80,
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 32.dp,
              fontFamily: displayFont,
              color: textColor,
              fontWeight: FontWeight.w500),
          headline3: TextStyle(
              fontSize: 22.dp,
              fontFamily: displayFont,
              color: textColor,
              fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontSize: 18.dp,
              fontFamily: displayFont,
              color: textColor,
              fontWeight: FontWeight.w500),
          headline5: TextStyle(
              fontSize: 12.dp,
              fontFamily: displayFont,
              color: complimentry80,
              fontWeight: FontWeight.w500),
          headline6: TextStyle(
              fontSize: 10.dp,
              fontFamily: displayFont,
              color: complimentry80,
              fontWeight: FontWeight.bold),
          subtitle1: TextStyle(
              fontSize: 10.dp,
              fontFamily: displayFont,
              color: complimentry80,
              fontWeight: FontWeight.w500),
          subtitle2: TextStyle(
              fontSize: 12.dp,
              fontFamily: displayFont,
              color: complimentry60,
              fontWeight: FontWeight.w500),
          bodyText1: TextStyle(
              fontSize: 14.dp,
              fontFamily: displayFont,
              color: textColor,
              fontWeight: FontWeight.bold),
          bodyText2: TextStyle(
              fontSize: 14.dp,
              fontFamily: displayFont,
              color: complimentry80,
              fontWeight: FontWeight.w500),
          button: TextStyle(
              fontSize: 14.dp,
              fontFamily: displayFont,
              color: buttonTextColor,
              letterSpacing: 1.3,
              fontWeight: FontWeight.bold),
          caption: TextStyle(
              fontSize: 12.dp,
              fontFamily: displayFont,
              color: complimentry60,
              fontWeight: FontWeight.w500),
          overline: TextStyle(
              fontSize: 14.dp,
              fontFamily: displayFont,
              color: secondaryColor,
              fontWeight: FontWeight.w500),
        )
        .apply(fontSizeDelta: fontSizeDelta);
  }

  void _setupThemeData() {
    final dividerColor = brightness == Brightness.dark
        ? Colors.white.withOpacity(.2)
        : Colors.black.withOpacity(.2);

    themeData = ThemeData.from(
      colorScheme: ColorScheme(
          primary: primaryColor,
          primaryVariant: primaryColor,
          secondary: secondaryColor,
          secondaryVariant: secondaryColor,
          surface: cardColor,
          background: cardColor,
          error: errorColor,
          onPrimary: onPrimary,
          onSecondary: onSecondary,
          onSurface: onSurface,
          onBackground: onBackground,
          onError: onError,
          brightness: brightness),
      textTheme: _textTheme,
    ).copyWith(
        buttonColor: foregroundColor,
        primaryColorBrightness: brightness,
        toggleableActiveColor: secondaryColor,
        splashColor: secondaryColor.withOpacity(.1),
        highlightColor: secondaryColor.withOpacity(.1),
        dividerColor: dividerColor,
        cardTheme: CardTheme(
          color: cardColor,
          shape: kDefaultShapeBorder,
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        textSelectionTheme: TextSelectionThemeData(
          // cursor color used by text fields
          cursorColor: secondaryColor,
          // used by a text field when it has focus
          selectionHandleColor: secondaryColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: foregroundColor,
          backgroundColor: alternateCardColor,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: averageBackgroundColor,
          contentTextStyle: _textTheme.subtitle2,
          actionTextColor: primaryColor,
          disabledActionTextColor: primaryColor.withOpacity(.5),
          shape: kDefaultShapeBorder,
          behavior: SnackBarBehavior.floating,
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: cardColor,
          shape: kDefaultShapeBorder,
        ),
        iconTheme: const IconThemeData.fallback().copyWith(
          color: foregroundColor,
          size: 20,
        ),
        scrollbarTheme: ScrollbarThemeData(
          radius: kDefaultRadius,
          thickness: MaterialStateProperty.resolveWith((_) => 3),
          mainAxisMargin: 2,
          thumbColor: MaterialStateColor.resolveWith(
            (state) => state.contains(MaterialState.dragged)
                ? secondaryColor.withOpacity(.8)
                : secondaryColor.withOpacity(.4),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(borderRadius: kDefaultBorderRadius),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: dividerColor),
            borderRadius: kDefaultBorderRadius,
          ),
          contentPadding: EdgeInsets.all(8),
        ),
        appBarTheme: AppBarTheme(
          // overrides the system ui overlay style
          brightness: statusBarBrightness,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: cardColor,
        ));
  }
}

/// Returns the color in [colors] that has the best contrast on the
/// [baseLuminance].
Color _calculateBestContrastColor({
  required List<Color> colors,
  required double baseLuminance,
}) {
  assert(colors.isNotEmpty);

  Color? bestColor;
  double? bestLuminance;

  for (final color in colors) {
    final luminance = _contrastRatio(
      color.computeLuminance(),
      baseLuminance,
    );

    if (bestLuminance == null || luminance > bestLuminance) {
      bestLuminance = luminance;
      bestColor = color;
    }
  }

  return bestColor!;
}

Brightness _complementaryBrightness(Brightness brightness) {
  return brightness == Brightness.dark ? Brightness.light : Brightness.dark;
}

/// Calculates the contrast ratio of two colors using the W3C accessibility
/// guidelines.
///
/// Values range from 1 (no contrast) to 21 (max contrast).
///
/// See https://www.w3.org/TR/WCAG20/#contrast-ratiodef.
double _contrastRatio(double firstLuminance, double secondLuminance) {
  return (max(firstLuminance, secondLuminance) + 0.05) /
      (min(firstLuminance, secondLuminance) + 0.05);
}
