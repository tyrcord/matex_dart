import 'package:matex_dart/matex_dart.dart';

mixin MatexPivotPointsCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C closePrice(double closePrice) {
    final sanitizedValue = sanitizeDouble(closePrice);
    return patchState(MatexBaseCoreState(closePrice: sanitizedValue));
  }

  C highPrice(double highPrice) {
    final sanitizedValue = sanitizeDouble(highPrice);
    return patchState(MatexBaseCoreState(highPrice: sanitizedValue));
  }

  C lowPrice(double lowPrice) {
    final sanitizedValue = sanitizeDouble(lowPrice);
    return patchState(MatexBaseCoreState(lowPrice: sanitizedValue));
  }

  C method(MatexPivotPointsMethods method) {
    return patchState(MatexBaseCoreState(method: method));
  }

  C openPrice(double openPrice) {
    final sanitizedValue = sanitizeDouble(openPrice);
    return patchState(MatexBaseCoreState(openPrice: sanitizedValue));
  }
}
