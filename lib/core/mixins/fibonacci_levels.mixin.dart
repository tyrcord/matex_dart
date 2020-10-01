import 'package:matex_dart/matex_dart.dart';

mixin MatexFibonacciLevelsCoreMixin<C extends MatexBaseCalculator<C, S, R>,
    S extends MatexBaseCoreState, R> on MatexBaseCalculator<C, S, R> {
  C customPrice(double customPrice) {
    final sanitizedValue = sanitizeDouble(customPrice);
    return patchState(MatexBaseCoreState(customPrice: sanitizedValue));
  }

  C extensionLevels(List<double> extensionLevels) {
    final sanitizedValue = extensionLevels.map((level) {
      return sanitizeDouble(level);
    }).toList();

    sanitizedValue.sort(sortNumberAsc);
    return patchState(MatexBaseCoreState(extensionLevels: sanitizedValue));
  }

  C highPrice(double highPrice) {
    final sanitizedValue = sanitizeDouble(highPrice);
    return patchState(MatexBaseCoreState(highPrice: sanitizedValue));
  }

  C lowPrice(double lowPrice) {
    final sanitizedValue = sanitizeDouble(lowPrice);
    return patchState(MatexBaseCoreState(lowPrice: sanitizedValue));
  }

  C precision(int precision) {
    return patchState(MatexBaseCoreState(precision: precision));
  }

  C retracementLevels(List<double> retracementLevels) {
    final sanitizedValue = retracementLevels.map((level) {
      return sanitizeDouble(level);
    }).toList();

    sanitizedValue.sort(sortNumberAsc);

    return patchState(MatexBaseCoreState(retracementLevels: sanitizedValue));
  }

  C trend(MatexTrend trend) {
    return patchState(MatexBaseCoreState(trend: trend));
  }
}
