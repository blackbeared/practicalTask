import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

class VerticalSpace extends StatelessWidget {
  final num space;

  const VerticalSpace(this.space);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(size: Size(0, space.dp.toDouble()));
  }
}

class HorizontalSpace extends StatelessWidget {
  final num space;

  const HorizontalSpace(this.space);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(size: Size(space.dp.toDouble(), 0));
  }
}
