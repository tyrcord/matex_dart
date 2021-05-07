import 'package:matex_dart/matex_dart.dart';

class MatexDividendPayoutRatioCalculatorCore extends MatexBaseCalculator<
        MatexDividendPayoutRatioCalculatorCore, MatexDividendPayoutRatioResult>
    with
        MatexDividendPayoutRatioCoreMixin<
            MatexDividendPayoutRatioCalculatorCore,
            MatexDividendPayoutRatioResult> {
  MatexDividendPayoutRatioCalculatorCore({
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? dividendPayoutRatioValidators,
        );

  @override
  MatexDividendPayoutRatioResult value() {
    if (result != null) {
      return result!;
    }

    if (isValid) {
      final dTotalDividend = toDecimal(state.totalDividend!);
      final dNetIncome = toDecimal(state.netIncome!);

      return MatexDividendPayoutRatioResult(
        dividendPayoutRatio: (dTotalDividend / dNetIncome).toDouble(),
      );
    }

    return const MatexDividendPayoutRatioResult();
  }

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kDefaultDividendPayoutRatioState;
}

MatexDividendPayoutRatioCalculatorCore dividendPayoutRatio({
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) =>
    MatexDividendPayoutRatioCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
