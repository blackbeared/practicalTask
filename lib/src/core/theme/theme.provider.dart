import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/all.exports.dart';

/// Provides the currently used [HarpyTheme] to its decendents.
class ThemeProvider extends StatelessWidget {
  const ThemeProvider({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProxyProvider2<ThemeSettingsModel, Brightness, AppTheme>(
      update: (_, themeBloc, systemBrightness, theme) {
        // match the system ui to the current theme
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          updateSystemUi(theme);
        });
        return theme!;
      },
      child: child,
    );
  }
}

void updateSystemUi(AppTheme? theme) {
  if (theme != null)
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: theme.statusBarColor,
        statusBarBrightness: theme.statusBarBrightness,
        statusBarIconBrightness: theme.statusBarIconBrightness,
        systemNavigationBarColor: theme.navBarColor,
        systemNavigationBarDividerColor: theme.navBarColor,
        systemNavigationBarIconBrightness: theme.navBarIconBrightness,
      ),
    );
}
