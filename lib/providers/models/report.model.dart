import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MatexReportEntry extends Equatable {
  final String label;
  final dynamic value;
  final int minimumFractionDigits;
  final int maximumFractionDigits;

  const MatexReportEntry({
    @required this.label,
    @required this.value,
    this.minimumFractionDigits = 2,
    this.maximumFractionDigits,
  });

  @override
  List<Object> get props => [
        label,
        value,
        minimumFractionDigits,
        maximumFractionDigits,
      ];
}
