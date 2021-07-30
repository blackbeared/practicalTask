import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

class FailureWidget extends StatelessWidget {
  final Failure failure;
  final Function? callback;
  final GlobalKey _sheetGlobalKey = GlobalKey();

  FailureWidget({required this.failure, this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Icon(Icons.error, color: Colors.amber),
        const VerticalSpace(0.05),
        Text(
          failure.message,
          style: context.headline1,
        ),
        if (callback != null)
          ButtonX(
            key: _sheetGlobalKey,
            onTap: () => {callback!()},
            text: context.local.retry,
            buttonOptions: context.theme.btnSecondary,
          )
      ],
    );
  }
}
