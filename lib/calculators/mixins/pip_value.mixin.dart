import 'package:matex_dart/matex_dart.dart';

mixin MatexPipValueMixin<
    C extends MatexAbstractPipValueCalculatorCore<C, S, R>,
    S extends MatexPipValueCoreState,
    R> on MatexAbstractPipValueCalculatorCore<C, S, R> {
  MatexConfig config;

  MatexAbstractPairMetadataProvider get pairProvider =>
      config?.pairProvider ?? MatexPairMetadataProvider();

  MatexAbstractInstrumentMetadataProvider get instrumentProvider =>
      config?.instrumentProvider ?? MatexInstrumentProvider();

  MatexAbstractExchangeProvider get exchangeProvider =>
      config?.exchangeProvider;

  C accountCode(String accountCode) {
    return patchState(MatexPipValueState(accountCode: accountCode));
  }

  C baseCode(String baseCode) {
    return patchState(MatexPipValueState(baseCode: baseCode));
  }

  C counterCode(String counterCode) {
    return patchState(MatexPipValueState(counterCode: counterCode));
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
      patchState(MatexPipValueState(pipPrecision: pairMetadata.pip.precision));
    } else {
      patchState(MatexPipValueState(
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
