import 'package:flutter/material.dart';

class RoundBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double highestY = size.height * 0.3;
    var startPoint = Offset(0, size.height * 0.25);
    var controlPoint = Offset(size.width / 30, size.height * 0.275);
    var endPoint = Offset(size.width / 10, highestY);

    Path path = new Path();
    path.lineTo(0, 0);
    path.lineTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, highestY);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
