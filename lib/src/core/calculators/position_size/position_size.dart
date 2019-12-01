import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

const DEFAULT_RESULTS = PositionSizeResult(
  amountAtRisk: 0.0,
  pipValue: 0.0,
  positionSize: 0.0,
  riskRatio: 0.0,
);

class PositionSizeCalculator
    extends BaseCalculator<PositionSizeState, PositionSizeResult>
    with
        PipValueMixin<PositionSizeCalculator, PositionSizeState,
            PositionSizeResult> {
  PositionSizeCalculator({
    PositionSizeState initialState,
    List<StateValidator<PositionSizeState>> validators,
  }) : super(
            initialState: initialState ?? initialPositionSizeState,
            validators: validators ?? positionSizeValidators);

  PositionSizeCalculator accountSize(double accountSize) {
    final sanitizedValue = sanitizeDouble(accountSize);
    return patchState(PositionSizeState(accountSize: sanitizedValue));
  }

  PositionSizeCalculator amountAtRisk(double amountAtRisk) {
    final sanitizedValue = sanitizeDouble(amountAtRisk);
    return patchState(PositionSizeState(
      amountAtRisk: sanitizedValue,
      riskRatio: 0,
    ));
  }

  PositionSizeCalculator entryPrice(double entryPrice) {
    final sanitizedValue = sanitizeDouble(entryPrice);
    return patchState(
        PositionSizeState(entryPrice: sanitizedValue, stopLossPips: 0));
  }

  PositionSizeCalculator riskRatio(double riskRatio) {
    final sanitizedValue = sanitizeDouble(riskRatio);
    return patchState(
        PositionSizeState(riskRatio: sanitizedValue, amountAtRisk: 0));
  }

  PositionSizeCalculator stopLossPips(double stopLossPips) {
    final sanitizedValue = sanitizeDouble(stopLossPips);
    return patchState(PositionSizeState(
      stopLossPips: sanitizedValue,
      stopLossPrice: 0,
      entryPrice: 0,
    ));
  }

  PositionSizeCalculator stopLossPrice(double stopLossPrice) {
    final sanitizedValue = sanitizeDouble(stopLossPrice);
    return patchState(PositionSizeState(
      stopLossPrice: sanitizedValue,
      stopLossPips: 0,
    ));
  }

  PositionSizeResult value() {
    if (result != null) {
      return result;
    }

    if (isValid) {
      final accountSize = validState.accountSize;
      final pipPrecision = validState.pipPrecision;
      final stopLossPips = computeStopLossPip(pipPrecision);
      double amountAtRisk = computeAmountAtRisk();
      final riskRatio = computeRiskRatio(amountAtRisk, accountSize);
      final pipValue = computePipValue();
      final tradingSize = pipValue > 0 && stopLossPips > 0
          ? computePositionSize(amountAtRisk, pipValue, stopLossPips)
          : 0.0;

      return (result = PositionSizeResult(
        amountAtRisk: amountAtRisk,
        pipValue: pipValue * tradingSize,
        positionSize: tradingSize,
        riskRatio: riskRatio,
      ));
    }

    return (result = DEFAULT_RESULTS.clone());
  }

  @protected
  double computePositionSize(
    double amountAtRisk,
    double pipValue,
    double stopLossPip,
  ) {
    final divider = Decimal.parse(pipValue.toString()) *
        Decimal.parse(stopLossPip.toString());
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
    double amountAtRisk = validState.amountAtRisk ?? 0.0;
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
    double stopLossPips = validState.stopLossPips ?? 0.0;
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

PositionSizeCalculator positionSize() => PositionSizeCalculator();
