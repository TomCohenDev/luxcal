import 'dart:math';

import 'package:flutter/material.dart';

enum QuarterPosition { topRight, topLeft, bottomLeft, bottomRight }

class QuarterCirclePainter extends CustomPainter {
  final Color color;
  final QuarterPosition position;

  QuarterCirclePainter(this.color, this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final Rect rect = Rect.fromCircle(
        center: position == QuarterPosition.topRight ||
                position == QuarterPosition.bottomRight
            ? Offset(size.width, size.height / 2)
            : Offset(0, size.height / 2),
        radius: size.width);

    double startAngle;
    switch (position) {
      case QuarterPosition.topRight:
        startAngle = 1.5 * pi;
        break;
      case QuarterPosition.topLeft:
        startAngle = pi;
        break;
      case QuarterPosition.bottomLeft:
        startAngle = 0.5 * pi;
        break;
      case QuarterPosition.bottomRight:
      default:
        startAngle = 0;
        break;
    }

    canvas.drawArc(rect, startAngle, 0.5 * pi, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class QuarterCircle extends StatelessWidget {
  final Color color;
  final QuarterPosition position;

  QuarterCircle({required this.color, this.position = QuarterPosition.topRight});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: QuarterCirclePainter(color, position),
    );
  }
}

