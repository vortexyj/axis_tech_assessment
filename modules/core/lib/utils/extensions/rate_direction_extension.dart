import 'dart:ui';

/// Direction of an exchange rate's change since the previous reading.
enum RateDirection { up, down, flat }

/// Reads a rate-change value (e.g. the absolute or percentage change) and
/// exposes its direction and display color.
///
/// Color rule: EGP weakens (rate went up) -> red. EGP strengthens (rate went
/// down) -> green. No meaningful change -> neutral gray. These hex values
/// mirror `AppColors.errorColor` / `successColor` / `neutralColor` in
/// ui_components — core can't depend on that module, so they're duplicated
/// here and must be kept in sync if the palette changes.
extension RateChangeX on num {
  RateDirection get direction {
    if (this > 0) return RateDirection.up;
    if (this < 0) return RateDirection.down;
    return RateDirection.flat;
  }

  Color get directionColor {
    switch (direction) {
      case RateDirection.up:
        return const Color(0xFFDC2626);
      case RateDirection.down:
        return const Color(0xFF16A34A);
      case RateDirection.flat:
        return const Color(0xFF9AA0AC);
    }
  }
}
