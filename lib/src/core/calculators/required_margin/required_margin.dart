import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class RequiredMarginCalculator extends BaseCalculator<RequiredMarginCalculator,
        RequiredMarginState, double>
    with
        LotMixin<RequiredMarginCalculator, RequiredMarginState, double>,
        PipValueMixin<RequiredMarginCalculator, RequiredMarginState, double>,
        RequiredMarginMixin<RequiredMarginCalculator, RequiredMarginState,
            double> {
  RequiredMarginCalculator({
    RequiredMarginState initialState,
    List<StateValidator> validators,
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

RequiredMarginCalculator requiredMargin({
  RequiredMarginState initialState,
  List<StateValidator> validators,
}) =>
    RequiredMarginCalculator(
      initialState: initialState,
      validators: validators,
    );
