import 'package:matex_dart/matex_dart.dart';

class MatexConfig {
  final AbstractInstrumentMetadataProvider instrumentProvider;
  final AbstractFormatterProvider formatterProvider;
  final AbstractExchangeProvider exchangeProvider;
  final AbstractReporterProvider reporterProvider;
  final AbstractPairMetadataProvider pairProvider;

  const MatexConfig({
    this.instrumentProvider,
    this.formatterProvider,
    this.exchangeProvider,
    this.reporterProvider,
    this.pairProvider,
  });
}
