import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexRequiredMarginCalculator extends MatexAbstractPipValueCalculatorCore<
        MatexRequiredMarginCalculator, Future<double>>
    with
        MatexLotCoreMixin<MatexRequiredMarginCalculator, Future<double>>,
        MatexPipValueCoreMixin<MatexRequiredMarginCalculator, Future<double>>,
        MatexPipValueMixin<MatexRequiredMarginCalculator, Future<double>>,
        MatexRequiredMarginCoreMixin<MatexRequiredMarginCalculator,
            Future<double>> {
  @override
  final MatexConfig config;

  MatexRequiredMarginCalculator({
    @required this.config,
    MatexBaseCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialMatexRequiredMarginState,
          validators: validators ?? matexPipValueValidators,
        );

  @override
  Future<double> value() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
      return requiredMargin(initialState: state).value();
    }

    return 0.0;
  }

  @override
  Future<void> setExchangeRates() async {
    final exchangeProvider = config?.exchangeProvider;
    final accountCode = validState.accountCode;
    final baseCode = validState.baseCode;
    final counterCode = validState.counterCode;

    if (accountCode == baseCode) {
      tradingPairExchangeRate(1.0);
    } else {
      final tradingPairQuoteFuture = exchangeProvider?.rates(
        baseCode,
        counterCode,
      );

      if (tradingPairQuoteFuture != null) {
        final tradingPairQuote = await tradingPairQuoteFuture;

        tradingPairExchangeRate(tradingPairQuote.price);

        if (accountCode == counterCode) {
          baseListedSecond(true);
        } else {
          final accountBaseQuote = await exchangeProvider.rates(
            baseCode,
            accountCode,
          );
          baseExchangeRate(accountBaseQuote.price);
        }
      }
    }
  }
}

MatexRequiredMarginCalculator matexRequiredMargin({
  MatexConfig config,
  MatexBaseCoreState initialState,
  List<MatexStateValidator> validators,
}) {
  return MatexRequiredMarginCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
