import 'package:matex_dart/matex_dart.dart';

mixin TakeProfitMixin<C extends BaseCalculator<C, S, R>, S extends BaseState, R>
    on BaseCalculator<C, S, R> {
  C entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState(BaseState(entryPrice: sanitizedValue));
  }

  C position(Position position) {
    return patchState(BaseState(position: position));
  }

  C takeProfitAmount(double takeProfitAmount) {
    final sanitizedValue = sanitizeDouble(takeProfitAmount);
    patchState(BaseState(takeProfitPrice: 0.0));
    patchState(BaseState(takeProfitPips: 0.0));
    return patchState(BaseState(takeProfitAmount: sanitizedValue));
  }

  C takeProfitPips(double takeProfitPips) {
    final sanitizedValue = sanitizeDouble(takeProfitPips);
    patchState(BaseState(takeProfitAmount: 0.0));
    patchState(BaseState(takeProfitPrice: 0.0));
    return patchState(BaseState(takeProfitPips: sanitizedValue));
  }

  C takeProfitPrice(double takeProfitPrice) {
    final sanitizedValue = sanitizeDouble(takeProfitPrice);
    patchState(BaseState(takeProfitAmount: 0.0));
    patchState(BaseState(takeProfitPips: 0.0));
    return patchState(BaseState(takeProfitPrice: sanitizedValue));
  }
}
