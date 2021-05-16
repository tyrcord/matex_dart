import 'package:matex_dart/matex_dart.dart';

mixin MatexDividendYieldCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C totalDividend(double value) {
    return patchState(MatexBaseCoreState(totalDividend: sanitizeDouble(value)));
  }

  C sharePrice(double value) {
    return patchState(MatexBaseCoreState(sharePrice: sanitizeDouble(value)));
  }

  C dividendPaymentFrequency(MatexFrequency value) {
    return patchState(MatexBaseCoreState(dividendPaymentFrequency: value));
  }
}
