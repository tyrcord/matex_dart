import 'package:matex_dart/matex_dart.dart';

mixin MatexDividendReinvestmentCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C drip(bool value) {
    return patchState(MatexBaseCoreState(drip: value));
  }

  C taxRate(double rate) {
    return patchState(MatexBaseCoreState(taxRate: sanitizeDouble(rate)));
  }

  C dividendPaymentFrequency(MatexFrequency value) {
    return patchState(MatexBaseCoreState(dividendPaymentFrequency: value));
  }

  C annualSharePriceIncrease(double value) {
    return patchState(MatexBaseCoreState(
      annualSharePriceIncrease: sanitizeDouble(value),
    ));
  }

  C annualDividendIncrease(double value) {
    return patchState(MatexBaseCoreState(
      annualDividendIncrease: sanitizeDouble(value),
    ));
  }

  C annualContribution(double value) {
    return patchState(
      MatexBaseCoreState(annualContribution: sanitizeDouble(value)),
    );
  }

  C dividendYield(double value) {
    return patchState(MatexBaseCoreState(dividendYield: sanitizeDouble(value)));
  }

  C numberOfShares(double value) {
    return patchState(MatexBaseCoreState(
      numberOfShares: sanitizeDouble(value),
    ));
  }

  C sharePrice(double value) {
    return patchState(MatexBaseCoreState(sharePrice: sanitizeDouble(value)));
  }

  C yearsToGrow(int value) {
    return patchState(MatexBaseCoreState(yearsToGrow: value));
  }
}
