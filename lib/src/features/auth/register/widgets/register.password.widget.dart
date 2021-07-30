import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/features/auth/register/viewmodel/register.viewmodel.dart';
import 'package:flutter_task/src/features/auth/register/widgets/password.complexity.widget.dart';

// Create Password Page for Registration flow
class RegisterPasswordWidget extends StatelessWidget {
  const RegisterPasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerModel = context.watch<RegisterViewModel>();
    return Container(
      padding: EdgeInsets.all(kContentPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.local.createPasswordHeader,
              style: context.headline3.white),
          VerticalSpace(kSpaceNormal),
          ScreenDescription(
            context.local.createPasswordDescription,
            textColor: context.theme.complimentry,
          ),
          VerticalSpace(context.height * 0.05),
          TextfieldX(
            key: registerModel.passwordFormFieldKey,
            autoCorrect: false,
            focusNode: registerModel.focusPassword,
            filled: true,
            fillColor: Colors.white,
            showUnderLine: false,
            textOption: TextFieldOption(
              prefixWid: Icon(
                LineAwesomeIcons.key,
                color: context.theme.complimentry50,
              ),
              isSecureTextField: true,
              // Set true for password fields
              hintText: context.local.password,
              autofillHints: const [AutofillHints.password],
              // Password Autofill Hints
              inputController: registerModel.passwordTextController,
              formatter: [
                FilteringTextInputFormatter.deny(RegExp(RegexForEmoji))
              ],
            ),
            onNextPress: registerModel.setNextFocus,
          ),
          VerticalSpace(context.height * 0.05),
          PasswordComplexityWidget(), // Complexity Widget in seperate file
          Spacer(),
          ButtonX(
            key: registerModel.submitPasswordKey,
            onTap: registerModel.onSubmitPressed,
            text: context.local.next,
            elevation: 1,
            fitWidth: true,
            buttonOptions: context.theme.btnSecondary,
          ),
        ],
      ),
    );
  }
}
