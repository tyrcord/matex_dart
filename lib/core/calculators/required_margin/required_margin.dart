import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexRequiredMarginCalculatorCore extends MatexBaseCalculator<
        MatexRequiredMarginCalculatorCore, MatexRequiredMarginCoreState, double>
    with
        MatexLotCoreMixin<MatexRequiredMarginCalculatorCore, MatexRequiredMarginCoreState,
            double>,
        MatexPipValueCoreMixin<MatexRequiredMarginCalculatorCore, MatexRequiredMarginCoreState,
            double>,
        MatexRequiredMarginCoreMixin<MatexRequiredMarginCalculatorCore,
            MatexRequiredMarginCoreState, double> {
  MatexRequiredMarginCalculatorCore({
    MatexRequiredMarginCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialRequiredMarginState,
          validators: validators ?? requiredMarginValidators,
        );

  @override
  double value() {
    if (result != null) {
      return result;
    }

    final positionSize = validState.positionSize;
    final tradingPairExchangeRate = validState.tradingPairExchangeRate;
    final leverage = validState.leverage;
    final baseListedSecond = validState.baseListedSecond;
    final baseExchangeRate = validState.baseExchangeRate;

    final rate = baseExchangeRate > 0
        ? baseExchangeRate
        : baseListedSecond ? tradingPairExchangeRate : 1;

    return (result = (Decimal.parse(positionSize.toString()) /
            Decimal.parse(leverage.toString()) *
            Decimal.parse(rate.toString()))
        .toDouble());
  }
}

MatexRequiredMarginCalculatorCore requiredMargin({
  MatexRequiredMarginCoreState initialState,
  List<MatexStateValidator> validators,
}) =>
    MatexRequiredMarginCalculatorCore(
      initialState: initialState,
      validators: validators,
    );
