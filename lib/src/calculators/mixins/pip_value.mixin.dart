import 'package:matex_dart/matex_dart.dart';

mixin MatexPipValueMixin<C, S extends PipValueState, R>
    on AbstractPipValueCalculator<S, R> {
  MatexConfig config;

  AbstractInstrumentProvider get instrumentProvider =>
      config?.instrumentProvider ?? InstrumentProvider();

  AbstractExchangeProvider get exchangeProvider => config?.exchangeProvider;

  C accountCode(String accountCode) {
    return patchState(MatexPipValueState(accountCode: accountCode));
  }

  C baseCode(String baseCode) {
    return patchState(MatexPipValueState(baseCode: baseCode));
  }

  C counterCode(String counterCode) {
    return patchState(MatexPipValueState(counterCode: counterCode));
  }

  Future<InstrumentMetadata> fetchAccountInstrumentMetadata() {
    final accountCode = state.accountCode;
    return instrumentProvider?.metadata(accountCode);
  }

  Future<InstrumentMetadata> fetchCounterInstrumentMetadata() {
    final counterCode = state.counterCode;
    return instrumentProvider?.metadata(counterCode);
  }

  Future<InstrumentMetadata> fetchBaseInstrumentMetadata() {
    final baseCode = state.baseCode;
    return instrumentProvider.metadata(baseCode);
  }

  Future<void> setExchangeRates() async {
    final baseCode = state.baseCode;
    final accountCode = state.accountCode;
    final counterCode = state.counterCode;
    final tradingPairQuoteFuture = exchangeProvider?.rates(
      baseCode,
      counterCode,
    );

    final counterMetadata = await fetchCounterInstrumentMetadata();

    if (counterMetadata != null) {
      patchState(MatexPipValueState(
        pipPrecision: counterMetadata.pip.precision,
      ));
    }

    if (tradingPairQuoteFuture != null) {
      final tradingPairQuote = await tradingPairQuoteFuture;
      tradingPairExchangeRate(tradingPairQuote.price);

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
