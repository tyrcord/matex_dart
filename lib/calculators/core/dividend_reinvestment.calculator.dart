import 'package:matex_dart/matex_dart.dart';

class MatexDividendReinvestmentCalculator extends MatexBaseCalculator<
        MatexDividendReinvestmentCalculator,
        Future<MatexDividendReinvestmentResult>>
    with
        MatexDividendReinvestmentCoreMixin<MatexDividendReinvestmentCalculator,
            Future<MatexDividendReinvestmentResult>> {
  final MatexConfig config;

  MatexDividendReinvestmentCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? dividendReinvestmentValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kDefaultDividendReinvestmentState;

  @override
  Future<MatexDividendReinvestmentResult> value() async {
    var calculator = dividendReinvestment();

    return calculator.setState(state).value();
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.dividendPaymentFrequency,
        MatexCoreStateProperty.annualSharePriceIncrease,
        MatexCoreStateProperty.annualDividendIncrease,
        MatexCoreStateProperty.annualContribution,
        MatexCoreStateProperty.numberOfShares,
        MatexCoreStateProperty.dividendYield,
        MatexCoreStateProperty.yearsToGrow,
        MatexCoreStateProperty.sharePrice,
        MatexCoreStateProperty.taxRate,
        MatexCoreStateProperty.drip,
      ];
}

MatexDividendReinvestmentCalculator matexDividendReinvestment({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexDividendReinvestmentCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
