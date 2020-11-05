import 'dart:async';

import 'package:intl/intl.dart';

import '../interfaces/interfaces.dart';
import '../models/models.dart';

class MatexReporterProvider implements MatexAbstractReporterProvider {
  @override
  Future<String> report({
    String locale = 'EN_US',
    List<MatexReportEntry> entries,
  }) async =>
      _stringify(locale, entries);

  String _stringify(String locale, List<MatexReportEntry> entries) {
    final length = entries.length;
    var index = 0;

    return entries.fold('', (String accumulator, MatexReportEntry entry) {
      final label = entry.label ?? '';
      var value = entry.value ?? '';

      if (value is num) {
        final formatter = NumberFormat.decimalPattern(locale);
        final minimumFractionDigits = entry.minimumFractionDigits;
        final maximumFractionDigits = entry.maximumFractionDigits;

        if (minimumFractionDigits != null) {
          formatter.minimumFractionDigits = minimumFractionDigits;
          formatter.maximumFractionDigits = minimumFractionDigits;
        }

        if (maximumFractionDigits != null) {
          formatter.maximumFractionDigits = maximumFractionDigits;
        }

        value = formatter.format(value);
      }

      return (accumulator += '$label $value'
          '${index++ < length - 1 ? '\n' : ''}');
    });
  }
}
