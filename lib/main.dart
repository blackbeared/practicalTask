import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/app.dart';

Future runDependents() async {
  setup();
  await sl.allReady();
  return await sl<PrefUtils>().initialize();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runDependents().then((value) {
      runApp(SettingsModelsProvider(
        child: GlobalModelsProvider(child: PracticalTask()),
      ));
    });
  });
}
