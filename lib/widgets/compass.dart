import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class Compass extends StatefulWidget {
  Compass({Key key}) : super(key: key);

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double _heading = 0;
  StreamSubscription compassPos;

  String get _readout => _heading.toStringAsFixed(0) + '°';

  @override
  void initState() {
    super.initState();
    compassPos = FlutterCompass.events.listen((double x) {
      setState(() {
        _heading = x;
      });
      print("NEW HEADING $x");
    });
  }


  @override
  void dispose() {
    super.dispose();
    compassPos.cancel();
  }

  final TextStyle _style = TextStyle(
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        foregroundPainter: CompassPainter(angle: _heading),
        child: Center(child: Text(_readout, style: _style)));
  }
}

class CompassPainter extends CustomPainter {
  CompassPainter({@required this.angle}) : super();

  final double angle;
  double get rotation => -2 * pi * (angle / 360);

  Paint get _brush => new Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = _brush..color = Colors.black26;

    Paint needle = _brush
      ..color = Colors.black
      ..strokeWidth = 2;

    double radius = min(size.width / 2, size.height / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    double startRadiusPercent = 0.7;
    double endRadiusPercent = 0.9;

    Offset start = Offset(center.dx + radius * startRadiusPercent * cos(angle),
        center.dy + radius * startRadiusPercent * sin(angle));
    Offset end = Offset(center.dx + radius * endRadiusPercent * cos(angle),
        center.dy + radius * endRadiusPercent * sin(angle));

    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(start, end, needle);
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
