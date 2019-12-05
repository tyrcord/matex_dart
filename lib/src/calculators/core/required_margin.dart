import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexRequiredMarginCalculator extends RequiredMarginCalculator
    with MatexPipValueMixin<RequiredMarginState, double> {
  final MatexConfig config;

  MatexRequiredMarginCalculator({
    @required this.config,
    MatexRequiredMarginState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialMatexRequiredMarginState,
          validators: validators ?? matexPipValueValidators,
        );

  asyncValue() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
      return super.value();
    }

    return 0;
  }

  @override
  Future<void> setExchangeRates() async {
    final exchangeProvider = config?.exchangeProvider;
    final accountCode = this.validState.accountCode;
    final baseCode = this.validState.baseCode;
    final counterCode = this.validState.counterCode;

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
  MatexRequiredMarginState initialState,
  List<StateValidator> validators,
}) {
  return MatexRequiredMarginCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
