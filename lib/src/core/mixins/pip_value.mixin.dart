import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

mixin PipValueMixin<C, S extends BaseState, R> on BaseCalculator<S, R> {
  C baseExchangeRate(double baseExchangeRate) {
    final sanitizedValue = sanitizeDouble(baseExchangeRate);
    return patchState(BaseState(baseExchangeRate: sanitizedValue)) as C;
  }

  C baseListedSecond(bool baseListedSecond) {
    return patchState(BaseState(baseListedSecond: baseListedSecond)) as C;
  }

  C pipPrecision(int pipPrecision) {
    return patchState(BaseState(pipPrecision: pipPrecision)) as C;
  }

  C positionSize(double positionSize) {
    final sanitizedValue = sanitizeDouble(positionSize);
    return patchState(BaseState(positionSize: sanitizedValue)) as C;
  }

  C tradingPairExchangeRate(double tradingPairExchangeRate) {
    final sanitizedValue = sanitizeDouble(tradingPairExchangeRate);
    return patchState(BaseState(tradingPairExchangeRate: sanitizedValue)) as C;
  }

  double pipValue(S state) {
    final baseExchangeRate = state.baseExchangeRate;
    final baseListedSecond = state.baseListedSecond;
    final pipPrecision = state.pipPrecision;
    final positionSize = state.positionSize;
    final tradingPairExchangeRate = state.tradingPairExchangeRate;

    final decimalPip =
        Decimal.parse('1.0') / Decimal.parse('10').pow(pipPrecision);

    return (decimalPip /
            Decimal.parse(
                (baseListedSecond ? 1 : tradingPairExchangeRate).toString()) /
            Decimal.parse(
                (baseExchangeRate > 0 ? baseExchangeRate : 1).toString()) *
            Decimal.parse(positionSize.toString()))
        .toDouble();
  }
}
