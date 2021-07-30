import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/features/auth/register/viewmodel/register.viewmodel.dart';

/// Schedule Video call for verification in registration flow.
class RegisterScheduleCallWidget extends StatelessWidget {
  const RegisterScheduleCallWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerModel = context.watch<RegisterViewModel>();
    final cardColor = context.theme.cardColor;
    return Container(
      padding: EdgeInsets.all(kContentPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50.dp,
            height: 50.dp,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.dp)),
            child: Icon(
              LineAwesomeIcons.calendar,
              color: AppTheme.of(context).secondaryColor,
              size: 24.dp,
            ),
          ),
          VerticalSpace(kSpaceLarge),
          Text(context.local.scheduleCallHeader,
              style: context.headline3.white),
          VerticalSpace(kSpaceNormal),
          ScreenDescription(
            context.local.scheduleCallDescription,
            textColor: context.theme.complimentry,
          ),
          VerticalSpace(kSpaceLarge),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kCardRadiusSmall),
                color: AppTheme.of(context).cardColor),
            padding: EdgeInsets.only(top: kInternalPadding),
            child: TextfieldX(
              key: registerModel.dateFormFieldKey,
              autoCorrect: false,
              showUnderLine: false,
              tapCallback: () async {
                DateTime? selectedDate = await showPlatformDatePicker(
                  context: context,
                  firstDate: DateTime(DateTime.now().year - 2),
                  initialDate: registerModel.scheduleDate,
                  lastDate: DateTime(DateTime.now().year + 2),
                );
                if (selectedDate != null) {
                  selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      registerModel.scheduleDate.hour,
                      registerModel.scheduleDate.minute);
                  registerModel.scheduleDate = selectedDate;
                  registerModel.dateController.text = DateUtilities()
                      .getFormattedDateString(selectedDate,
                          formatter: DateUtilities.dd_mm_yyyy);
                }
              },
              textOption: TextFieldOption(
                type: TextFieldType.Date,
                labelText: context.local.scheduleDate,
                hintText: context.local.scheduleDateHint,
                inputController: registerModel.dateController,
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
              key: registerModel.timeFormFieldKey,
              autoCorrect: false,
              showUnderLine: false,
              tapCallback: () async {
                TimeOfDay? temp = await showPlatformTimePicker(
                  context: context,
                  backgroundColor: cardColor,
                  initialTime: registerModel.timeOfDay,
                );
                if (temp != null) {
                  DateTime selectedDate = registerModel.scheduleDate;
                  selectedDate = DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day, temp.hour, temp.minute);
                  registerModel.scheduleDate = selectedDate;
                  registerModel.timeController.text = DateUtilities()
                      .getFormattedDateString(selectedDate,
                          formatter: DateUtilities.hh_mm_a);
                }
              },
              textOption: TextFieldOption(
                type: TextFieldType.Time,
                labelText: context.local.scheduleTime,
                hintText: context.local.scheduleTimeHint,
                inputController: registerModel.timeController,
              ),
            ),
          ),
          Spacer(),
          ButtonX(
            key: registerModel.submitDateTimeKey,
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
