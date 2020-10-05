import 'package:matex_dart/matex_dart.dart';

mixin MatexStopLossCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState(MatexBaseCoreState(entryPrice: sanitizedValue));
  }

  C position(MatexPosition position) {
    return patchState(MatexBaseCoreState(position: position));
  }

  C stopLossAmount(double stopLossAmount) {
    return patchState(MatexBaseCoreState(
      stopLossPrice: 0.0,
      stopLossPips: 0.0,
      stopLossAmount: sanitizeDouble(stopLossAmount),
    ));
  }

  C stopLossPips(double stopLossPips) {
    return patchState(MatexBaseCoreState(
      stopLossPrice: 0.0,
      stopLossPips: sanitizeDouble(stopLossPips),
      stopLossAmount: 0.0,
    ));
  }

  C stopLossPrice(double stopLossPrice) {
    return patchState(MatexBaseCoreState(
      stopLossPrice: sanitizeDouble(stopLossPrice),
      stopLossPips: 0.0,
      stopLossAmount: 0.0,
    ));
  }
}
