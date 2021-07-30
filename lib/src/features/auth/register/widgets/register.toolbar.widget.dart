import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/features/auth/register/viewmodel/register.viewmodel.dart';

class RegisterToolbarWidget extends StatelessWidget {
  const RegisterToolbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerModel = context.watch<RegisterViewModel>();
    return AnimatedOpacity(
        duration: kTabScrollDuration,
        opacity: registerModel.currentStep != 0 ? 1 : 0,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kContentPadding, vertical: kCardPadding),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: registerModel.goBack,
                  child: Icon(
                    LineAwesomeIcons.arrow_left,
                    color: context.theme.complimentry,
                    size: 28.dp,
                  ),
                ),
                HorizontalSpace(kSpaceBig),
                Text(
                  context.local.createAccount,
                  style: context.headline3,
                )
              ],
            ),
          ),
        ));
  }
}
