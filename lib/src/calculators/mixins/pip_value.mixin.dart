import 'package:matex_dart/matex_dart.dart';

mixin MatexPipValueMixin<S extends PipValueState, R>
    on AbstractPipValueCalculator<S, R> {
  MatexConfig config;

  AbstractInstrumentProvider get instrumentProvider =>
      config?.instrumentProvider ?? InstrumentProvider();

  AbstractExchangeProvider get exchangeProvider => config?.exchangeProvider;

  accountCode(String accountCode) {
    return patchState(MatexPipValueState(accountCode: accountCode));
  }

  baseCode(String baseCode) {
    return patchState(MatexPipValueState(baseCode: baseCode));
  }

  counterCode(String counterCode) {
    return patchState(MatexPipValueState(counterCode: counterCode));
  }

  Future<InstrumentMetadata> fetchAccountInstrumentMetadata() {
    final accountCode = state.accountCode;
    return instrumentProvider.metadata(accountCode).first;
  }

  Future<InstrumentMetadata> fetchCounterInstrumentMetadata() {
    final counterCode = state.counterCode;
    return instrumentProvider.metadata(counterCode).first;
  }

  Future<InstrumentMetadata> fetchBaseInstrumentMetadata() {
    final baseCode = state.baseCode;
    return instrumentProvider.metadata(baseCode).first;
  }

  Future<void> setExchangeRates() async {
    final baseCode = state.baseCode;
    final accountCode = state.accountCode;
    final counterCode = state.counterCode;
    final tradingPairQuoteStream = exchangeProvider?.rates(
      baseCode,
      counterCode,
    );

    if (tradingPairQuoteStream != null) {
      final tradingPairQuote = await tradingPairQuoteStream.first;
      tradingPairExchangeRate(tradingPairQuote.price);

      if (accountCode == counterCode) {
        baseListedSecond(true);
      } else if (accountCode != baseCode) {
        final accountBaseQuoteStream = exchangeProvider.rates(
          accountCode,
          baseCode,
        );
        final accountBaseQuote = await accountBaseQuoteStream.first;
        baseExchangeRate(accountBaseQuote.price);
      }
    }
  }
}
