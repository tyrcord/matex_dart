import 'package:meta/meta.dart';

class ReportEntry {
  final String label;
  final double value;
  final int minimumFractionDigits;
  final int maximumFractionDigits;

  const ReportEntry({
    @required this.label,
    @required this.value,
    this.minimumFractionDigits = 2,
    this.maximumFractionDigits,
  });
}

abstract class AbstractReporterProvider {
  Stream<String> report({
    @required String locale,
    @required Map<String, ReportEntry> reportState,
  });
}
