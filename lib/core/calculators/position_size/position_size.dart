import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

const DEFAULT_RESULTS = MatexPositionSizeResult(
  amountAtRisk: 0.0,
  pipValue: 0.0,
  positionSize: 0.0,
  riskRatio: 0.0,
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
    MatexBaseCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialPositionSizeState,
          validators: validators ?? positionSizeValidators,
        );

  @override
  MatexPositionSizeResult value() {
    if (result != null) {
      return result;
    }

    if (isValid) {
      final accountSize = validState.accountSize;
      final pipPrecision = validState.pipPrecision;
      final stopLossPips = computeStopLossPip(pipPrecision);
      final amountAtRisk = computeAmountAtRisk();
      final riskRatio = computeRiskRatio(amountAtRisk, accountSize);
      final pipValue = computePipValue();
      final tradingSize = pipValue > Decimal.fromInt(0) && stopLossPips > 0
          ? computePositionSize(amountAtRisk, pipValue, stopLossPips)
          : 0.0;

      return (result = MatexPositionSizeResult(
        amountAtRisk: amountAtRisk,
        pipValue: (pipValue * Decimal.parse(tradingSize.toString())).toDouble(),
        positionSize: tradingSize,
        riskRatio: riskRatio,
      ));
    }

    return (result = DEFAULT_RESULTS.clone());
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
    final riskRatio = validState.riskRatio ?? 0.0;

    if (riskRatio == 0) {
      return (Decimal.parse(amountAtRisk.toString()) *
              Decimal.fromInt(100) /
              Decimal.parse(accountSize.toString()))
          .toDouble();
    }

    return riskRatio;
  }

  @protected
  double computeAmountAtRisk() {
    var amountAtRisk = validState.amountAtRisk ?? 0.0;
    final riskRatio = validState.riskRatio;
    final accountSize = validState.accountSize;

    if (riskRatio > 0 && riskRatio <= 100) {
      amountAtRisk = accountSize > 0
          ? (Decimal.parse(riskRatio.toString()) *
                  Decimal.parse(accountSize.toString()) /
                  Decimal.fromInt(100))
              .toDouble()
          : 0.0;
    }

    return amountAtRisk;
  }

  @protected
  double computeStopLossPip(int pipPrecision) {
    var stopLossPips = validState.stopLossPips ?? 0.0;
    final stopLossPrice = validState.stopLossPrice;
    final entryPrice = validState.entryPrice;

    if (stopLossPips == 0 && entryPrice > 0 && stopLossPrice > 0) {
      final deltaPrice = (Decimal.parse(entryPrice.toString()) -
              Decimal.parse(stopLossPrice.toString()))
          .abs();

      stopLossPips =
          (deltaPrice * Decimal.fromInt(10).pow(pipPrecision)).toDouble();
    }

    return stopLossPips;
  }
}

MatexPositionSizeCalculatorCore positionSize({
  MatexBaseCoreState initialState,
  List<MatexStateValidator> validators,
}) =>
    MatexPositionSizeCalculatorCore(
      initialState: initialState,
      validators: validators,
    );
