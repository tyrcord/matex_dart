import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPivotPointsCalculator extends BaseCalculator<
        MatexPivotPointsCalculator,
        MatexPivotPointsState,
        Future<PivotPointsResult>>
    with
        PivotPointsMixin<MatexPivotPointsCalculator, MatexPivotPointsState,
            Future<PivotPointsResult>> {
  final MatexConfig config;

  MatexPivotPointsCalculator({
    @required this.config,
    MatexPivotPointsState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState,
          validators: validators,
        );

  @override
  Future<PivotPointsResult> value() async {
    return pivotPoints(initialState: state).value();
  }
}

MatexPivotPointsCalculator matexPivotPoints({
  MatexConfig config,
  MatexPivotPointsState initialState,
  List<StateValidator> validators,
}) {
  return MatexPivotPointsCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
