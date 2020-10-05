import 'package:matex_dart/matex_dart.dart';

mixin MatexTakeProfitCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState(MatexBaseCoreState(entryPrice: sanitizedValue));
  }

  C position(MatexPosition position) {
    return patchState(MatexBaseCoreState(position: position));
  }

  C takeProfitAmount(double takeProfitAmount) {
    return patchState(MatexBaseCoreState(
      takeProfitPrice: 0.0,
      takeProfitPips: 0.0,
      takeProfitAmount: sanitizeDouble(takeProfitAmount),
    ));
  }

  C takeProfitPips(double takeProfitPips) {
    return patchState(MatexBaseCoreState(
      takeProfitPrice: 0.0,
      takeProfitPips: sanitizeDouble(takeProfitPips),
      takeProfitAmount: 0.0,
    ));
  }

  C takeProfitPrice(double takeProfitPrice) {
    return patchState(MatexBaseCoreState(
      takeProfitPrice: sanitizeDouble(takeProfitPrice),
      takeProfitPips: 0.0,
      takeProfitAmount: 0.0,
    ));
  }
}
