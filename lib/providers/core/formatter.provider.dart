import 'dart:async';

import 'package:intl/intl.dart';

import 'package:matex_dart/matex_dart.dart';

const _kEmptyString = '';

class MatexFormatterProvider implements MatexAbstractFormatterProvider {
  final MatexInstrumentProvider instrumentProvider;
  final MatexPairMetadataProvider pairProvider;

  MatexFormatterProvider({
    MatexInstrumentProvider? instrumentProvider,
    MatexPairMetadataProvider? pairProvider,
  })  : instrumentProvider = instrumentProvider ?? MatexInstrumentProvider(),
        pairProvider = pairProvider ?? MatexPairMetadataProvider(),
        super();

  @override
  Future<String> formatInstrument({
    required double value,
    required String code,
    String locale = kMatexDefaultLocale,
    int? minimumFractionDigits = 0,
    int? maximumFractionDigits,
  }) async {
    final instrumentMetadata = await instrumentProvider.metadata(code);

    if (instrumentMetadata != null) {
      final format = instrumentMetadata.format!;
      final round = format.round;

      return _formatCurrency(
        value: value,
        code: code,
        locale: locale,
        minimumFractionDigits: minimumFractionDigits ?? round,
        maximumFractionDigits: maximumFractionDigits ?? round,
      );
    }

    return _kEmptyString;
  }

  @override
  Future<String> formatQuote({
    required double value,
    required String pair,
    String locale = kMatexDefaultLocale,
    int? minimumFractionDigits,
    int? maximumFractionDigits,
  }) async {
    final pairMetadata = await pairProvider.metadata(pair);
    var round = pairMetadata != null
        ? pairMetadata.pip.round
        : MatexPairPipMetadata.defaultMetatada().round;

    return formatNumber(
      value: value,
      locale: locale,
      minimumFractionDigits: minimumFractionDigits ?? round,
      maximumFractionDigits: maximumFractionDigits ?? round,
    );
  }

  String _formatCurrency({
    required double value,
    required String code,
    String locale = kMatexDefaultLocale,
    int? minimumFractionDigits = 0,
    int? maximumFractionDigits,
  }) {
    final formatter = NumberFormat.simpleCurrency(locale: locale, name: code);

    if (maximumFractionDigits != null) {
      formatter.maximumFractionDigits = maximumFractionDigits;
    }

    if (minimumFractionDigits != null) {
      formatter.minimumFractionDigits = minimumFractionDigits;
    }

    return formatter.format(value);
  }

  String formatNumber({
    required double value,
    String locale = kMatexDefaultLocale,
    int? minimumFractionDigits = 0,
    int? maximumFractionDigits,
  }) {
    final formatter = NumberFormat.decimalPattern(locale);

    if (maximumFractionDigits != null) {
      formatter.maximumFractionDigits = maximumFractionDigits;
    }

    if (minimumFractionDigits != null) {
      formatter.minimumFractionDigits = minimumFractionDigits;
    }

    return formatter.format(value);
  }
}
