import 'package:matex_dart/matex_dart.dart';

mixin FibonacciLevelsMixin<C extends BaseCalculator<C, S, R>,
    S extends BaseState, R> on BaseCalculator<C, S, R> {
  C customPrice(double customPrice) {
    final sanitizedValue = sanitizeDouble(customPrice);
    return patchState(BaseState(customPrice: sanitizedValue));
  }

  C extensionLevels(List<double> extensionLevels) {
    final sanitizedValue = extensionLevels.map((level) {
      return sanitizeDouble(level);
    }).toList();

    sanitizedValue.sort(sortNumberAsc);
    return patchState(BaseState(extensionLevels: sanitizedValue));
  }

  C highPrice(double highPrice) {
    final sanitizedValue = sanitizeDouble(highPrice);
    return patchState(BaseState(highPrice: sanitizedValue));
  }

  C lowPrice(double lowPrice) {
    final sanitizedValue = sanitizeDouble(lowPrice);
    return patchState(BaseState(lowPrice: sanitizedValue));
  }

  C precision(int precision) {
    return patchState(BaseState(precision: precision));
  }

  C retracementLevels(List<double> retracementLevels) {
    final sanitizedValue = retracementLevels.map((level) {
      return sanitizeDouble(level);
    }).toList();

    sanitizedValue.sort(sortNumberAsc);

    return patchState(BaseState(retracementLevels: sanitizedValue));
  }

  C trend(Trend trend) {
    return patchState(BaseState(trend: trend));
  }
}
