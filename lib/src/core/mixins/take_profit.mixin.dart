import 'package:matex_dart/matex_dart.dart';

mixin TakeProfitMixin<C extends BaseCalculator<S, R>, S extends BaseState, R>
    on BaseCalculator<S, R> {
  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState<C>(BaseState(entryPrice: sanitizedValue));
  }

  C position(Position position) {
    return patchState<C>(BaseState(position: position));
  }

  C takeProfitAmount(double takeProfitAmount) {
    final sanitizedValue = sanitizeDouble(takeProfitAmount);
    patchState<C>(BaseState(takeProfitPrice: 0.0));
    patchState<C>(BaseState(takeProfitPips: 0.0));
    return patchState<C>(BaseState(takeProfitAmount: sanitizedValue));
  }

  C takeProfitPips(double takeProfitPips) {
    final sanitizedValue = sanitizeDouble(takeProfitPips);
    patchState<C>(BaseState(takeProfitAmount: 0.0));
    patchState<C>(BaseState(takeProfitPrice: 0.0));
    return patchState<C>(BaseState(takeProfitPips: sanitizedValue));
  }

  C takeProfitPrice(double takeProfitPrice) {
    final sanitizedValue = sanitizeDouble(takeProfitPrice);
    patchState<C>(BaseState(takeProfitAmount: 0.0));
    patchState<C>(BaseState(takeProfitPips: 0.0));
    return patchState<C>(BaseState(takeProfitPrice: sanitizedValue));
  }
}
