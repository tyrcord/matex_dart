import 'dart:async';
import 'package:intl/intl.dart';

import '../interfaces/interfaces.dart';
import 'instrument.provider.dart';

const _kEmptyString = '';

class FormatterProvider implements AbstractFormatterProvider {
  InstrumentProvider instrumentProvider;

  Stream<String> formatInstrument({
    double value,
    String code,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  }) {
    return instrumentProvider.metadata(code).take(1).map((instrumentMetadata) {
      if (instrumentMetadata != null) {
        final format = instrumentMetadata.format;
        final round = format.round;
        final formatter =
            NumberFormat.simpleCurrency(locale: locale, name: code);

        formatter.minimumFractionDigits = maximumFractionDigits ?? round;
        formatter.maximumFractionDigits = minimumFractionDigits ?? round;

        return formatter.format(value);
      }

      return _kEmptyString;
    });
  }

  Stream<String> formatQuote({
    double value,
    String code,
    String locale,
    int maximumFractionDigits,
    int minimumFractionDigits,
  }) {
    return instrumentProvider.metadata(code).take(1).map((instrumentMetadata) {
      if (instrumentMetadata != null) {
        final pip = instrumentMetadata.pip;
        final round = pip.round;
        final formatter =
            NumberFormat.simpleCurrency(locale: locale, name: code);

        formatter.minimumFractionDigits = maximumFractionDigits ?? round;
        formatter.maximumFractionDigits = minimumFractionDigits ?? round;

        return formatter.format(value);
      }

      return _kEmptyString;
    });
  }
}
