import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexRequiredMarginCalculatorCore
    extends MatexBaseCalculator<MatexRequiredMarginCalculatorCore, double>
    with
        MatexLotCoreMixin<MatexRequiredMarginCalculatorCore, double>,
        MatexPipValueCoreMixin<MatexRequiredMarginCalculatorCore, double>,
        MatexRequiredMarginCoreMixin<MatexRequiredMarginCalculatorCore,
            double> {
  MatexRequiredMarginCalculatorCore({
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? requiredMarginValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialRequiredMarginState;

  @override
  double value() {
    if (result != null) return result!;

    if (isValid) {
      final tradingPairExchangeRate = state.tradingPairExchangeRate;
      final baseListedSecond = state.baseListedSecond!;
      final positionSize = state.positionSize;
      final decimalLeverage = Decimal.parse(state.leverage.toString());
      final counterAccountCurrencyPairExchangeRate =
          state.counterAccountCurrencyPairExchangeRate!;
      final rate = counterAccountCurrencyPairExchangeRate > 0
          ? counterAccountCurrencyPairExchangeRate
          : 1;

      if (!baseListedSecond) {
        return (result = (Decimal.parse(positionSize.toString()) *
                toDecimal(Decimal.parse(tradingPairExchangeRate.toString()) /
                    decimalLeverage) *
                Decimal.parse(rate.toString()))
            .toDouble());
      }

      return (result = (toDecimal(Decimal.parse(positionSize.toString()) *
                  Decimal.parse(tradingPairExchangeRate.toString()) /
                  decimalLeverage) /
              Decimal.one)
          .toDouble());
    }

    return 0.0;
  }
}

MatexRequiredMarginCalculatorCore requiredMargin({
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) =>
    MatexRequiredMarginCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
