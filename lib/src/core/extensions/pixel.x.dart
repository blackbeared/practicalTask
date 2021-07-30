import 'package:flutter_task/all.exports.dart';

extension PixelX on num {
  double get dp => getSize(this.toDouble());
}
