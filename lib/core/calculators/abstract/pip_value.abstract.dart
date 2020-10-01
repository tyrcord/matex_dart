import 'package:matex_dart/matex_dart.dart';

abstract class MatexAbstractPipValueCalculatorCore<
    C extends MatexBaseCalculator<C, S, R>,
    S extends MatexBaseCoreState,
    R> extends MatexBaseCalculator<C, S, R> {
  MatexAbstractPipValueCalculatorCore({
    S initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState,
          validators: validators,
        );

  C tradingPairExchangeRate(double tradingPairExchangeRate);

  C baseListedSecond(bool baseListedSecond);

  C baseExchangeRate(double baseExchangeRate);
}
