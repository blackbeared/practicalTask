import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/all.exports.dart';

/// Custom build [TextfieldX] Widget for Easier maintenance and modification in whole App.
/// Supports multiple widget facilities and also works as select field based on configuration.
/// Todo : Add support for passing listOptions when set to DROPDOWN and integrate picker dialog internally.
class TextfieldX extends StatefulWidget {
  final Key key;
  final TextFieldOption textOption;
  final Function(String text)? textCallback;
  final VoidCallback? tapCallback;
  final Function(BuildContext _context)? onNextPress;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final bool showUnderLine;
  final bool? enable;
  final bool autoCorrect;
  final bool filled;
  final Color fillColor;

  TextfieldX(
      {required this.key,
      required this.textOption,
      this.textCallback,
      this.tapCallback,
      this.onNextPress,
      this.inputAction = TextInputAction.next,
      this.focusNode,
      this.showUnderLine = true,
      this.enable = true,
      this.autoCorrect = true,
      this.filled = false,
      this.fillColor = Colors.transparent})
      : super(key: key);

  @override
  _TextfieldXState createState() => _TextfieldXState();
}

class _TextfieldXState extends State<TextfieldX> {
  bool obscureText = false;
  IconData obscureIcon = LineAwesomeIcons.eye;

  @override
  void initState() {
    super.initState();
    obscureText = widget.textOption.isSecureTextField ?? false;
  }


  @override
  Widget build(BuildContext context) {
    final bool absorb = widget.textOption.type == TextFieldType.DropDown ||
        widget.textOption.type == TextFieldType.Date ||
        widget.textOption.type == TextFieldType.Time;
    return InkWell(
      onTap: widget.tapCallback,
      child: AbsorbPointer(
        absorbing: absorb,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          autocorrect: widget.autoCorrect,
          enabled: widget.enable,
          maxLines: widget.textOption.maxLine,
          textInputAction: widget.inputAction ?? TextInputAction.done,
          focusNode: !absorb ? widget.focusNode ?? null : null,
          controller: widget.textOption.inputController ?? null,
          obscureText: this.obscureText,
          style: context.headline4.black,
          autofillHints: widget.textOption.autofillHints,
          keyboardType: widget.textOption.keyboardType ?? TextInputType.text,
          cursorColor: AppTheme.of(context).themeData.accentColor,
          inputFormatters: widget.textOption.formatter ?? [],
          decoration: InputDecoration(
            isCollapsed: widget.textOption.prefixWid != null ||
                widget.textOption.suffixWid != null,
            filled: widget.filled,
            fillColor: widget.filled ? widget.fillColor : Colors.transparent,
            enabledBorder: widget.showUnderLine == true
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.of(context).themeData.dividerColor))
                : OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: widget.showUnderLine == true
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: context.headline1.color!))
                : OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
            labelStyle: widget.filled
                ? null
                : context.headline4.colored(context.theme.complimentry50),
            labelText: widget.filled ? null : widget.textOption.labelText,
            floatingLabelBehavior: absorb
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.auto,
            hintText: widget.textOption.hintText,
            contentPadding: EdgeInsets.symmetric(
                vertical: kInternalPadding, horizontal: kListPadding),
            hintStyle: context.headline4.colored(absorb
                ? context.theme.complimentry90
                : context.theme.complimentry50),
            prefixIcon: widget.textOption.prefixWid,
            suffixIcon: (widget.textOption.suffixWid != null)
                ? widget.textOption.suffixWid
                : (widget.textOption.isSecureTextField != null &&
                        widget.textOption.isSecureTextField!)
                    ? IconButton(
                        icon: Icon(
                          obscureIcon,
                          color: context.theme.complimentry50,
                        ),
                        onPressed: () {
                          setState(() {
                            this.obscureText = !this.obscureText;
                            if (this.obscureText) {
                              this.obscureIcon = LineAwesomeIcons.eye;
                            } else {
                              this.obscureIcon = LineAwesomeIcons.eye_slash;
                            }
                          });
                        },
                      )
                    : widget.textOption.type == TextFieldType.DropDown
                        ? IconButton(
                            icon: Icon(
                              LineAwesomeIcons.angle_down,
                              color: context.theme.complimentry50,
                              size: 18.dp,
                            ),
                            onPressed: () {},
                          )
                        : widget.textOption.type == TextFieldType.Date
                            ? IconButton(
                                icon: Icon(
                                  LineAwesomeIcons.calendar,
                                  color: context.theme.complimentry50,
                                  size: 24.dp,
                                ),
                                onPressed: () {},
                              )
                            : widget.textOption.type == TextFieldType.Time
                                ? IconButton(
                                    icon: Icon(
                                      LineAwesomeIcons.clock_o,
                                      color: context.theme.complimentry50,
                                      size: 24.dp,
                                    ),
                                    onPressed: () {},
                                  )
                                : null,
          ),
          onSubmitted: (String text) {
            if (widget.onNextPress != null) {
              widget.onNextPress!(context);
            } else {
              context.setFocus();
            }
          },
        ),
      ),
    );
  }
}

/// Text field configuration to be passed to customise [TextFieldX] class
class TextFieldOption {
  String? text = "";
  String? labelText;
  String? hintText;
  bool? isSecureTextField = false;
  TextInputType? keyboardType;
  TextFieldType type;
  int maxLine;
  int maxLength;
  List<String>? autofillHints;
  Widget? prefixWid;
  Widget? suffixWid;
  List<TextInputFormatter>? formatter;
  TextEditingController? inputController;

  TextFieldOption(
      {this.text,
      this.labelText,
      this.hintText,
      this.isSecureTextField,
      this.keyboardType,
      this.type = TextFieldType.Normal,
      this.maxLine = 1,
      this.maxLength = 200,
      this.autofillHints,
      this.formatter,
      this.inputController,
      this.prefixWid,
      this.suffixWid});
}

enum TextFieldType {
  Normal,
  DropDown,
  Date,
  Time,
}
