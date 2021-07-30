import 'package:flutter_task/all.exports.dart';

final sl = GetIt.instance;

void setup() {
  // Utils
  sl.registerSingleton<PrefUtils>(PrefUtils());
}

Future<void> clear() {
  return sl.reset();
}
