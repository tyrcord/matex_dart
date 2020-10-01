import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexStopLossTakeProfitCalculatorCore extends MatexBaseCalculator<
        MatexStopLossTakeProfitCalculatorCore,
        MatexStopLossTakeProfitCoreState,
        MatexStopLossTakeProfitResult>
    with
        MatexTakeProfitCoreMixin<MatexStopLossTakeProfitCalculatorCore,
            MatexStopLossTakeProfitCoreState, MatexStopLossTakeProfitResult>,
        MatexStopLossCoreMixin<MatexStopLossTakeProfitCalculatorCore,
            MatexStopLossTakeProfitCoreState, MatexStopLossTakeProfitResult>,
        MatexLotCoreMixin<MatexStopLossTakeProfitCalculatorCore, MatexStopLossTakeProfitCoreState,
            MatexStopLossTakeProfitResult>,
        MatexPipValueCoreMixin<MatexStopLossTakeProfitCalculatorCore,
            MatexStopLossTakeProfitCoreState, MatexStopLossTakeProfitResult> {
  MatexStopLossTakeProfitCalculatorCore({
    MatexStopLossTakeProfitCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialStopLossTakeProfitState,
          validators: validators ?? stopLossTakeProfitValidators,
        );

  @override
  MatexStopLossTakeProfitResult value() {
    if (result != null) {
      return result;
    }

    if (isValid) {
      final pipValue = computePipValue();
      final stopLossCalculator = stopLoss();
      final takeProfitCalculator = takeProfit();
      final tmpState = validState.copyWithState(MatexStopLossTakeProfitCoreState(
        position: state.position,
      ));

      final stopLossResult = stopLossCalculator
          .setState(tmpState.toStopLossState())
          .value(pipValue: pipValue);

      final takeProfitResult = takeProfitCalculator
          .setState(tmpState.toTakeProfitState())
          .value(pipValue: pipValue);

      return (result = MatexStopLossTakeProfitResult(
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

MatexStopLossTakeProfitCalculatorCore stopLossTakeProfit({
  MatexStopLossTakeProfitCoreState initialState,
  List<MatexStateValidator> validators,
}) =>
    MatexStopLossTakeProfitCalculatorCore(
      initialState: initialState,
      validators: validators,
    );
