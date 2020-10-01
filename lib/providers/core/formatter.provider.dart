import 'dart:async';
import 'package:intl/intl.dart';

import '../interfaces/interfaces.dart';
import 'instrument.provider.dart';

const _kEmptyString = '';

class MatexFormatterProvider implements MatexAbstractFormatterProvider {
  final MatexInstrumentProvider instrumentProvider;

  MatexFormatterProvider({
    MatexInstrumentProvider instrumentProvider,
  })  : instrumentProvider = instrumentProvider ?? MatexInstrumentProvider(),
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
    String code,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  }) async {
    final instrumentMetadata = await instrumentProvider.metadata(code);
    if (instrumentMetadata != null) {
      final pip = instrumentMetadata.pip;
      final round = pip.round;

      return formatNumber(
        value,
        locale,
        maximumFractionDigits ?? round,
        minimumFractionDigits ?? round,
      );
    }

    return _kEmptyString;
  }

  String _formatCurrency(
    double value,
    String code,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  ) {
    final formatter = NumberFormat.simpleCurrency(locale: locale, name: code);

    maximumFractionDigits = value != 0 ? maximumFractionDigits : 0;
    formatter.minimumFractionDigits = maximumFractionDigits;
    formatter.maximumFractionDigits = minimumFractionDigits;

    return formatter.format(value);
  }

  String formatNumber(
    double value,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  ) {
    final formatter = NumberFormat.decimalPattern(locale);

    maximumFractionDigits = value != 0 ? maximumFractionDigits : 0;
    formatter.minimumFractionDigits = maximumFractionDigits;
    formatter.maximumFractionDigits = minimumFractionDigits;

    return formatter.format(value);
  }
}
