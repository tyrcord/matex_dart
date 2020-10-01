import 'package:matex_dart/matex_dart.dart';

final MatexConfig _defaultMatexConfig = MatexConfig(
  pairProvider: MatexPairMetadataProvider(),
  instrumentProvider: MatexInstrumentProvider(),
  formatterProvider: MatexFormatterProvider(),
  reporterProvider: MatexReporterProvider(),
);

class MatexApp {
  final MatexConfig config;

  MatexApp({
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
    List<MatexStateValidator> validators,
  }) {
    return matexPipValue(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexPivotPointsCalculator pivotPoints({
    MatexPivotPointsState state,
    List<MatexStateValidator> validators,
  }) {
    return matexPivotPoints(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexFibonacciLevelsCalculator fibonacciLevels({
    MatexFibonacciLevelsCoreState state,
    List<MatexStateValidator> validators,
  }) {
    return matexFibonacciLevels(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexRequiredMarginCalculator requiredMargin({
    MatexRequiredMarginState state,
    List<MatexStateValidator> validators,
  }) {
    return matexRequiredMargin(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexPositionSizeCalculator positionSize({
    MatexPositionSizeCoreState state,
    List<MatexStateValidator> validators,
  }) {
    return matexPositionSize(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexStopLossTakeProfitCalculator stopLossTakeProfit({
    MatexStopLossTakeProfitState state,
    List<MatexStateValidator> validators,
  }) {
    return matexStopLossTakeProfit(
      config: config,
      initialState: state,
      validators: validators,
    );
  }
}
