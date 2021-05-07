import 'package:matex_dart/matex_dart.dart';

mixin MatexDividendPayoutRatioCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C totalDividend(double value) {
    return patchState(MatexBaseCoreState(totalDividend: sanitizeDouble(value)));
  }

  C netIncome(double value) {
    return patchState(MatexBaseCoreState(netIncome: sanitizeDouble(value)));
  }
}
