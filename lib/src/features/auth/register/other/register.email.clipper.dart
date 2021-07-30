import 'package:flutter/widgets.dart';

/*
*   RegisterBackgroundClipper is a class to clip widget with customized shape.
*   Curvature - Value to be passed for defining top corner radius
* */
class RegisterBackgroundClipper extends CustomClipper<Path> {
  final int curvature;

  const RegisterBackgroundClipper(this.curvature);

  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, curvature.toDouble());
    path.quadraticBezierTo(size.width, curvature / 2,
        size.width - curvature / 2, curvature / 2 - curvature / 20);
    path.lineTo(curvature / 1.5, curvature / 10);
    path.quadraticBezierTo(0.0, 0.0, 0.0, curvature / 1.5);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
