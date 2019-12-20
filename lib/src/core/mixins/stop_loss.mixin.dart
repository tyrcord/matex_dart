import 'package:matex_dart/matex_dart.dart';

mixin StopLossMixin<C extends BaseCalculator<C, S, R>, S extends BaseState, R>
    on BaseCalculator<C, S, R> {
  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState(BaseState(entryPrice: sanitizedValue));
  }

  C position(Position position) {
    return patchState(BaseState(position: position));
  }

  C stopLossAmount(double stopLossAmount) {
    final sanitizedValue = sanitizeDouble(stopLossAmount);
    patchState(BaseState(stopLossPips: 0.0));
    patchState(BaseState(stopLossPrice: 0.0));
    return patchState(BaseState(stopLossAmount: sanitizedValue));
  }

  C stopLossPips(double stopLossPips) {
    final sanitizedValue = sanitizeDouble(stopLossPips);
    patchState(BaseState(stopLossAmount: 0.0));
    patchState(BaseState(stopLossPrice: 0.0));
    return patchState(BaseState(stopLossPips: sanitizedValue));
  }

  C stopLossPrice(double stopLossPrice) {
    final sanitizedValue = sanitizeDouble(stopLossPrice);
    patchState(BaseState(stopLossAmount: 0.0));
    patchState(BaseState(stopLossPips: 0.0));
    return patchState(BaseState(stopLossPrice: sanitizedValue));
  }
}
