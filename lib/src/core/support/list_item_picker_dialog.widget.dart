import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

/// Dialog to select value from list of strings
/// [title] for Dialog title
/// [items] for list items
/// [selected] for pre-selected item
/// [callback] for item selection callback
class ListItemPickerDialog extends StatelessWidget {
  final String title;
  final List<String> items;
  final String selected;
  final Function(String) callback;

  const ListItemPickerDialog(
      {Key? key,
      required this.title,
      required this.items,
      required this.selected,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(kListPadding),
      backgroundColor: context.theme.secondaryColor,
      title: Text(
        title,
        style: context.headline4.white,
      ),
      content: Container(
        color: AppTheme.of(context).cardColor,
        height: context.height * 0.5, // Change as per your requirement
        width: context.width * 0.6, // Change as per your requirement
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: kInternalPadding),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                callback(items[index]);
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: kListPadding, horizontal: kInternalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(items[index], style: context.headline4.regular.black),
                    if (selected == items[index])
                      Icon(
                        LineAwesomeIcons.check,
                        color: context.theme.complimentry90,
                      )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: kDividerHeight,
              height: kDividerHeight,
              color: context.theme.complimentry50,
            );
          },
        ),
      ),
    );
  }
}
