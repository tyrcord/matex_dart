import 'package:matex_dart/matex_dart.dart';

class MatexDividendYieldCalculatorCore extends MatexBaseCalculator<
        MatexDividendYieldCalculatorCore, MatexDividendYieldResult>
    with
        MatexDividendYieldCoreMixin<MatexDividendYieldCalculatorCore,
            MatexDividendYieldResult> {
  MatexDividendYieldCalculatorCore({
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? dividendYieldValidators,
        );

  @override
  MatexDividendYieldResult value() {
    if (result != null) {
      return result!;
    }

    if (isValid) {
      final dSharePrice = toDecimal(state.sharePrice!);
      final dDividendAmount = toDecimal(state.totalDividend!);
      final dFrequency = toDecimal(
        _getDividendPaymentFrequency(state.dividendPaymentFrequency!),
      );

      return MatexDividendYieldResult(
        dividendYield: (dDividendAmount * dFrequency / dSharePrice).toDouble(),
      );
    }

    return const MatexDividendYieldResult();
  }

  @override
  MatexBaseCoreState get defaultCalculatorState => kDefaultDividendYieldState;

  int _getDividendPaymentFrequency(MatexFrequency frequency) {
    if (frequency == MatexFrequency.semiAnnually) {
      return 2;
    } else if (frequency == MatexFrequency.quarterly) {
      return 4;
    } else if (frequency == MatexFrequency.monthly) {
      return 12;
    }

    return 1;
  }
}

MatexDividendYieldCalculatorCore dividendYield({
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) =>
    MatexDividendYieldCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
