import 'package:matex_dart/matex_dart.dart';

mixin MatexPositionSizeMarginCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C accountSize(double accountSize) {
    final sanitizedValue = sanitizeDouble(accountSize);

    return patchState(MatexBaseCoreState(accountSize: sanitizedValue));
  }

  C amountAtRisk(double amountAtRisk) {
    final sanitizedValue = sanitizeDouble(amountAtRisk);

    return patchState(MatexBaseCoreState(
      amountAtRisk: sanitizedValue,
      riskRatio: 0,
    ));
  }

  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);

    return patchState(MatexBaseCoreState(
      entryPrice: sanitizedValue,
      stopLossPips: 0,
    ));
  }

  C riskRatio(double riskRatio) {
    final sanitizedValue = sanitizeDouble(riskRatio);

    return patchState(MatexBaseCoreState(
      riskRatio: sanitizedValue,
      amountAtRisk: 0,
    ));
  }

  C stopLossPips(double stopLossPips) {
    final sanitizedValue = sanitizeDouble(stopLossPips);

    return patchState(MatexBaseCoreState(
      stopLossPips: sanitizedValue,
      stopLossPrice: 0,
      entryPrice: 0,
    ));
  }

  C stopLossPrice(double stopLossPrice) {
    final sanitizedValue = sanitizeDouble(stopLossPrice);

    return patchState(MatexBaseCoreState(
      stopLossPrice: sanitizedValue,
      stopLossPips: 0,
    ));
  }
}
