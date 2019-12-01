import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

mixin PipValueMixin<C extends BaseCalculator<S, R>, S extends BaseState, R>
    on BaseCalculator<S, R> {
  C baseExchangeRate(double baseExchangeRate) {
    final sanitizedValue = sanitizeDouble(baseExchangeRate);
    return patchState<C>(BaseState(baseExchangeRate: sanitizedValue));
  }

  C baseListedSecond(bool baseListedSecond) {
    return patchState<C>(BaseState(baseListedSecond: baseListedSecond));
  }

  C pipPrecision(int pipPrecision) {
    return patchState<C>(BaseState(pipPrecision: pipPrecision));
  }

  C positionSize(double positionSize) {
    final sanitizedValue = sanitizeDouble(positionSize);
    return patchState<C>(BaseState(positionSize: sanitizedValue));
  }

  C tradingPairExchangeRate(double tradingPairExchangeRate) {
    final sanitizedValue = sanitizeDouble(tradingPairExchangeRate);
    return patchState<C>(BaseState(tradingPairExchangeRate: sanitizedValue));
  }

  double pipValue(S state) {
    final baseExchangeRate = state.baseExchangeRate;
    final baseListedSecond = state.baseListedSecond;
    final pipPrecision = state.pipPrecision;
    final positionSize = state.positionSize;
    final tradingPairExchangeRate = state.tradingPairExchangeRate;

    final decimalPip =
        Decimal.fromInt(1) / Decimal.fromInt(10).pow(pipPrecision);

    return (decimalPip /
            Decimal.parse(
                (baseListedSecond ? 1 : tradingPairExchangeRate).toString()) /
            Decimal.parse(
                (baseExchangeRate > 0 ? baseExchangeRate : 1).toString()) *
            Decimal.parse(positionSize.toString()))
        .toDouble();
  }

  double computePipValue() {
    if (isValid) {
      return pipValue(validState);
    }

    return 0.0;
  }
}
