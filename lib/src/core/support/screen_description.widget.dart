import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/all.exports.dart';

class ScreenDescription extends StatelessWidget {
  final String description;
  final Color textColor;

  const ScreenDescription(this.description, {this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        description,
        style: context.headline4.regular.copyWith(color: textColor),
      ),
    );
  }
}
