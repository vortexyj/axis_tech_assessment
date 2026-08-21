import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../text_styles.dart';

class RateChangeText extends StatelessWidget {
  const RateChangeText({
    super.key,
    required this.change,
    required this.label,
    this.style,
    this.glyphSize = 8,
  });

  final num change;
  final String label;
  final TextStyle? style;
  final double glyphSize;

  @override
  Widget build(BuildContext context) {
    final color = change.directionColor;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: Size.square(glyphSize),
          painter: _DirectionGlyphPainter(
            direction: change.direction,
            color: color,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: (style ?? TextStyles.changeText).copyWith(color: color),
        ),
      ],
    );
  }
}

class _DirectionGlyphPainter extends CustomPainter {
  const _DirectionGlyphPainter({required this.direction, required this.color});

  final RateDirection direction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    if (direction == RateDirection.flat) {
      final rect = Rect.fromLTWH(0, size.height / 2 - 1, size.width, 2);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(1)),
        paint,
      );
      return;
    }

    final path = Path();
    if (direction == RateDirection.up) {
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _DirectionGlyphPainter oldDelegate) {
    return oldDelegate.direction != direction || oldDelegate.color != color;
  }
}
