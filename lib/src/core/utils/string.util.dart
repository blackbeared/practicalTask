import 'package:flutter_task/all.exports.dart';

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern as String);
  return (regex.hasMatch(value)); //by default it returns boolean value
}

bool validateLowercase(String value) {
  String pattern = r'[a-z]';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool validateUppercase(String value) {
  String pattern = r'[A-Z]';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool validateNumber(String value) {
  String pattern = r'[0-9]';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool validateSpecialSymbol(String value) {
  String pattern = r'[!@#$%^&*(),.?":{}|<>]';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > 6;

  return hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength;
}

bool validateMobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10}$)';
  RegExp regExp = RegExp(patttern);
  if (isEmpty(value)) {
    return false;
  } else if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}
