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
    MatexBaseCoreState state,
    List<MatexStateValidator> validators,
  }) {
    return matexPipValue(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexPivotPointsCalculator pivotPoints({
    MatexBaseCoreState state,
    List<MatexStateValidator> validators,
  }) {
    return matexPivotPoints(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexFibonacciLevelsCalculator fibonacciLevels({
    MatexBaseCoreState state,
    List<MatexStateValidator> validators,
  }) {
    return matexFibonacciLevels(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexRequiredMarginCalculator requiredMargin({
    MatexBaseCoreState state,
    List<MatexStateValidator> validators,
  }) {
    return matexRequiredMargin(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexPositionSizeCalculator positionSize({
    MatexBaseCoreState state,
    List<MatexStateValidator> validators,
  }) {
    return matexPositionSize(
      config: config,
      initialState: state,
      validators: validators,
    );
  }

  MatexStopLossTakeProfitCalculator stopLossTakeProfit({
    MatexBaseCoreState state,
    List<MatexStateValidator> validators,
  }) {
    return matexStopLossTakeProfit(
      config: config,
      initialState: state,
      validators: validators,
    );
  }
}
