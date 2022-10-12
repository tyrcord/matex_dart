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
    MatexConfig? config,
  }) : config = MatexConfig(
          exchangeProvider: config?.exchangeProvider,
          instrumentProvider: config?.instrumentProvider ??
              _defaultMatexConfig.instrumentProvider,
          reporterProvider:
              config?.reporterProvider ?? _defaultMatexConfig.reporterProvider,
          formatterProvider: config?.formatterProvider ??
              _defaultMatexConfig.formatterProvider,
          pairProvider:
              config?.pairProvider ?? _defaultMatexConfig.pairProvider,
        );

  MatexPipValueCalculator pipValue({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexPipValue(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexPivotPointsCalculator pivotPoints({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexPivotPoints(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexFibonacciLevelsCalculator fibonacciLevels({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexFibonacciLevels(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexRequiredMarginCalculator requiredMargin({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexRequiredMargin(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexPositionSizeCalculator positionSize({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexPositionSize(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexStopLossTakeProfitCalculator stopLossTakeProfit({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexStopLossTakeProfit(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexPipDeltaCalculator pipDelta({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexPipDelta(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexForexProfitAndLossCalculator forexProfitAndLoss({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexForexProfitAndLoss(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexProfitAndLossCalculator profitAndLoss({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexProfitAndLoss(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexDividendReinvestmentCalculator dividendReinvestment({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexDividendReinvestment(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexDividendPayoutRatioCalculator dividendPayoutRatio({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexDividendPayoutRatio(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }

  MatexDividendYieldCalculator dividendYield({
    MatexBaseCoreState? state,
    List<MatexStateValidator>? validators,
  }) {
    return matexDividendYield(
      config: config,
      defaultState: state,
      validators: validators,
    );
  }
}
