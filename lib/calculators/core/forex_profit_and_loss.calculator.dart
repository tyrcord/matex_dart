import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexForexProfitAndLossCalculator
    extends MatexAbstractPipValueCalculatorCore<
        MatexForexProfitAndLossCalculator, Future<MatexProfitAndLossResult>>
    with
        MatexProfitAndLossCoreMixin<MatexForexProfitAndLossCalculator,
            Future<MatexProfitAndLossResult>>,
        MatexPipValueCoreMixin<MatexForexProfitAndLossCalculator,
            Future<MatexProfitAndLossResult>>,
        MatexPipValueMixin<MatexForexProfitAndLossCalculator,
            Future<MatexProfitAndLossResult>> {
  @override
  final MatexConfig config;

  MatexForexProfitAndLossCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? matexForexProfitAndLossValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kInitialMatexForexProfitAndLossState;

  @override
  Future<MatexProfitAndLossResult> value() async {
    final exchangeProvider = config.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();

      final result = profitAndLoss(defaultState: state).value();
      final baseListedSecond = state.baseListedSecond!;
      final counterAccountCurrencyPairExchangeRate =
          state.counterAccountCurrencyPairExchangeRate!;

      if (baseListedSecond) {
        return convertResultWithRate(result, 1);
      } else if (counterAccountCurrencyPairExchangeRate == 0) {
        final tradingPairExchangeRate = state.tradingPairExchangeRate!;

        return convertResultWithRate(result, tradingPairExchangeRate);
      }

      final dInvertedRate = Decimal.one /
          MatexDecimal.fromDouble(
            counterAccountCurrencyPairExchangeRate,
          );

      return convertResultWithRate(result, dInvertedRate.toDouble());
    }

    return MatexProfitAndLossResult();
  }

  MatexProfitAndLossResult convertResultWithRate(
    MatexProfitAndLossResult result,
    double rate,
  ) {
    var dProfitOrLoss = MatexDecimal.fromDouble(result.profitOrLoss);
    var dRate = MatexDecimal.fromDouble(rate);

    return MatexProfitAndLossResult(
      returnOnInvestement: result.returnOnInvestement,
      profitOrLoss: (dProfitOrLoss / dRate).toDouble(),
    );
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.accountCode,
        MatexCoreStateProperty.baseCode,
        MatexCoreStateProperty.counterCode,
        MatexCoreStateProperty.position,
        MatexCoreStateProperty.positionSize,
        MatexCoreStateProperty.entryPrice,
        MatexCoreStateProperty.exitPrice,
      ];
}

MatexForexProfitAndLossCalculator matexForexProfitAndLoss({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexForexProfitAndLossCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
