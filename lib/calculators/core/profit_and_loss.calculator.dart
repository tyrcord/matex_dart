import 'package:matex_dart/matex_dart.dart';

class MatexProfitAndLossCalculator extends MatexBaseCalculator<
        MatexProfitAndLossCalculator, Future<MatexProfitAndLossResult>>
    with
        MatexProfitAndLossCoreMixin<MatexProfitAndLossCalculator,
            Future<MatexProfitAndLossResult>> {
  final MatexConfig config;

  MatexProfitAndLossCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? profitAndLossValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialProfitAndLossState;

  @override
  Future<MatexProfitAndLossResult> value() async {
    return profitAndLoss(defaultState: state).value();
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.entryPrice,
        MatexCoreStateProperty.exitPrice,
        MatexCoreStateProperty.positionSize,
        MatexCoreStateProperty.fixedCosts,
        MatexCoreStateProperty.entryFeePercentagePerUnit,
        MatexCoreStateProperty.entryFeeAmountPerUnit,
        MatexCoreStateProperty.exitFeePercentagePerUnit,
        MatexCoreStateProperty.exitFeeAmountPerUnit,
        MatexCoreStateProperty.exitDiscountPercentage,
        MatexCoreStateProperty.exitDiscountAmount,
        MatexCoreStateProperty.taxeRate,
      ];
}

MatexProfitAndLossCalculator matexProfitAndLoss({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexProfitAndLossCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
