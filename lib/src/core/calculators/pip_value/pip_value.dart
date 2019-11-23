import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';
import 'package:decimal/decimal.dart';

class PipValueCalculator extends BaseCalculator<double>
    with
        PipValueMixin<PipValueCalculator, double>,
        LotMixin<PipValueCalculator, double> {
  PipValueCalculator({
    Map<CalculatorKey, dynamic> initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState ?? initialPipValueState,
          validators: validators ?? pipValueValidators,
        );

  double value() {
    if (result != null) {
      return result;
    }

    return (result = computePipValue());
  }

  @override
  PipValueCalculator reset() {
    return super.reset() as PipValueCalculator;
  }

  @protected
  double computePipValue() {
    if (isValid) {
      return pipValue(validState);
    }

    return 0;
  }
}

double pipValue(Map<CalculatorKey, dynamic> state) {
  final baseExchangeRate = state[CalculatorKey.BaseExchangeRate] as double;
  final baseListedSecond = state[CalculatorKey.BaseListedSecond] as bool;
  final pipPrecision = state[CalculatorKey.PipPrecision] as int;
  final positionSize = state[CalculatorKey.PositionSize] as double;
  final tradingPairExchangeRate =
      state[CalculatorKey.TradingPairExchangeRate] as double;

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

PipValueCalculator pip() {
  return PipValueCalculator();
}
