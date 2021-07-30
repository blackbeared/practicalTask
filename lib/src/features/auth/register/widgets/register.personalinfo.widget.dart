import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/core/support/list_item_picker_dialog.widget.dart';
import 'package:flutter_task/src/features/auth/register/viewmodel/register.viewmodel.dart';

/// Personal info widget page for registration flow
class RegisterPersonalInfoWidget extends StatelessWidget {
  const RegisterPersonalInfoWidget({
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
          Text(context.local.personalInformationHeader,
              style: context.headline3.white),
          VerticalSpace(kSpaceNormal),
          ScreenDescription(
            context.local.personalInformationDescription,
            textColor: context.theme.complimentry,
          ),
          VerticalSpace(context.height * 0.05),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kCardRadiusSmall),
                color: AppTheme.of(context).cardColor),
            padding: EdgeInsets.only(top: kInternalPadding),
            child: TextfieldX(
              key: registerModel.activationGoalFormFieldKey,
              autoCorrect: false,
              showUnderLine: false,
              tapCallback: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ListItemPickerDialog(
                          title: context.local.goalForActivation,
                          items: activationGoal,
                          selected: registerModel.activationGoal,
                          callback: (data) {
                            registerModel.activationGoalController.text = data;
                          });
                    });
              },
              textOption: TextFieldOption(
                type: TextFieldType.DropDown,
                labelText: context.local.goalForActivation,
                hintText: context.local.chooseOptionsHint,
                inputController: registerModel.activationGoalController,
              ),
            ),
          ),
          VerticalSpace(kSpaceLarge),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kCardRadiusSmall),
                color: AppTheme.of(context).cardColor),
            padding: EdgeInsets.only(top: kInternalPadding),
            child: TextfieldX(
              key: registerModel.monthlyIncomeFormFieldKey,
              autoCorrect: false,
              showUnderLine: false,
              tapCallback: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ListItemPickerDialog(
                          title: context.local.monthlyIncome,
                          items: monthlyIncome,
                          selected: registerModel.monthlyIncome,
                          callback: (data) {
                            registerModel.monthlyIncomeController.text = data;
                          });
                    });
              },
              textOption: TextFieldOption(
                type: TextFieldType.DropDown,
                labelText: context.local.monthlyIncome,
                hintText: context.local.chooseOptionsHint,
                inputController: registerModel.monthlyIncomeController,
              ),
            ),
          ),
          VerticalSpace(kSpaceLarge),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kCardRadiusSmall),
                color: AppTheme.of(context).cardColor),
            padding: EdgeInsets.only(top: kInternalPadding),
            child: TextfieldX(
              key: registerModel.monthlyExpenseFormFieldKey,
              autoCorrect: false,
              showUnderLine: false,
              tapCallback: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ListItemPickerDialog(
                          title: context.local.monthlyExpense,
                          items: monthlyExpense,
                          selected: registerModel.monthlyExpense,
                          callback: (data) {
                            registerModel.monthlyExpenseController.text = data;
                          });
                    });
              },
              textOption: TextFieldOption(
                type: TextFieldType.DropDown,
                // Setting for converting Textfield to Dropdown Widget
                labelText: context.local.monthlyExpense,
                hintText: context.local.chooseOptionsHint,
                inputController: registerModel.monthlyExpenseController,
              ),
            ),
          ),
          Spacer(),
          ButtonX(
            key: registerModel.submitPersonalInfoKey,
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
