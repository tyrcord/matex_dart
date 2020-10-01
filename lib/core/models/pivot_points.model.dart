import 'package:equatable/equatable.dart';

class MatexPivotPointsResult extends Equatable {
  final double pivotPoint;
  final List<double> resistances;
  final List<double> supports;

  const MatexPivotPointsResult({
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
