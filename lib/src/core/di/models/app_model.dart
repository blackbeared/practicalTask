import 'package:flutter/widgets.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:provider/provider.dart';

class ApplicationModel {
  final PrefUtils prefUtils = sl<PrefUtils>();

  ApplicationModel({required this.themeSettingsModel}) {
    _initialize();
  }

  final ThemeSettingsModel themeSettingsModel;

  static ApplicationModel of(BuildContext context) {
    return Provider.of<ApplicationModel>(context);
  }

  Future<void> _initialize() async {
    _onInitialized();
  }

  Future<void> _onInitialized() async {
    themeSettingsModel.initTheme();
  }

  Future logout() async {
    prefUtils.clearPreferenceAndDB();
    // Navigator.of(NavigationUtilities.key.currentState!.overlay!.context).pushNamedAndRemoveUntil(LoginScreen.route, (_) => false);
  }
}
