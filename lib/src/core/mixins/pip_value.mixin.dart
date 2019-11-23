import 'package:matex_dart/src/core/calculators/abstract/base.dart';
import 'package:matex_dart/src/core/enums/calculator_key.enum.dart';

mixin PipValueMixin<C, R> on BaseCalculator<R> {
  C baseExchangeRate(double baseExchangeRate) {
    return setValue(CalculatorKey.BaseExchangeRate, baseExchangeRate) as C;
  }

  C baseListedSecond(bool baseListedSecond) {
    return setValue(CalculatorKey.BaseListedSecond, baseListedSecond) as C;
  }

  C pipPrecision(int pipPrecision) {
    return setValue(CalculatorKey.PipPrecision, pipPrecision) as C;
  }

  C positionSize(double positionSize) {
    return setValue(CalculatorKey.PositionSize, positionSize) as C;
  }

  C tradingPairExchangeRate(double tradingPairExchangeRate) {
    return setValue(
      CalculatorKey.TradingPairExchangeRate,
      tradingPairExchangeRate,
    ) as C;
  }
}
