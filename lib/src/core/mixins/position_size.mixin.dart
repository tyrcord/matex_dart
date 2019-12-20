import 'package:matex_dart/matex_dart.dart';

mixin PositionSizeMarginMixin<C extends BaseCalculator<C, S, R>,
    S extends BaseState, R> on BaseCalculator<C, S, R> {
  C accountSize(double accountSize) {
    final sanitizedValue = sanitizeDouble(accountSize);
    return patchState(BaseState(accountSize: sanitizedValue));
  }

  C amountAtRisk(double amountAtRisk) {
    final sanitizedValue = sanitizeDouble(amountAtRisk);
    return patchState(BaseState(
      amountAtRisk: sanitizedValue,
      riskRatio: 0,
    ));
  }

  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState(BaseState(entryPrice: sanitizedValue, stopLossPips: 0));
  }

  C riskRatio(double riskRatio) {
    final sanitizedValue = sanitizeDouble(riskRatio);
    return patchState(BaseState(riskRatio: sanitizedValue, amountAtRisk: 0));
  }

  C stopLossPips(double stopLossPips) {
    final sanitizedValue = sanitizeDouble(stopLossPips);
    return patchState(BaseState(
      stopLossPips: sanitizedValue,
      stopLossPrice: 0,
      entryPrice: 0,
    ));
  }

  C stopLossPrice(double stopLossPrice) {
    final sanitizedValue = sanitizeDouble(stopLossPrice);
    return patchState(BaseState(
      stopLossPrice: sanitizedValue,
      stopLossPips: 0,
    ));
  }
}
