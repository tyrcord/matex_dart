import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';
import 'package:rational/rational.dart';

mixin MatexPipValueCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C counterAccountCurrencyPairExchangeRate(
      double counterAccountCurrencyPairExchangeRate) {
    final sanitizedValue =
        sanitizeDouble(counterAccountCurrencyPairExchangeRate);

    return patchState(MatexBaseCoreState(
        counterAccountCurrencyPairExchangeRate: sanitizedValue));
  }

  C baseListedSecond(bool baseListedSecond) {
    return patchState(MatexBaseCoreState(baseListedSecond: baseListedSecond));
  }

  C pipPrecision(int? pipPrecision) {
    return patchState(MatexBaseCoreState(pipPrecision: pipPrecision));
  }

  C positionSize(double positionSize) {
    final sanitizedValue = sanitizeDouble(positionSize);

    return patchState(MatexBaseCoreState(positionSize: sanitizedValue));
  }

  C tradingPairExchangeRate(double tradingPairExchangeRate) {
    final sanitizedValue = sanitizeDouble(tradingPairExchangeRate);

    return patchState(
      MatexBaseCoreState(tradingPairExchangeRate: sanitizedValue),
    );
  }

  @protected
  Decimal pipValue(MatexBaseCoreState state, {bool rational = false}) {
    return toDecimal(rationalPipValue(state));
  }

  Rational rationalPipValue(MatexBaseCoreState state) {
    final counterAccountCurrencyPairExchangeRate =
        state.counterAccountCurrencyPairExchangeRate;
    final baseListedSecond = state.baseListedSecond!;
    final pipPrecision = state.pipPrecision!;
    final positionSize = state.positionSize;
    final tradingPairExchangeRate = state.tradingPairExchangeRate;
    final decimalMultiplicator = pow(10, pipPrecision);
    final decimalPip = Decimal.one / toDecimal(decimalMultiplicator);
    final pipValue = toDecimal(positionSize).toRational() * decimalPip;

    if (baseListedSecond) {
      return pipValue;
    } else if (counterAccountCurrencyPairExchangeRate == 0) {
      return (pipValue / toDecimal(tradingPairExchangeRate).toRational());
    }

    return pipValue *
        toDecimal(counterAccountCurrencyPairExchangeRate!).toRational();
  }

  @protected
  Decimal computePipValue() {
    if (isValid) {
      return pipValue(state);
    }

    return Decimal.zero;
  }
}
