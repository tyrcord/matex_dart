import 'dart:async';

import 'package:intl/intl.dart';

import 'package:matex_dart/matex_dart.dart';

class MatexReporterProvider implements MatexAbstractReporterProvider {
  @override
  Future<String> report({
    String locale = kMatexDefaultLocale,
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
        value = _formatNumberValue(value as num, entry, locale);
      }

      return (accumulator += '$label $value'
          '${index++ < length - 1 ? '\n' : ''}');
    });
  }

  String _formatNumberValue(num value, MatexReportEntry entry, String locale) {
    final formatter = NumberFormat.decimalPattern(locale);
    final minimumFractionDigits = entry.minimumFractionDigits;
    final maximumFractionDigits = entry.maximumFractionDigits;

    if (maximumFractionDigits != null) {
      formatter.maximumFractionDigits = maximumFractionDigits;
    }

    if (minimumFractionDigits != null) {
      formatter.minimumFractionDigits = minimumFractionDigits;
    }

    return formatter.format(value);
  }
}
