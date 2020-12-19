import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';

import 'package:matex_dart/matex_dart.dart';

const kDefaultPositionSizeResult = MatexPositionSizeResult(
  amountAtRisk: 0.0,
  pipValue: 0.0,
  positionSize: 0.0,
  riskRatio: 0.0,
  stopLossPips: 0.0,
);

class MatexPositionSizeCalculatorCore extends MatexBaseCalculator<
        MatexPositionSizeCalculatorCore, MatexPositionSizeResult>
    with
        MatexLotCoreMixin<MatexPositionSizeCalculatorCore,
            MatexPositionSizeResult>,
        MatexPipValueCoreMixin<MatexPositionSizeCalculatorCore,
            MatexPositionSizeResult>,
        MatexPositionSizeMarginCoreMixin<MatexPositionSizeCalculatorCore,
            MatexPositionSizeResult> {
  MatexPositionSizeCalculatorCore({
    MatexBaseCoreState defaultState,
    List<MatexStateValidator> validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? positionSizeValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialPositionSizeState;

  @override
  MatexPositionSizeResult value() {
    if (result != null) {
      return result;
    }

    if (isValid) {
      final accountSize = state.accountSize;
      final pipPrecision = state.pipPrecision;
      final stopLossPips = computeStopLossPip(pipPrecision);
      final amountAtRisk = computeAmountAtRisk();
      final riskRatio = computeRiskRatio(amountAtRisk, accountSize);
      final pipValue = computePipValue();
      final tradingSize = pipValue > Decimal.zero && stopLossPips > 0
          ? computePositionSize(amountAtRisk, pipValue, stopLossPips)
          : 0.0;

      return (result = MatexPositionSizeResult(
        amountAtRisk: amountAtRisk,
        pipValue: (pipValue * Decimal.parse(tradingSize.toString())).toDouble(),
        positionSize: tradingSize,
        riskRatio: riskRatio,
        stopLossPips: stopLossPips,
      ));
    }

    return (result = kDefaultPositionSizeResult.clone());
  }

  @protected
  double computePositionSize(
    double amountAtRisk,
    Decimal pipValue,
    double stopLossPip,
  ) {
    final divider = pipValue * Decimal.parse(stopLossPip.toString());

    return (Decimal.parse(amountAtRisk.toString()) / divider).toDouble();
  }

  @protected
  double computeRiskRatio(double amountAtRisk, double accountSize) {
    final riskRatio = state.riskRatio ?? 0.0;

    if (riskRatio == 0 && accountSize != null && accountSize > 0) {
      return (Decimal.parse(amountAtRisk.toString()) *
              MatexDecimal.hundred /
              Decimal.parse(accountSize.toString()))
          .toDouble();
    }

    return riskRatio;
  }

  @protected
  double computeAmountAtRisk() {
    var amountAtRisk = state.amountAtRisk ?? 0.0;
    final riskRatio = state.riskRatio;
    final accountSize = state.accountSize;

    if (riskRatio > 0 && riskRatio <= 100) {
      amountAtRisk = accountSize > 0
          ? (Decimal.parse(riskRatio.toString()) *
                  Decimal.parse(accountSize.toString()) /
                  MatexDecimal.hundred)
              .toDouble()
          : 0.0;
    }

    return amountAtRisk;
  }

  @protected
  double computeStopLossPip(int pipPrecision) {
    var stopLossPips = state.stopLossPips ?? 0.0;
    final stopLossPrice = state.stopLossPrice;
    final entryPrice = state.entryPrice;

    if (stopLossPips == 0 && entryPrice > 0 && stopLossPrice > 0) {
      final decimalMultiplicator = pow(10, pipPrecision).toString();
      final deltaPrice = (Decimal.parse(entryPrice.toString()) -
              Decimal.parse(stopLossPrice.toString()))
          .abs();

      stopLossPips =
          (deltaPrice * Decimal.parse(decimalMultiplicator)).toDouble();
    }

    return stopLossPips;
  }
}

MatexPositionSizeCalculatorCore positionSize({
  MatexBaseCoreState defaultState,
  List<MatexStateValidator> validators,
}) =>
    MatexPositionSizeCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
