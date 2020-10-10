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

  C accountCode(String accountCode) {
    if (accountCode != null) {
      return patchState(MatexBaseCoreState(
        accountCode: accountCode,
        baseExchangeRate: kInitialMatexPipValueState.baseExchangeRate,
      ));
    }

    _resetRelatedProperties();
    return resetStateProperties([MatexCoreStateProperty.accountCode]);
  }

  C baseCode(String baseCode) {
    if (baseCode != null) {
      return patchState(MatexBaseCoreState(
        baseCode: baseCode,
        baseExchangeRate: kInitialMatexPipValueState.baseExchangeRate,
        tradingPairExchangeRate:
            kInitialMatexPipValueState.tradingPairExchangeRate,
      ));
    }

    _resetRelatedProperties();
    return resetStateProperties([MatexCoreStateProperty.baseCode]);
  }

  C counterCode(String counterCode) {
    if (counterCode != null) {
      return patchState(MatexBaseCoreState(
        counterCode: counterCode,
        baseExchangeRate: kInitialMatexPipValueState.baseExchangeRate,
        tradingPairExchangeRate:
            kInitialMatexPipValueState.tradingPairExchangeRate,
      ));
    }

    _resetRelatedProperties();
    return resetStateProperties([MatexCoreStateProperty.counterCode]);
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
      MatexCoreStateProperty.baseExchangeRate,
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

  Future<void> setExchangeRates() async {
    final baseCode = state.baseCode;
    final accountCode = state.accountCode;
    final counterCode = state.counterCode;
    final tradingPairQuoteFuture = exchangeProvider?.rates(
      baseCode,
      counterCode,
    );

    final pairMetadata = await fetchPairMetadata();

    if (pairMetadata != null) {
      patchState(MatexBaseCoreState(pipPrecision: pairMetadata.pip.precision));
    } else {
      patchState(MatexBaseCoreState(
        pipPrecision: MatexPairPipMetadata.defaultMetatda().precision,
      ));
    }

    if (tradingPairQuoteFuture != null) {
      final tradingPairQuote = await tradingPairQuoteFuture;
      tradingPairExchangeRate(tradingPairQuote.price);
      baseListedSecond(false);
      baseExchangeRate(0);

      if (accountCode == counterCode) {
        baseListedSecond(true);
      } else if (accountCode != baseCode) {
        final accountBaseQuote = await exchangeProvider.rates(
          accountCode,
          baseCode,
        );

        baseExchangeRate(accountBaseQuote.price);
      }
    }
  }
}
