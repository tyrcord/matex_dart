import 'package:matex_dart/matex_dart.dart';

class MatexPivotPointsCalculator extends MatexBaseCalculator<
        MatexPivotPointsCalculator, Future<MatexPivotPointsResult>>
    with
        MatexPivotPointsCoreMixin<MatexPivotPointsCalculator,
            Future<MatexPivotPointsResult>> {
  final MatexConfig config;

  MatexPivotPointsCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? pivotPointsValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialPivotPointsState;

  @override
  Future<MatexPivotPointsResult> value() async {
    return pivotPoints(defaultState: state).value();
  }
}

MatexPivotPointsCalculator matexPivotPoints({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexPivotPointsCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
