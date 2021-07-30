import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

/// The base for the [ButtonX].
///
/// Uses [AnimatedScale] to have the button appear pressed down while it is
/// tapped.
class _ButtonXBase extends StatefulWidget {
  const _ButtonXBase({
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  _ButtonXBaseState createState() => _ButtonXBaseState();
}

class _ButtonXBaseState extends State<_ButtonXBase> {
  bool _tapDown = false;

  void _updateTapDown(bool value) {
    if (widget.onTap != null && _tapDown != value) {
      setState(() {
        _tapDown = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _tapDown ? .9 : 1,
      child: GestureDetector(
        onTapDown: (_) => _updateTapDown(true),
        onTapUp: (_) => _updateTapDown(false),
        onTapCancel: () => _updateTapDown(false),
        onTap: widget.onTap,
        child: widget.child,
      ),
    );
  }
}

/// A custom button with a rounded border that uses an [AnimatedScale] to
/// appear pressed down on tap.
///
/// The [ButtonX.raised] builds a button with elevation and a
/// [backgroundColor].
///
/// The [ButtonX.flat] builds a flat button with a transparent background.
///
/// The button can have an [startIcon] and [text]. When both are not `null`, the
/// icon is built to the left of the text with a padding in between that is
/// half of its vertical padding.
///
/// Alternatively to [startIcon], an [iconBuilder] can be used to build the icon
/// widget with more control.
///
/// Either [startIcon], [iconBuilder] or [text] must not be `null`.
//ignore: must_be_immutable
class ButtonX extends StatelessWidget {
  final Key key;

  /// A button that appears raised with a shadow.
  ///
  /// Uses the [ThemeData.buttonColor] as the [backgroundColor] by default.
  ButtonX(
      {required this.onTap,
      required this.buttonOptions,
      this.text,
      this.startIcon,
      this.iconSize,
      this.fitWidth = false,
      this.foregroundColor,
      this.borderRadius,
      this.endIcon,
      this.materialType = MaterialType.canvas,
      this.elevation = 8,
      this.buttonSize = md,
      required this.key})
      : super(key: key);

  /// The [text] of the button.
  ///
  /// Can be `null` if the button has no text.
  final String? text;

  late ButtonOptions buttonOptions;

  /// The [startIcon] of the button.
  ///
  /// Can be `null` if the button has no icon.
  final IconData? startIcon;
  final IconData? endIcon;

  /// The size of the [startIcon];
  final double? iconSize;

  final Size buttonSize;

  /// The callback when the button is tapped.
  ///
  /// If `null`, the button is slightly transparent to appear disabled.
  final VoidCallback? onTap;

  final double? borderRadius;

  /// The color of the [startIcon] and [text] of the button.
  ///
  /// Defaults to [TextTheme.button] if the [backgroundColor] is `null`,
  /// to the [TextTheme.bodyText1] color if the [backgroundColor] is transparent
  /// or to a complimentary color when [backgroundColor] is set.
  final Color? foregroundColor;

  /// Whether or not the button should have less padding.
  ///
  /// Has no effect if [padding] is not `null`.
  final bool fitWidth;

  /// The [elevation] that changes when using a [ButtonX.flat] or
  /// [ButtonX.raised].
  final double elevation;

  /// Determines the material type that the button uses as its background.
  ///
  /// Set to [MaterialType.transparency] for [ButtonX.flat] and
  /// [MaterialType.canvas] for [ButtonX.raised].
  final MaterialType materialType;

  EdgeInsets get _padding => EdgeInsets.symmetric(
        vertical: buttonSize.height,
        horizontal: buttonSize.width,
      );

  /// Builds the row with the [Icon] and [Text] widget.
  Widget _buildContent(BuildContext context, ButtonOptions buttonOptions) {
    final theme = AppTheme.of(context).themeData;

    Widget? iconWidget;
    Widget? endIconWidget;
    Widget? textWidget;

    if (text != null) {
      // need to make sure the text overflow is handled when the button size is
      // constrained, for example during an AnimatedCrossFade transition
      textWidget = Text(
        text.toString(),
        textAlign: fitWidth ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.button!.copyWith(
            fontWeight: FontWeight.bold, color: buttonOptions.textColor),
        overflow: TextOverflow.fade,
        softWrap: false,
      );
    }

    if (startIcon != null) {
      iconWidget = Icon(startIcon, color: this.buttonOptions.textColor);
    }

    if (endIcon != null) {
      endIconWidget = Icon(startIcon, color: this.buttonOptions.textColor);
    }

    return IntrinsicWidth(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (iconWidget != null) iconWidget,
          if (iconWidget != null && textWidget != null)
            SizedBox(width: _padding.vertical / 4),
          if (textWidget != null) Expanded(child: textWidget),
          if (endIconWidget != null && textWidget != null)
            SizedBox(width: _padding.vertical / 4),
          if (endIconWidget != null) endIconWidget,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context).themeData;
    final borderRadius =
        BorderRadius.circular(this.borderRadius ?? kCardRadiusExtraSmall);

    buttonOptions.backgroundColor = [
      buttonOptions.backgroundColor.first.withOpacity(onTap == null ? 0.6 : 1),
      buttonOptions.backgroundColor.last.withOpacity(onTap == null ? 0.6 : 1)
    ];
    buttonOptions.textColor =
        buttonOptions.textColor.withOpacity(onTap == null ? 0.6 : 1);

    return _ButtonXBase(
      onTap: onTap,
      child: AnimatedTheme(
        data: ThemeData(
          canvasColor: Colors.transparent,
          textTheme: TextTheme(
            button: theme.textTheme.button!
                .copyWith(color: buttonOptions.textColor),
          ),
          iconTheme:
              IconThemeData(color: buttonOptions.textColor, size: iconSize),
        ),
        child: Material(
          color: Colors.transparent,
          type: materialType,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                    colors: buttonOptions.backgroundColor,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: elevation == 0 || onTap == null
                    ? []
                    : getDefaultBoxShadow(
                        color: buttonOptions.backgroundColor,
                        elevation: elevation,
                        blurr: elevation)),
            width: fitWidth ? MediaQuery.of(context).size.width : null,
            child: Padding(
              padding: _padding,
              child: Builder(
                builder: (context) => _buildContent(context, buttonOptions),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonOptions {
  Border buttonBorder;
  List<Color> backgroundColor;
  Color textColor;

  ButtonOptions(
      {required this.buttonBorder,
      required this.backgroundColor,
      required this.textColor});
}
