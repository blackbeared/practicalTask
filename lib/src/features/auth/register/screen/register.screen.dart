import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/features/auth/register/viewmodel/register.viewmodel.dart';
import 'package:flutter_task/src/features/auth/register/widgets/register.email.widget.dart';
import 'package:flutter_task/src/features/auth/register/widgets/steps_progress.widget.dart';

// Initial Route [RegisterScreen] is for new user registration
class RegisterScreen extends StatelessWidget {
  static const String route = 'register';

  // Hack to maintain Scroll Position while keyboard is active
  // Ref : https://stackoverflow.com/questions/53586892/flutter-textformfield-hidden-by-keyboard
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).backgroundColors.first,
      body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: context.width,
              minHeight: context.height,
            ),
            child:
                IntrinsicHeight(child: SafeArea(child: RegisterScreenBody())),
          )), // SafeArea wrapper for handling status bar and navigation bar spacing
    );
  }
}

class RegisterScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (_) => RegisterViewModel(),
      builder: (context, child) {
        // Watch Register ViewModel for changes
        final loginModel = context.watch<RegisterViewModel>();
        return Container(
          width: context.width,
          // -40 to remove misc. status bar height
          // Todo: Fix with calculated statusBar size
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VerticalSpace(kSpaceBig),
              StepProgressView(
                curStep: loginModel.currentStep,
                width: context.width,
                activeColor: Colors.green,
                inactiveColor: Colors.white,
                steps: loginModel.steps,
              ),
              VerticalSpace(kSpaceBig),
              Expanded(child: RegisterEmailWidget())
            ],
          ),
        );
      },
    );
  }
}
