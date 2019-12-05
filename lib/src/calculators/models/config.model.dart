import 'package:matex_dart/matex_dart.dart';

class MatexConfig {
  final AbstractExchangeProvider exchangeProvider;
  final AbstractFormatterProvider formatterProvider;
  final AbstractInstrumentProvider instrumentProvider;
  final AbstractReporterProvider reporterProvider;

  const MatexConfig({
    this.exchangeProvider,
    this.formatterProvider,
    this.instrumentProvider,
    this.reporterProvider,
  });
}
