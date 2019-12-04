import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class RequiredMarginCalculator
    extends BaseCalculator<RequiredMarginState, double>
    with
        LotMixin<RequiredMarginCalculator, RequiredMarginState, double>,
        PipValueMixin<RequiredMarginCalculator, RequiredMarginState, double> {
  RequiredMarginCalculator({
    RequiredMarginState initialState,
    List<StateValidator<RequiredMarginState>> validators,
  }) : super(
          initialState: initialState ?? kInitialRequiredMarginState,
          validators: validators ?? requiredMarginValidators,
        );

  RequiredMarginCalculator leverage(double leverage) {
    final sanitizedValue = sanitizeDouble(leverage);
    return patchState(RequiredMarginState(leverage: sanitizedValue));
  }

  double value() {
    if (this.result != null) {
      return this.result;
    }

    final positionSize = this.validState.positionSize;
    final tradingPairExchangeRate = this.validState.tradingPairExchangeRate;
    final leverage = this.validState.leverage;
    final baseListedSecond = this.validState.baseListedSecond;
    final baseExchangeRate = this.validState.baseExchangeRate;

    final rate = baseExchangeRate > 0
        ? baseExchangeRate
        : baseListedSecond ? tradingPairExchangeRate : 1;

    return (this.result = (Decimal.parse(positionSize.toString()) /
            Decimal.parse(leverage.toString()) *
            Decimal.parse(rate.toString()))
        .toDouble());
  }
}

RequiredMarginCalculator requiredMargin() => RequiredMarginCalculator();
