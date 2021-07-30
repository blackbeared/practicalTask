import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

class RegisterViewModel extends ChangeNotifier {
  // Input Controllers
  final emailTextController = TextEditingController();

  // Keys
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final submitEmailKey = GlobalKey<State>();

  // Focuses
  final FocusNode focusEmail = FocusNode();

  // Steps Progress
  int currentStep = 0;
  int steps = 4;

  // Getters
  String get email => emailTextController.text;

  get onSubmitPressed => !isEnableSubmitButton() ? null : performNextAction;

  RegisterViewModel() {
    emailTextController.addListener(textControllerListener);
  }

  // Utility functions
  void textControllerListener() {
    notifyListeners();
  }

  void setNextFocus(BuildContext context) {
    onSubmitPressed();
  }

  bool isEnableSubmitButton() {
    return email.isNotEmpty && validateEmail(email);
  }

  Future performNextAction() async {
    currentStep = currentStep + 1;
  }
}
