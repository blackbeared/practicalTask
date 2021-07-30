import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/core/theme/theme.provider.dart';

class PracticalTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sandip Task',
        theme: AppTheme.of(context).themeData,
        navigatorKey: NavigationUtilities.key,
        onGenerateRoute: onGenerateRoute,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorObservers: [routeObserver],
        builder: (_, child) => _ContentBuilder(child: child ?? Container()),
      );
    });
  }
}

class _ContentBuilder extends StatelessWidget {
  const _ContentBuilder({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(kSpaceZero), child: child),
    );
  }
}
