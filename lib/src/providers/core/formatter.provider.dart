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
      final formatter = NumberFormat.simpleCurrency(
        locale: locale,
        name: code,
      );

      formatter.minimumFractionDigits = maximumFractionDigits ?? round;
      formatter.maximumFractionDigits = minimumFractionDigits ?? round;

      return formatter.format(value);
    }

    return _kEmptyString;
  }

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
      final formatter = NumberFormat.simpleCurrency(
        locale: locale,
        name: code,
      );

      formatter.minimumFractionDigits = maximumFractionDigits ?? round;
      formatter.maximumFractionDigits = minimumFractionDigits ?? round;

      return formatter.format(value);
    }

    return _kEmptyString;
  }
}
