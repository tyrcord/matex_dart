import 'package:matex_dart/matex_dart.dart';

mixin MatexPipValueMixin<C extends MatexAbstractPipValueCalculatorCore<C, R>, R>
    on MatexAbstractPipValueCalculatorCore<C, R> {
  MatexConfig config;

  MatexAbstractPairMetadataProvider get pairProvider =>
      config?.pairProvider ?? MatexPairMetadataProvider();

  MatexAbstractInstrumentMetadataProvider get instrumentProvider =>
      config?.instrumentProvider ?? MatexInstrumentProvider();

  MatexAbstractExchangeProvider get exchangeProvider =>
      config?.exchangeProvider;

  C exchangeRateLastUpdateAt(int exchangeRateLastUpdateAt) {
    return patchState(MatexBaseCoreState(
      exchangeRateLastUpdateAt: exchangeRateLastUpdateAt,
    ));
  }

  C accountCode(String accountCode) {
    if (accountCode != null) {
      return patchState(MatexBaseCoreState(
        accountCode: accountCode,
        counterAccountCurrencyPairExchangeRate:
            kInitialMatexPipValueState.counterAccountCurrencyPairExchangeRate,
      ));
    }

    _resetRelatedProperties();

    return resetStateProperties([MatexCoreStateProperty.accountCode]);
  }

  C currencyPairCode(String baseCode, String counterCode) {
    if (baseCode != null && counterCode != null) {
      return patchState(MatexBaseCoreState(
        baseCode: baseCode,
        counterCode: counterCode,
        counterAccountCurrencyPairExchangeRate:
            kInitialMatexPipValueState.counterAccountCurrencyPairExchangeRate,
        tradingPairExchangeRate:
            kInitialMatexPipValueState.tradingPairExchangeRate,
      ));
    }

    _resetRelatedProperties();

    return resetStateProperties([
      MatexCoreStateProperty.baseCode,
      MatexCoreStateProperty.counterCode,
    ]);
  }

  C positionSize(double positionSize) {
    if (positionSize != null &&
        positionSize != kInitialMatexPipValueState.positionSize) {
      final sanitizedValue = sanitizeDouble(positionSize);

      return patchState(MatexBaseCoreState(positionSize: sanitizedValue));
    }

    _resetRelatedProperties();

    return resetStateProperties([MatexCoreStateProperty.positionSize]);
  }

  C _resetRelatedProperties() {
    return resetStateProperties([
      MatexCoreStateProperty.tradingPairExchangeRate,
      MatexCoreStateProperty.counterAccountCurrencyPairExchangeRate,
      MatexCoreStateProperty.baseListedSecond,
    ]);
  }

  Future<MatexInstrumentMetadata> fetchAccountInstrumentMetadata() {
    final accountCode = state.accountCode;

    return instrumentProvider?.metadata(accountCode);
  }

  Future<MatexInstrumentMetadata> fetchCounterInstrumentMetadata() {
    final counterCode = state.counterCode;

    return instrumentProvider?.metadata(counterCode);
  }

  Future<MatexInstrumentMetadata> fetchBaseInstrumentMetadata() {
    final baseCode = state.baseCode;

    return instrumentProvider.metadata(baseCode);
  }

  Future<MatexPairMetadata> fetchPairMetadata() {
    final baseCode = state.baseCode;
    final counterCode = state.counterCode;

    return pairProvider.metadata(baseCode + counterCode);
  }

  // ignore: long-method
  Future<void> setExchangeRates() async {
    final accountCode = state.accountCode;
    final counterCode = state.counterCode;
    final baseCode = state.baseCode;
    final tradingPairQuoteFuture = exchangeProvider?.rates(
      baseCode,
      counterCode,
    );

    final pairMetadata = await fetchPairMetadata();

    if (pairMetadata != null) {
      patchState(MatexBaseCoreState(pipPrecision: pairMetadata.pip.precision));
    } else {
      patchState(MatexBaseCoreState(
        pipPrecision: MatexPairPipMetadata.defaultMetatada().precision,
      ));
    }

    if (tradingPairQuoteFuture != null) {
      final tradingPairQuote = await tradingPairQuoteFuture;
      exchangeRateLastUpdateAt(tradingPairQuote.timestamp);
      tradingPairExchangeRate(tradingPairQuote.price);
      counterAccountCurrencyPairExchangeRate(0);
      baseListedSecond(false);

      if (accountCode == counterCode) {
        baseListedSecond(true);
      } else {
        final accountBaseQuote = await exchangeProvider.rates(
          counterCode,
          accountCode,
        );

        counterAccountCurrencyPairExchangeRate(accountBaseQuote.price);
      }
    }
  }
}
