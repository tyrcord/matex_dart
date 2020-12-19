import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexStopLossTakeProfitCalculatorCore extends MatexBaseCalculator<
        MatexStopLossTakeProfitCalculatorCore, MatexStopLossTakeProfitResult>
    with
        MatexTakeProfitCoreMixin<MatexStopLossTakeProfitCalculatorCore,
            MatexStopLossTakeProfitResult>,
        MatexStopLossCoreMixin<MatexStopLossTakeProfitCalculatorCore,
            MatexStopLossTakeProfitResult>,
        MatexLotCoreMixin<MatexStopLossTakeProfitCalculatorCore,
            MatexStopLossTakeProfitResult>,
        MatexPipValueCoreMixin<MatexStopLossTakeProfitCalculatorCore,
            MatexStopLossTakeProfitResult> {
  MatexStopLossTakeProfitCalculatorCore({
    MatexBaseCoreState defaultState,
    List<MatexStateValidator> validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? stopLossTakeProfitValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kInitialStopLossTakeProfitState;

  @override
  MatexStopLossTakeProfitResult value() {
    if (result != null) return result;

    if (isValid) {
      final pipValue = computePipValue();
      final stopLossCalculator = stopLoss();
      final takeProfitCalculator = takeProfit();
      final tmpState =
          state.copyWithState(MatexBaseCoreState(position: state.position));

      final stopLossResult = stopLossCalculator.setState(tmpState).value(
            pipValue: pipValue,
          );

      final takeProfitResult = takeProfitCalculator.setState(tmpState).value(
            pipValue: pipValue,
          );

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
  MatexBaseCoreState defaultState,
  List<MatexStateValidator> validators,
}) =>
    MatexStopLossTakeProfitCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
