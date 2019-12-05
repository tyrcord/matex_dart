import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPivotPointsCalculator extends PivotPointsCalculator {
  final MatexConfig config;

  MatexPivotPointsCalculator({
    @required this.config,
    MatexPivotPointsState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState,
          validators: validators,
        );

  Future<PivotPointsResult> asyncValue() async {
    return super.value();
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
