import 'package:flutter/material.dart';

TextDirection deviceTextDirection = TextDirection.ltr;

const EXT_PNG = "png";

const int DEFAULT_PAGE = 0;
const int DEFAULT_LIMIT = 10;

List<BoxShadow> getDefaultBoxShadow(
    {List<Color> color = const [Colors.black26],
    double elevation = 1,
    double blurr = 1}) {
  return color
      .map(
        (e) => BoxShadow(
          color: e.withAlpha(40),
          offset: Offset(0 * elevation, 2 * elevation),
          blurRadius: 2.0 * blurr.abs(),
        ),
      )
      .toList();
}

// Constant For
const screenDictKeyType = "type";
const screenDictKeyOtpType = "otpType";
const screenDictKeyEmail = "email";
const screenDictKeyPhone = "phone";
const screenDictKeyItem = "item";

const monthlyIncome = [
  '2,000 \$',
  '3,000 \$',
  '4,000 \$',
  '5,000 \$',
  '6,000 \$',
  '7,000 \$',
  '8,000 \$',
  '9,000 \$',
  '10,000 \$',
  '15,000 \$',
  '20,000 \$',
  '50,000 \$',
  '1,00,000 \$',
];

const monthlyExpense = [
  '1,000 \$',
  '2,000 \$',
  '3,000 \$',
  '4,000 \$',
  '5,000 \$',
  '6,000 \$',
  '7,000 \$',
  '8,000 \$',
  '9,000 \$',
  '10,000 \$',
  '15,000 \$',
  '20,000 \$',
  '50,000 \$',
  '1,00,000 \$',
];

const activationGoal = [
  '100 \$',
  '500 \$',
  '1,000 \$',
  '2,000 \$',
  '3,000 \$',
  '4,000 \$',
  '5,000 \$',
  '6,000 \$',
  '7,000 \$',
  '8,000 \$',
  '9,000 \$',
  '10,000 \$',
  '15,000 \$',
  '20,000 \$',
  '50,000 \$',
  '1,00,000 \$',
];
