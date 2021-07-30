import 'package:flutter/widgets.dart';
import 'package:flutter_task/all.exports.dart';

/// Builds a [DialogX] to inform about a feature being only available for
/// the pro version of app.
class MessageDialogX extends StatefulWidget {
  const MessageDialogX({
    required this.title,
    required this.message,
    required this.actions,
    this.mode,
  });

  /// The name of the feature.
  final String title;
  final String message;
  final DisplayMode? mode;
  final List<DialogAction> actions;

  @override
  _MessageDialogXState createState() => _MessageDialogXState();
}

class _MessageDialogXState extends State<MessageDialogX> {
  @override
  Widget build(BuildContext context) {
    return DialogX(
      title: widget.title,
      body: Column(
        children: <Widget>[
          Text(
            widget.message,
          ),
          const SizedBox(height: 12),
        ],
      ),
      actions: widget.actions,
    );
  }
}
