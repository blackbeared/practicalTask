import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/all.exports.dart';

class StepProgressView extends StatelessWidget {
  final double width;
  final int curStep;
  final int steps;
  final Color activeColor;
  final Color lineColor;
  final Color inactiveColor;
  final double lineWidth = 2.dp;

  StepProgressView(
      {required this.curStep,
      required this.width,
      required this.activeColor,
      this.lineColor = Colors.black,
      this.inactiveColor = Colors.grey,
      this.steps = 1,
      Key? key})
      : assert(steps != 0),
        assert(width > 0),
        super(key: key);

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kContentPadding),
        width: this.width,
        child: Row(
          children: generateStepperView(context),
        ));
  }

  List<Widget> generateStepperView(BuildContext context) {
    var list = <Widget>[];
    for (int i = 0; i < steps; i++) {
      var circleColor = (curStep > i) ? activeColor : inactiveColor;
      list.add(
        AnimatedContainer(
          duration: kTabScrollDuration,
          width: 50.dp,
          height: 50.dp,
          alignment: Alignment.center,
          child: Text(
            (i + 1).toString(),
            style: context.headline3.regular.copyWith(color: lineColor),
          ),
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: BorderRadius.circular(kCardRadiusBig),
            border: Border.all(
              color: lineColor,
              width: lineWidth,
            ),
          ),
        ),
      );

      //line between icons
      if (i != steps - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    }
    return list;
  }
}
