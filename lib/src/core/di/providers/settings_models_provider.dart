import 'package:flutter/material.dart';
import 'package:flutter_task/src/core/di/models/theme_settings_model.dart';
import 'package:provider/provider.dart';

/// Creates a [MultiProvider] with each settings model.
///
/// These models are above the root [MaterialApp] and are only created once.R
class SettingsModelsProvider extends StatelessWidget {
  const SettingsModelsProvider({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeSettingsModel>(
          create: (BuildContext context) {
            return ThemeSettingsModel();
          },
        )
      ],
      child: child,
    );
  }
}
