import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RateChangeX.direction', () {
    test('positive change is up', () {
      expect(0.226.direction, RateDirection.up);
    });

    test('negative change is down', () {
      expect((-0.226).direction, RateDirection.down);
    });

    test('zero change is flat', () {
      expect(0.direction, RateDirection.flat);
      expect(0.0.direction, RateDirection.flat);
    });
  });

  group('RateChangeX.directionColor', () {
    test('up is red — EGP weakens', () {
      expect(1.directionColor, const Color(0xFFDC2626));
    });

    test('down is green — EGP strengthens', () {
      expect((-1).directionColor, const Color(0xFF16A34A));
    });

    test('flat is neutral gray', () {
      expect(0.directionColor, const Color(0xFF9AA0AC));
    });
  });
}
