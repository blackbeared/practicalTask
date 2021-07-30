import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

class RegisterViewModel extends ChangeNotifier {
  // Input Controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // Keys
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final passwordFormFieldKey = GlobalKey<FormFieldState>();
  final submitEmailKey = GlobalKey<State>();
  final submitPasswordKey = GlobalKey<State>();

  // Focuses
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();

  // Steps Progress
  int currentStep = 0;
  int steps = 4;

  // Getters
  String get email => emailTextController.text;

  String get password => passwordTextController.text;

  // Page Controller
  final PageController pageController = PageController(
    initialPage: 0,
  );

  // Password validators
  bool get isLowercase => validateLowercase(password);

  bool get isUpperCase => validateUppercase(password);

  bool get isNumeric => validateNumber(password);

  bool get isSpecialSymbol => validateSpecialSymbol(password);

  get onSubmitPressed => !isEnableSubmitButton() ? null : performNextAction;

  Map<String, Color> getComplexity(BuildContext context) {
    int complexity = 0;
    if (isLowercase) complexity = complexity + 1;
    if (isUpperCase) complexity = complexity + 1;
    if (isNumeric) complexity = complexity + 1;
    if (isSpecialSymbol) complexity = complexity + 1;

    switch (complexity) {
      case 1:
        return {context.local.veryWeak: Colors.deepOrangeAccent};
      case 2:
        return {context.local.weak: Colors.orange};
      case 3:
        return {context.local.medium: Colors.yellow};
      case 4:
        return {context.local.secure: Color(0xff15fd90)};
      default:
        return {'': Colors.transparent};
    }
  }

  RegisterViewModel() {
    emailTextController.addListener(textControllerListener);
    passwordTextController.addListener(textControllerListener);
  }

  // Utility functions
  void textControllerListener() {
    notifyListeners();
  }

  void setNextFocus(BuildContext context) {
    onSubmitPressed();
  }

  bool isEnableSubmitButton() {
    final bool validCase0 = email.isNotEmpty && validateEmail(email);
    final bool validCase1 = validCase0 && validatePassword(password);
    switch (currentStep) {
      case 0:
        return validCase0;
      case 1:
        return validCase1;
      case 2:
        return false;
      case 3:
        return false;
    }
    return false;
  }

  Future performNextAction() async {
    switch (currentStep) {
      case 0:
      case 1:
      case 2:
        currentStep = currentStep + 1;
        break;
      case 3:
        submitEmailKey.currentContext!.showMessage(
            submitPasswordKey.currentContext!.local.signUpComplete,
            mode: DisplayMode.SUCCESS);
        break;
    }
    notifyListeners();
  }

  Future goBack() async {
    if (currentStep > 0) {
      currentStep = currentStep - 1;
      notifyListeners();
    }
  }
}
