import 'package:matex_dart/matex_dart.dart';

abstract class AbstractPipValueCalculator<S extends PipValueState, R>
    extends BaseCalculator<S, R> {
  AbstractPipValueCalculator({
    S initialState,
    List<StateValidator<S>> validators,
  }) : super(
          initialState: initialState ?? kInitialPipValueState as S,
          validators: validators ?? pipValueValidators,
        );

  dynamic tradingPairExchangeRate(double tradingPairExchangeRate);

  dynamic baseListedSecond(bool baseListedSecond);

  dynamic baseExchangeRate(double baseExchangeRate);
}
