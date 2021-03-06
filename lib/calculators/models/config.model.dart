import 'package:matex_dart/matex_dart.dart';

class MatexConfig {
  final MatexAbstractInstrumentMetadataProvider? instrumentProvider;
  final MatexAbstractFormatterProvider? formatterProvider;
  final MatexAbstractExchangeProvider? exchangeProvider;
  final MatexAbstractReporterProvider? reporterProvider;
  final MatexAbstractPairMetadataProvider? pairProvider;

  const MatexConfig({
    this.instrumentProvider,
    this.formatterProvider,
    this.exchangeProvider,
    this.reporterProvider,
    this.pairProvider,
  });
}
