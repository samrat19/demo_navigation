import 'package:flutter/material.dart';

class NavCustomPainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;

  NavCustomPainter(
      double startingLoc, int itemsLength, this.color, this.textDirection) {
    final span = 1.0 / itemsLength;
    s = 0.2;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((loc- s * 0.15) * size.width, 0)
      ..cubicTo(
        (loc + s * 0.25) * size.width,
        -size.height * 0.1,
        (loc -s * 0.02) * size.width,
        -size.height * 1,
        (loc + s * 0.52) * size.width,
        -size.height * 1,
      )
      ..cubicTo(
        (loc + s + s * 0.25) * size.width,
        -size.height * 1,
        (loc + s - s * 0.15) * size.width,
        -size.height * 0.1,
        (loc + s + s * 0.3) * size.width,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, -size.height)
      ..lineTo(0, -size.height)
      ..close();
    canvas.drawPath(path, paint);
  }
  // @override
  // void paint(Canvas canvas, Size size) {
  //   final paint = Paint()
  //     ..color = color
  //     ..style = PaintingStyle.fill;

  //   final path = Path()
  //     ..moveTo(0, 45)
  //     ..lineTo((loc - 0.05) * size.width, 45)
  //     ..cubicTo(
  //       (loc + s * 0.2) * size.width,
  //      - size.height * 0.03,
  //       loc * size.width,
  //      - size.height * 0.30,
  //       (loc + s * 0.50) * size.width,
  //       -size.height * 0.30,
  //     )
  //     ..cubicTo(
  //       (loc + s) * size.width,
  //       -size.height * 0.30,
  //       (loc + s - s * 0.05) * size.width,
  //       -size.height * 0.03,
  //       (loc + s + 0.07) * size.width,
  //       45,
  //     )
  //     ..lineTo(size.width, 45)
  //     ..lineTo(size.width, -size.height)
  //     ..lineTo(0, -size.height)
  //     ..close();
  //   canvas.drawPath(path, paint);
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
