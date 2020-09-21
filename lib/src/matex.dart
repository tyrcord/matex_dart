import 'package:matex_dart/matex_dart.dart';

final MatexConfig _defaultMatexConfig = MatexConfig(
  formatterProvider: FormatterProvider(),
  instrumentProvider: InstrumentProvider(),
  reporterProvider: ReporterProvider(),
);

class Matex {
  final MatexConfig config;

  Matex({
    MatexConfig config,
  }) : config = MatexConfig(
          exchangeProvider:
              config?.exchangeProvider ?? _defaultMatexConfig.exchangeProvider,
          instrumentProvider: config?.instrumentProvider ??
              _defaultMatexConfig.instrumentProvider,
          reporterProvider:
              config?.reporterProvider ?? _defaultMatexConfig.reporterProvider,
          formatterProvider: config?.formatterProvider ??
              _defaultMatexConfig.formatterProvider,
        );

  MatexPipValueCalculator pipValue({
    MatexPipValueState state,
    List<StateValidator> validators,
  }) {
    return matexPipValue(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexPivotPointsCalculator pivotPoints({
    MatexPivotPointsState state,
    List<StateValidator> validators,
  }) {
    return matexPivotPoints(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexFibonacciLevelsCalculator fibonacciLevels({
    MatexFibonacciLevelsState state,
    List<StateValidator> validators,
  }) {
    return matexFibonacciLevels(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexRequiredMarginCalculator requiredMargin({
    MatexRequiredMarginState state,
    List<StateValidator> validators,
  }) {
    return matexRequiredMargin(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexPositionSizeCalculator positionSize({
    MatexPositionSizeState state,
    List<StateValidator> validators,
  }) {
    return matexPositionSize(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexStopLossTakeProfitCalculator stopLossTakeProfit({
    MatexStopLossTakeProfitState state,
    List<StateValidator> validators,
  }) {
    return matexStopLossTakeProfit(
      config: config,
      initialState: state,
      validators: validators,
    );
  }
}
