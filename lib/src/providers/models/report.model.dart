import 'package:meta/meta.dart';

class ReportEntry {
  final String label;
  final dynamic value;
  final int minimumFractionDigits;
  final int maximumFractionDigits;

  const ReportEntry({
    @required this.label,
    @required this.value,
    this.minimumFractionDigits = 2,
    this.maximumFractionDigits,
  });
}
