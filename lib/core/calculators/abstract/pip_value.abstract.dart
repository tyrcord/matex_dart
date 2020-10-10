import 'package:matex_dart/matex_dart.dart';

abstract class MatexAbstractPipValueCalculatorCore<
    C extends MatexBaseCalculator<C, R>, R> extends MatexBaseCalculator<C, R> {
  MatexAbstractPipValueCalculatorCore({
    MatexBaseCoreState defaultState,
    List<MatexStateValidator> validators,
  }) : super(
          defaultState: defaultState,
          validators: validators,
        );

  C tradingPairExchangeRate(double tradingPairExchangeRate);

  C baseListedSecond(bool baseListedSecond);

  C baseExchangeRate(double baseExchangeRate);
}
