import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/core/di/models/app_model.dart';
import 'package:flutter_task/src/core/di/models/theme_settings_model.dart';

/// Creates a [MultiProvider] with each global model.
///
/// These models are above the root [MaterialApp] and are only created once.
class GlobalModelsProvider extends StatelessWidget {
  const GlobalModelsProvider({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApplicationModel>(
          create: (BuildContext context) => ApplicationModel(
            themeSettingsModel: Provider.of<ThemeSettingsModel>(
              context,
              listen: false,
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
