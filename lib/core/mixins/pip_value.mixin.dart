import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

mixin MatexPipValueCoreMixin<C extends MatexBaseCalculator<C, S, R>,
    S extends MatexBaseCoreState, R> on MatexBaseCalculator<C, S, R> {
  C baseExchangeRate(double baseExchangeRate) {
    final sanitizedValue = sanitizeDouble(baseExchangeRate);
    return patchState(MatexBaseCoreState(baseExchangeRate: sanitizedValue));
  }

  C baseListedSecond(bool baseListedSecond) {
    return patchState(MatexBaseCoreState(baseListedSecond: baseListedSecond));
  }

  C pipPrecision(int pipPrecision) {
    return patchState(MatexBaseCoreState(pipPrecision: pipPrecision));
  }

  C positionSize(double positionSize) {
    final sanitizedValue = sanitizeDouble(positionSize);
    return patchState(MatexBaseCoreState(positionSize: sanitizedValue));
  }

  C tradingPairExchangeRate(double tradingPairExchangeRate) {
    final sanitizedValue = sanitizeDouble(tradingPairExchangeRate);
    return patchState(
        MatexBaseCoreState(tradingPairExchangeRate: sanitizedValue));
  }

  @protected
  Decimal pipValue(S state) {
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
        Decimal.parse(positionSize.toString()));
  }

  @protected
  Decimal computePipValue() {
    if (isValid) {
      return pipValue(validState);
    }

    return Decimal.fromInt(0);
  }
}
