import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/features/auth/register/viewmodel/register.viewmodel.dart';

// Widget for showing password complexity Level.
// Shows Checkmarks and Complexity for various password security levels, Helps user to pick right password.
class PasswordComplexityWidget extends StatelessWidget {
  const PasswordComplexityWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerModel = context.watch<RegisterViewModel>();
    return Column(
      children: [
        Row(
          children: [
            ScreenDescription(
              context.local.passwordComplexity,
              textColor: context.theme.complimentry,
            ),
            Text(registerModel.getComplexity(context).keys.first,
                style: context.headline4.bold.copyWith(
                    color: registerModel.getComplexity(context).values.first))
          ],
        ),
        VerticalSpace(context.height * 0.04),
        Row(
          children: [
            PasswordSafetyWidget(
                name: context.local.lowerCase,
                sign: context.local.lowerCaseHint,
                match: registerModel.isLowercase),
            PasswordSafetyWidget(
                name: context.local.upperCase,
                sign: context.local.upperCaseHint,
                match: registerModel.isUpperCase),
            PasswordSafetyWidget(
                name: context.local.numberCase,
                sign: context.local.numericCaseHint,
                match: registerModel.isNumeric),
            PasswordSafetyWidget(
                name: context.local.specialCharacterCase,
                sign: context.local.specialCharactersCaseHint,
                match: registerModel.isSpecialSymbol)
          ],
        )
      ],
    );
  }
}

// Password safety widget created Seperately for recurring need
class PasswordSafetyWidget extends StatelessWidget {
  final String sign;
  final String name;
  final bool match;

  const PasswordSafetyWidget(
      {Key? key, required this.sign, required this.name, required this.match})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Container(
                height: 50.dp,
                child: match
                    ? Icon(
                        LineAwesomeIcons.check_circle,
                        size: 32.dp,
                        color: context.theme.successColor,
                      )
                    : Text(sign, style: context.headline1.light.white)),
            Text(name, style: context.headline5.white54)
          ],
        ),
      ),
    );
  }
}
