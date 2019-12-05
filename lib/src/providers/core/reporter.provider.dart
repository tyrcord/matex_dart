import 'dart:async';
import 'package:intl/intl.dart';

import '../interfaces/interfaces.dart';
import '../models/models.dart';

class ReporterProvider implements AbstractReporterProvider {
  Stream<String> report({
    String locale = 'EN_US',
    Map<String, ReportEntry> reportState,
  }) async* {
    yield _stringify(locale, reportState);
  }

  String _stringify(String locale, Map<String, ReportEntry> reportState) {
    final entries = reportState.entries;
    final length = entries.length;
    int index = 0;

    return entries.fold('', (
      String accumulator,
      MapEntry<String, ReportEntry> mapEntry,
    ) {
      final label = mapEntry.value.label;
      final value = mapEntry.value.value;
      final minimumFractionDigits = mapEntry.value.minimumFractionDigits;
      final maximumFractionDigits = mapEntry.value.maximumFractionDigits;
      final formatter = NumberFormat.decimalPattern(locale);

      formatter.minimumFractionDigits = minimumFractionDigits;
      formatter.maximumFractionDigits =
          maximumFractionDigits ?? minimumFractionDigits;

      return (accumulator +=
          '$label ${formatter.format(value)}${index++ < length - 1 ? '\n' : ''}');
    });
  }
}
