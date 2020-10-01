import 'package:matex_dart/matex_dart.dart';

mixin MatexTakeProfitCoreMixin<C extends MatexBaseCalculator<C, S, R>,
    S extends MatexBaseCoreState, R> on MatexBaseCalculator<C, S, R> {
  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState(MatexBaseCoreState(entryPrice: sanitizedValue));
  }

  C position(MatexPosition position) {
    return patchState(MatexBaseCoreState(position: position));
  }

  C takeProfitAmount(double takeProfitAmount) {
    final sanitizedValue = sanitizeDouble(takeProfitAmount);
    patchState(MatexBaseCoreState(takeProfitPrice: 0.0));
    patchState(MatexBaseCoreState(takeProfitPips: 0.0));
    return patchState(MatexBaseCoreState(takeProfitAmount: sanitizedValue));
  }

  C takeProfitPips(double takeProfitPips) {
    final sanitizedValue = sanitizeDouble(takeProfitPips);
    patchState(MatexBaseCoreState(takeProfitAmount: 0.0));
    patchState(MatexBaseCoreState(takeProfitPrice: 0.0));
    return patchState(MatexBaseCoreState(takeProfitPips: sanitizedValue));
  }

  C takeProfitPrice(double takeProfitPrice) {
    final sanitizedValue = sanitizeDouble(takeProfitPrice);
    patchState(MatexBaseCoreState(takeProfitAmount: 0.0));
    patchState(MatexBaseCoreState(takeProfitPips: 0.0));
    return patchState(MatexBaseCoreState(takeProfitPrice: sanitizedValue));
  }
}
