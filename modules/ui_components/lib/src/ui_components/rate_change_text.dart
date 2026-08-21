import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../text_styles.dart';

class RateChangeText extends StatelessWidget {
  const RateChangeText({
    super.key,
    required this.absoluteChange,
    required this.percentChange,
    this.style,
    this.glyphSize = 8,
  });

  final num absoluteChange;
  final num percentChange;
  final TextStyle? style;
  final double glyphSize;

  @override
  Widget build(BuildContext context) {
    final color = absoluteChange.directionColor;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: Size.square(glyphSize),
          painter: _DirectionGlyphPainter(
            direction: absoluteChange.direction,
            color: color,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          _label,
          style: (style ?? TextStyles.changeText).copyWith(color: color),
        ),
      ],
    );
  }

  String get _label {
    final sign = absoluteChange > 0
        ? '+'
        : absoluteChange < 0
            ? '-'
            : '~';
    final abs = absoluteChange.abs().toStringAsFixed(3);
    final pct = percentChange.abs().toStringAsFixed(2);
    return '$sign$abs · $sign$pct%';
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
