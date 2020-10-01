import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPivotPointsCalculator extends MatexBaseCalculator<
        MatexPivotPointsCalculator,
        MatexPivotPointsState,
        Future<MatexPivotPointsResult>>
    with
        MatexPivotPointsCoreMixin<MatexPivotPointsCalculator, MatexPivotPointsState,
            Future<MatexPivotPointsResult>> {
  final MatexConfig config;

  MatexPivotPointsCalculator({
    @required this.config,
    MatexPivotPointsState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState,
          validators: validators,
        );

  @override
  Future<MatexPivotPointsResult> value() async {
    return pivotPoints(initialState: state).value();
  }
}

MatexPivotPointsCalculator matexPivotPoints({
  MatexConfig config,
  MatexPivotPointsState initialState,
  List<MatexStateValidator> validators,
}) {
  return MatexPivotPointsCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
