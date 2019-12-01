import 'package:equatable/equatable.dart';

class PivotPointsResult with EquatableMixin {
  final double pivotPoint;
  final List<double> resistances;
  final List<double> supports;

  PivotPointsResult({
    this.pivotPoint,
    this.resistances,
    this.supports,
  });

  @override
  List<Object> get props => [
        pivotPoint,
        resistances,
        supports,
      ];
}
