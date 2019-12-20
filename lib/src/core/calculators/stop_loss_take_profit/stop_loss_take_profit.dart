import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class StopLossTakeProfitCalculator extends BaseCalculator<
        StopLossTakeProfitCalculator,
        StopLossTakeProfitState,
        StopLossTakeProfitResult>
    with
        TakeProfitMixin<StopLossTakeProfitCalculator, StopLossTakeProfitState,
            StopLossTakeProfitResult>,
        StopLossMixin<StopLossTakeProfitCalculator, StopLossTakeProfitState,
            StopLossTakeProfitResult>,
        LotMixin<StopLossTakeProfitCalculator, StopLossTakeProfitState,
            StopLossTakeProfitResult>,
        PipValueMixin<StopLossTakeProfitCalculator, StopLossTakeProfitState,
            StopLossTakeProfitResult> {
  StopLossTakeProfitCalculator({
    StopLossTakeProfitState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialStopLossTakeProfitState,
          validators: validators ?? stopLossTakeProfitValidators,
        );

  @override
  StopLossTakeProfitResult value() {
    if (result != null) {
      return result;
    }

    if (isValid) {
      final pipValue = computePipValue();
      final stopLossCalculator = stopLoss();
      final takeProfitCalculator = takeProfit();
      final tmpState = validState.copyWithState(StopLossTakeProfitState(
        position: state.position,
      ));

      final stopLossResult = stopLossCalculator
          .setState(tmpState.toStopLossState())
          .value(pipValue: pipValue);

      final takeProfitResult = takeProfitCalculator
          .setState(tmpState.toTakeProfitState())
          .value(pipValue: pipValue);

      return (result = StopLossTakeProfitResult(
        pipValue: pipValue.toDouble(),
        riskRewardRatio: _computeRiskRewardRatio(
          stopLossResult.amount,
          takeProfitResult.amount,
        ),
        stopLoss: stopLossResult,
        takeProfit: takeProfitResult,
      ));
    }

    return kEmptyStopLossTakeProfitResult.clone();
  }

  double _computeRiskRewardRatio(
    double stopLossAmount,
    double takeProfitAmount,
  ) {
    var ratio = 0.0;

    if (stopLossAmount != null &&
        stopLossAmount > 0 &&
        takeProfitAmount != null &&
        takeProfitAmount > 0) {
      if (takeProfitAmount != stopLossAmount) {
        ratio = (Decimal.parse(takeProfitAmount.toString()) /
                Decimal.parse(stopLossAmount.toString()))
            .toDouble();
      } else {
        ratio = 1.0;
      }
    }

    return ratio;
  }
}

StopLossTakeProfitCalculator stopLossTakeProfit({
  StopLossTakeProfitState initialState,
  List<StateValidator> validators,
}) =>
    StopLossTakeProfitCalculator(
      initialState: initialState,
      validators: validators,
    );
