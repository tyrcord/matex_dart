import 'package:matex_dart/matex_dart.dart';

class MatexDividendPayoutRatioCalculator extends MatexBaseCalculator<
        MatexDividendPayoutRatioCalculator,
        Future<MatexDividendPayoutRatioResult>>
    with
        MatexDividendPayoutRatioCoreMixin<MatexDividendPayoutRatioCalculator,
            Future<MatexDividendPayoutRatioResult>> {
  final MatexConfig config;

  MatexDividendPayoutRatioCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? dividendPayoutRatioValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kDefaultDividendPayoutRatioState;

  @override
  Future<MatexDividendPayoutRatioResult> value() async {
    var calculator = dividendPayoutRatio();

    return calculator.setState(state).value();
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.totalDividend,
        MatexCoreStateProperty.netIncome,
      ];
}

MatexDividendPayoutRatioCalculator matexDividendPayoutRatio({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexDividendPayoutRatioCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
