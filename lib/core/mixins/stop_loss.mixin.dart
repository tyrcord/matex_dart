import 'package:matex_dart/matex_dart.dart';

mixin MatexStopLossCoreMixin<C extends MatexBaseCalculator<C, S, R>,
    S extends MatexBaseCoreState, R> on MatexBaseCalculator<C, S, R> {
  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState(MatexBaseCoreState(entryPrice: sanitizedValue));
  }

  C position(MatexPosition position) {
    return patchState(MatexBaseCoreState(position: position));
  }

  C stopLossAmount(double stopLossAmount) {
    final sanitizedValue = sanitizeDouble(stopLossAmount);
    patchState(MatexBaseCoreState(stopLossPips: 0.0));
    patchState(MatexBaseCoreState(stopLossPrice: 0.0));
    return patchState(MatexBaseCoreState(stopLossAmount: sanitizedValue));
  }

  C stopLossPips(double stopLossPips) {
    final sanitizedValue = sanitizeDouble(stopLossPips);
    patchState(MatexBaseCoreState(stopLossAmount: 0.0));
    patchState(MatexBaseCoreState(stopLossPrice: 0.0));
    return patchState(MatexBaseCoreState(stopLossPips: sanitizedValue));
  }

  C stopLossPrice(double stopLossPrice) {
    final sanitizedValue = sanitizeDouble(stopLossPrice);
    patchState(MatexBaseCoreState(stopLossAmount: 0.0));
    patchState(MatexBaseCoreState(stopLossPips: 0.0));
    return patchState(MatexBaseCoreState(stopLossPrice: sanitizedValue));
  }
}
