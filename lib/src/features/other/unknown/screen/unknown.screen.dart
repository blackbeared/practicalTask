import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

class UnknownScreen extends StatelessWidget {
  static String route = 'unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColors.first,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(context.local.unknownRoute),
      ),
      body: UnknownScreenBody(),
    );
  }
}

class UnknownScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: context.width * 0.05,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScreenDescription(context.local.unknownRouteDescription,
              textColor: context.theme.complimentry),
        ],
      ),
    );
  }
}
