import 'package:matex_dart/matex_dart.dart';

abstract class AbstractPipValueCalculator<C extends BaseCalculator<C, S, R>,
    S extends BaseState, R> extends BaseCalculator<C, S, R> {
  AbstractPipValueCalculator({
    S initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState,
          validators: validators,
        );

  C tradingPairExchangeRate(double tradingPairExchangeRate);

  C baseListedSecond(bool baseListedSecond);

  C baseExchangeRate(double baseExchangeRate);
}
