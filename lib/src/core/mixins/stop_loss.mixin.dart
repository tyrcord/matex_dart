import 'package:matex_dart/matex_dart.dart';

mixin StopLossMixin<C extends BaseCalculator<S, R>, S extends BaseState, R>
    on BaseCalculator<S, R> {
  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState<C>(BaseState(entryPrice: sanitizedValue));
  }

  C position(Position position) {
    return patchState<C>(BaseState(position: position));
  }

  C stopLossAmount(double stopLossAmount) {
    final sanitizedValue = sanitizeDouble(stopLossAmount);
    patchState<C>(BaseState(stopLossPips: 0.0));
    patchState<C>(BaseState(stopLossPrice: 0.0));
    return patchState<C>(BaseState(stopLossAmount: sanitizedValue));
  }

  C stopLossPips(double stopLossPips) {
    final sanitizedValue = sanitizeDouble(stopLossPips);
    patchState<C>(BaseState(stopLossAmount: 0.0));
    patchState<C>(BaseState(stopLossPrice: 0.0));
    return patchState<C>(BaseState(stopLossPips: sanitizedValue));
  }

  C stopLossPrice(double stopLossPrice) {
    final sanitizedValue = sanitizeDouble(stopLossPrice);
    patchState<C>(BaseState(stopLossAmount: 0.0));
    patchState<C>(BaseState(stopLossPips: 0.0));
    return patchState<C>(BaseState(stopLossPrice: sanitizedValue));
  }
}
