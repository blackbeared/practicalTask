import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

class ThemeSettingsModel extends ChangeNotifier {
  final PrefUtils appPrefs = sl<PrefUtils>();

  ThemeSettingsModel() {
    initTheme();
  }

  static ThemeSettingsModel of(BuildContext context, {bool listen = true}) {
    return Provider.of<ThemeSettingsModel>(context, listen: listen);
  }

  AppTheme appTheme = AppTheme.fromData(data: predefinedThemes[0]);
  List<AppThemeData> customThemes = [];

  int get selectedThemeId => appPrefs.getInt(keySelectedThemeId);

  Future<void> changeSelectedTheme(AppTheme theme, int id) async {
    appTheme = theme;
    appPrefs.saveInt(keySelectedThemeId, id);
    notifyListeners();
  }

  Future<bool> getSelectedMode() async {
    return appPrefs.getBool(keySelectedModeId, defaultValue: false);
  }

  Future<void> changeSelectedMode() async {
    appPrefs.saveBoolean(keySelectedModeId,
        !appPrefs.getBool(keySelectedModeId, defaultValue: false));
    notifyListeners();
  }

  void initTheme() {
    appTheme = AppTheme.fromData(data: predefinedThemes[selectedThemeId]);
  }
}
