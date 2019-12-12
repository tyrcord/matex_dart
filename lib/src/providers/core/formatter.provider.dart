import 'dart:async';
import 'package:intl/intl.dart';

import '../interfaces/interfaces.dart';
import 'instrument.provider.dart';

const _kEmptyString = '';

class FormatterProvider implements AbstractFormatterProvider {
  final InstrumentProvider instrumentProvider;

  FormatterProvider({
    InstrumentProvider instrumentProvider,
  })  : instrumentProvider = instrumentProvider ?? InstrumentProvider(),
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

  String _formatCurrency(
    double value,
    String code,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  ) {
    final formatter = NumberFormat.simpleCurrency(
      locale: locale,
      name: code,
    );

    formatter.minimumFractionDigits = maximumFractionDigits;
    formatter.maximumFractionDigits = minimumFractionDigits;

    return formatter.format(value);
  }
}
