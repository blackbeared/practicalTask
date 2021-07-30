import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

/// A styled dialog used with [showDialog].
///
/// If the [actions] contain discard and confirm actions, the discard action
/// should always be on the left while the confirm action should be on the
/// right.
class DialogX extends StatelessWidget {
  const DialogX({
    required this.actions,
    this.title,
    this.text,
    this.body,
    this.scrollPhysics,
  });

  final String? title;
  final List<DialogAction>? actions;

  /// The text is build below the [title] if not `null`.
  final String? text;

  /// The body is build below the [text] if not `null`.
  final Widget? body;

  /// The colors used by the [PrimaryContainer].
  ///
  final ScrollPhysics? scrollPhysics;

  List<Widget> _buildContent(BuildContext context) {
    return [
      if (title != null) ...[
        Text(title!, style: context.headline4, textAlign: TextAlign.center),
        const SizedBox(height: 12),
      ],
      if (text != null) ...[
        Text(text!, style: context.bodyText2, textAlign: TextAlign.center),
        const SizedBox(height: 12),
      ],
      if (body != null) ...[
        body!,
        const SizedBox(height: 12),
      ],
      const SizedBox(height: 12),
    ];
  }

  Widget _buildActions() {
    if (actions!.length > 1) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: actions!,
        ),
      );
    } else if (actions!.length == 1) {
      return actions!.first;
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kCardRadius),
        ),
        child: Container(
          width: double.infinity,
          // less on the bottom to compensate for the button padding
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  physics: scrollPhysics,
                  children: _buildContent(context),
                ),
              ),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }
}

/// An action for a [DialogX].
///
/// If [result] is not `null` the action will pop the dialog with the [result].
/// If [onTap] is not `null` the action will execute the callback.
///
/// The action will build a text button with [text] or an icon button with
/// [icon].
///
/// Either [text] or [icon] must not be `null`.
//ignore: must_be_immutable
class DialogAction<T> extends StatelessWidget {
  Key key;

  DialogAction(this.key,
      {this.result, this.onTap, this.text, this.icon, this.color})
      : assert(text != null || icon != null),
        super(key: key);

  final T? result;
  final VoidCallback? onTap;
  final String? text;
  final IconData? icon;
  Color? color;

  static DialogAction<bool> discard = DialogAction(
    GlobalKey(),
    result: false,
    icon: Icons.close,
  );

  static DialogAction<bool> confirm = DialogAction(
    GlobalKey(),
    result: true,
    icon: Icons.check,
  );

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      color = AppTheme.of(context).primaryColor;
    }

    final Function? callback =
        onTap != null ? onTap : () => Navigator.of(context).pop(result);

    if (text != null) {
      return ButtonX(
        key: key,
        text: text,
        onTap: callback as void Function()?,
        buttonOptions: context.theme.btnOutlineLight,
      );
    } else if (icon != null) {
      return ButtonX(
        key: key,
        startIcon: icon,
        onTap: callback as void Function()?,
        buttonOptions: context.theme.btnOutlineLight,
      );
    } else {
      return Container();
    }
  }
}
