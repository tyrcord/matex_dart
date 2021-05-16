import 'package:matex_dart/matex_dart.dart';

class MatexDividendYieldCalculator extends MatexBaseCalculator<
        MatexDividendYieldCalculator, Future<MatexDividendYieldResult>>
    with
        MatexDividendYieldCoreMixin<MatexDividendYieldCalculator,
            Future<MatexDividendYieldResult>> {
  final MatexConfig config;

  MatexDividendYieldCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? dividendYieldValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kDefaultDividendYieldState;

  @override
  Future<MatexDividendYieldResult> value() async {
    var calculator = dividendYield();

    return calculator.setState(state).value();
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.dividendPaymentFrequency,
        MatexCoreStateProperty.totalDividend,
        MatexCoreStateProperty.sharePrice,
      ];
}

MatexDividendYieldCalculator matexDividendYield({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexDividendYieldCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
