import 'package:matex_dart/matex_dart.dart';

mixin PivotPointsMixin<C extends BaseCalculator<C, S, R>, S extends BaseState,
    R> on BaseCalculator<C, S, R> {
  C closePrice(double closePrice) {
    final sanitizedValue = sanitizeDouble(closePrice);
    return patchState(BaseState(closePrice: sanitizedValue));
  }

  C highPrice(double highPrice) {
    final sanitizedValue = sanitizeDouble(highPrice);
    return patchState(BaseState(highPrice: sanitizedValue));
  }

  C lowPrice(double lowPrice) {
    final sanitizedValue = sanitizeDouble(lowPrice);
    return patchState(BaseState(lowPrice: sanitizedValue));
  }

  C method(PivotPointsMethods method) {
    return patchState(BaseState(method: method));
  }

  C openPrice(double openPrice) {
    final sanitizedValue = sanitizeDouble(openPrice);
    return patchState(BaseState(openPrice: sanitizedValue));
  }
}
