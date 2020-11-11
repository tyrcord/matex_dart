import 'dart:async';
import 'package:intl/intl.dart';
import 'package:matex_dart/matex_dart.dart';

import '../interfaces/interfaces.dart';
import 'instrument.provider.dart';

const _kEmptyString = '';

class MatexFormatterProvider implements MatexAbstractFormatterProvider {
  final MatexInstrumentProvider instrumentProvider;
  final MatexPairMetadataProvider pairProvider;

  MatexFormatterProvider({
    MatexInstrumentProvider instrumentProvider,
    MatexPairMetadataProvider pairProvider,
  })  : instrumentProvider = instrumentProvider ?? MatexInstrumentProvider(),
        pairProvider = pairProvider ?? MatexPairMetadataProvider(),
        super();

  @override
  Future<String> formatInstrument({
    double value,
    String code,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  }) async {
    final instrumentMetadata = await instrumentProvider.metadata(code);

    if (instrumentMetadata != null) {
      final format = instrumentMetadata.format;
      final round = format.round;

      return _formatCurrency(
        value,
        code,
        locale,
        maximumFractionDigits ?? round,
        minimumFractionDigits ?? round,
      );
    }

    return _kEmptyString;
  }

  @override
  Future<String> formatQuote({
    double value,
    String pair,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  }) async {
    final pairMetadata = await pairProvider.metadata(pair);
    var round = pairMetadata != null
        ? pairMetadata.pip.round
        : MatexPairPipMetadata.defaultMetatda().round;

    return formatNumber(
      value,
      locale,
      maximumFractionDigits ?? round,
      minimumFractionDigits ?? round,
    );
  }

  String _formatCurrency(
    double value,
    String code,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  ) {
    final formatter = NumberFormat.simpleCurrency(locale: locale, name: code);

    if (minimumFractionDigits != null) {
      formatter.minimumFractionDigits = minimumFractionDigits;
    }

    if (maximumFractionDigits != null) {
      formatter.maximumFractionDigits = maximumFractionDigits;
    }

    return formatter.format(value);
  }

  String formatNumber(
    double value,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  ) {
    final formatter = NumberFormat.decimalPattern(locale);

    if (minimumFractionDigits != null) {
      formatter.minimumFractionDigits = minimumFractionDigits;
    }

    if (maximumFractionDigits != null) {
      formatter.maximumFractionDigits = maximumFractionDigits;
    }

    return formatter.format(value);
  }
}
