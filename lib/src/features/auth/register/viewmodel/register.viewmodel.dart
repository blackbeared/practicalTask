import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

class RegisterViewModel extends ChangeNotifier {
  // Input Controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final activationGoalController = TextEditingController();
  final monthlyIncomeController = TextEditingController();
  final monthlyExpenseController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  // Form Field Keys
  final emailFormFieldKey = GlobalKey<FormFieldState>();
  final passwordFormFieldKey = GlobalKey<FormFieldState>();
  final activationGoalFormFieldKey = GlobalKey<FormFieldState>();
  final monthlyIncomeFormFieldKey = GlobalKey<FormFieldState>();
  final monthlyExpenseFormFieldKey = GlobalKey<FormFieldState>();
  final dateFormFieldKey = GlobalKey<FormFieldState>();
  final timeFormFieldKey = GlobalKey<FormFieldState>();

  // Button keys
  final submitEmailKey = GlobalKey<State>();
  final submitPasswordKey = GlobalKey<State>();
  final submitPersonalInfoKey = GlobalKey<State>();
  final submitDateTimeKey = GlobalKey<State>();

  // Focuses
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();

  DateTime scheduleDate = DateTime.now();

  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(scheduleDate);

  // Steps Progress
  int currentStep = 0;
  int steps = 4;

  // Getters
  String get email => emailTextController.text;

  String get password => passwordTextController.text;

  String get activationGoal => activationGoalController.text;

  String get monthlyIncome => monthlyIncomeController.text;

  String get monthlyExpense => monthlyExpenseController.text;

  String get date => dateController.text;

  String get time => timeController.text;

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
    activationGoalController.addListener(textControllerListener);
    monthlyIncomeController.addListener(textControllerListener);
    monthlyExpenseController.addListener(textControllerListener);
    dateController.addListener(textControllerListener);
    timeController.addListener(textControllerListener);
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
    final bool validCase2 = validCase1 &&
        isNotEmpty(activationGoal) &&
        isNotEmpty(monthlyExpense) &&
        isNotEmpty(monthlyIncome);
    final bool validCase3 = validCase2 && isNotEmpty(date) && isNotEmpty(time);
    switch (currentStep) {
      case 0:
        return validCase0;
      case 1:
        return validCase1;
      case 2:
        return validCase2;
      case 3:
        return validCase3;
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
        submitDateTimeKey.currentContext!.showMessage(
            submitDateTimeKey.currentContext!.local.signUpComplete,
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
