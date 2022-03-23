import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

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
      MatexBaseCoreState(tradingPairExchangeRate: sanitizedValue),
    );
  }

  @protected
  Decimal pipValue(MatexBaseCoreState state) {
    final counterAccountCurrencyPairExchangeRate =
        state.counterAccountCurrencyPairExchangeRate;
    final baseListedSecond = state.baseListedSecond!;
    final pipPrecision = state.pipPrecision!;
    final positionSize = state.positionSize;
    final tradingPairExchangeRate = state.tradingPairExchangeRate;
    final decimalMultiplicator = pow(10, pipPrecision).toString();
    final decimalPip = Decimal.one / Decimal.parse(decimalMultiplicator);
    final pipValue = Decimal.parse(positionSize.toString()) * decimalPip;

    if (baseListedSecond) {
      return pipValue;
    } else if (counterAccountCurrencyPairExchangeRate == 0) {
      return pipValue / Decimal.parse(tradingPairExchangeRate.toString());
    }

    return pipValue *
        MatexDecimal.fromDouble(counterAccountCurrencyPairExchangeRate!);
  }

  @protected
  Decimal computePipValue() {
    if (isValid) {
      return pipValue(state);
    }

    return Decimal.zero;
  }
}
