import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/features/auth/register/viewmodel/register.viewmodel.dart';
import 'package:flutter_task/src/features/auth/register/widgets/steps_progress.widget.dart';

class RegisterScreen extends StatelessWidget {
  static const String route = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).backgroundColors.first,
      body: RegisterScreenBody(),
    );
  }
}

class RegisterScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (_) => RegisterViewModel(),
      builder: (context, child) {
        final loginModel = context.watch<RegisterViewModel>();
        return Container(
          width: context.width,
          height: context.height - 40.dp,
          // -40 to remove misc. status bar height Todo: Fix with calculated statusBar size
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StepProgressView(
                curStep: loginModel.currentStep,
                width: context.width,
                activeColor: Colors.green,
                inactiveColor: Colors.white,
                steps: loginModel.steps,
              ),
            ],
          ),
        );
      },
    );
  }
}