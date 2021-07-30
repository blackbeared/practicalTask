import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';

/// Animated Wave Icon widget.
/// [size] for widget icon size
/// [icon] for widget icon
/// [waveColor] for background wave
/// [iconColor] for container icon
class AnimatedWaveIconWidget extends StatelessWidget {
  final double size;
  final IconData icon;
  final Color waveColor;
  final Color? iconColor;

  const AnimatedWaveIconWidget(
      {Key? key,
      required this.size,
      required this.icon,
      this.waveColor = Colors.white38,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBackgroundWidget(size: size + size / 3, color: Colors.white38),
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(size)),
          child: Icon(
            icon,
            color: iconColor ?? AppTheme.of(context).secondaryColor,
            size: size / 2,
          ),
        ),
      ],
    );
  }
}

/// Animated Wave background widget.
/// [size] for widget icon size
/// [color] for background color
class AnimatedBackgroundWidget extends StatefulWidget {
  final double size;
  final Color color;

  const AnimatedBackgroundWidget({required this.size, required this.color});

  @override
  _AnimatedBackgroundWidgetState createState() =>
      _AnimatedBackgroundWidgetState();
}

class _AnimatedBackgroundWidgetState extends State<AnimatedBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    animation = Tween(begin: 0.5, end: 1.0)
        .animate(animationController)
        .drive(CurveTween(curve: Curves.easeOut));
    animationController.addStatusListener(animationStatusListener);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.removeStatusListener(animationStatusListener);
    animationController.dispose();
    super.dispose();
  }

  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final size = widget.size * (animation.value);
          return Center(
            child: Container(
              width: size.toDouble(),
              height: size.toDouble(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(size / 2),
                ),
                color: widget.color,
              ),
            ),
          );
        },
      ),
    );
  }
}
