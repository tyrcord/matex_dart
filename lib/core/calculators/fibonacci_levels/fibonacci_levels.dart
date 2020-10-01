import 'package:matex_dart/matex_dart.dart';
import 'package:decimal/decimal.dart';

final _hundred = Decimal.parse('100');

class MatexFibonacciLevelsCalculatorCore extends MatexBaseCalculator<
        MatexFibonacciLevelsCalculatorCore,
        MatexFibonacciLevelsCoreState,
        FibonacciLevelsResult>
    with
        MatexFibonacciLevelsCoreMixin<MatexFibonacciLevelsCalculatorCore,
            MatexFibonacciLevelsCoreState, FibonacciLevelsResult> {
  MatexFibonacciLevelsCalculatorCore({
    MatexFibonacciLevelsCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialFibonacciLevelsState,
          validators: validators ?? fibonacciLevelsValidators,
        );

  @override
  FibonacciLevelsResult value() {
    if (result != null) {
      return result;
    }

    return (result = FibonacciLevelsResult(
      extensionLevels: _computeExtensions(),
      retracementLevels: _computeRetracements(),
    ));
  }

  List<MatexFibonacciLevel> _computeExtensions() {
    final extensionLevels = state.extensionLevels;
    final trend = state.trend;
    final highPrice = validState.highPrice;
    final lowPrice = validState.lowPrice;
    final delta = Decimal.parse((highPrice - lowPrice).toString());

    if (trend == MatexTrend.Up) {
      final parsedHighPrice = Decimal.parse(highPrice.toString());

      return [...extensionLevels].reversed.map((double level) {
        final parsedValue = Decimal.parse(level.toString()) / _hundred * delta +
            parsedHighPrice;

        return _makeFibonacciLevel(level, parsedValue.toDouble());
      }).toList();
    }

    final parsedLowPrice = Decimal.parse(lowPrice.toString());

    return extensionLevels.map((double level) {
      final parsedValue =
          -(Decimal.parse(level.toString()) / _hundred * delta) +
              parsedLowPrice;

      return _makeFibonacciLevel(level, parsedValue.toDouble());
    }).toList();
  }

  List<MatexFibonacciLevel> _computeRetracements() {
    final retracementLevels = state.retracementLevels;
    final trend = state.trend;
    final highPrice = validState.highPrice;
    final lowPrice = validState.lowPrice;
    final delta = Decimal.parse((highPrice - lowPrice).toString());

    if (trend == MatexTrend.Down) {
      final parsedLowPrice = Decimal.parse(lowPrice.toString());

      return [...retracementLevels].reversed.map((double level) {
        final parsedValue =
            Decimal.parse(level.toString()) / _hundred * delta + parsedLowPrice;

        return _makeFibonacciLevel(level, parsedValue.toDouble());
      }).toList();
    }

    final parsedHighPrice = Decimal.parse(highPrice.toString());

    return retracementLevels.map((double level) {
      final parsedValue =
          -(Decimal.parse(level.toString()) / _hundred * delta) +
              parsedHighPrice;

      return _makeFibonacciLevel(level, parsedValue.toDouble());
    }).toList();
  }

  String _formatLevelLabel(double level) {
    final bigNumber = Decimal.parse(level.toString());
    final fixedValue = bigNumber.toStringAsFixed(level % 1 == 0 ? 0 : 1);
    return '$fixedValue%';
  }

  double _formatLevelValue(double value) {
    final number = Decimal.parse(value.toString());
    final precision = state.precision;
    return Decimal.parse(number.toStringAsFixed(precision)).toDouble();
  }

  MatexFibonacciLevel _makeFibonacciLevel(double level, double value) {
    return MatexFibonacciLevel(
      level: _formatLevelLabel(level),
      value: _formatLevelValue(value),
    );
  }
}

MatexFibonacciLevelsCalculatorCore fibonacciLevels({
  MatexFibonacciLevelsCoreState initialState,
  List<MatexStateValidator> validators,
}) =>
    MatexFibonacciLevelsCalculatorCore(
      initialState: initialState,
      validators: validators,
    );
