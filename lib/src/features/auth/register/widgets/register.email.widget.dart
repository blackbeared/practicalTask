import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/features/auth/register/other/register.email.clipper.dart';
import 'package:flutter_task/src/features/auth/register/viewmodel/register.viewmodel.dart';

/// Separated Email Input Widget for requesting Email from user.
class RegisterEmailWidget extends StatelessWidget {
  const RegisterEmailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerModel = context.watch<RegisterViewModel>();
    return ClipPath(
      clipper: RegisterBackgroundClipper(100),
      child: Container(
        padding: EdgeInsets.only(
            top: 70.dp,
            left: kContentPadding,
            right: kContentPadding,
            bottom: kContentPadding),
        color: context.theme.cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: context.local.signUpHeader1,
                      style: context.headline1.black),
                  TextSpan(
                      text: context.local.signUpHeader2,
                      style: context.headline1
                          .copyWith(color: AppTheme.of(context).primaryColor)),
                ],
              ),
            ),
            VerticalSpace(context.height * 0.05),
            ScreenDescription(context.local.signUpDescription),
            VerticalSpace(context.height * 0.10),
            Container(
              padding: EdgeInsets.all(kCardRadius),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kCardRadiusSmall),
                  boxShadow: getDefaultBoxShadow(elevation: 0, blurr: 20)),
              child: TextfieldX(
                key: registerModel.emailFormFieldKey,
                autoCorrect: false,
                focusNode: registerModel.focusEmail,
                filled: true,
                fillColor: AppTheme.of(context).complimentry20,
                showUnderLine: false,
                textOption: TextFieldOption(
                  prefixWid: Icon(
                    LineAwesomeIcons.envelope,
                    color: context.theme.complimentry50,
                  ),
                  hintText: context.local.email,
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  inputController: registerModel.emailTextController,
                  formatter: [
                    FilteringTextInputFormatter.deny(RegExp(RegexForEmoji))
                  ],
                ),
                onNextPress: registerModel.setNextFocus,
              ),
            ),
            Spacer(),
            ButtonX(
              key: registerModel.submitEmailKey,
              onTap: registerModel.onSubmitPressed,
              text: context.local.next,
              elevation: 1,
              fitWidth: true,
              buttonOptions: context.theme.btnSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
