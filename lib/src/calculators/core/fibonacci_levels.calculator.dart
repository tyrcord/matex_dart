import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexFibonacciLevelsCalculator extends BaseCalculator<
        MatexFibonacciLevelsCalculator,
        MatexFibonacciLevelsState,
        Future<FibonacciLevelsResult>>
    with
        FibonacciLevelsMixin<MatexFibonacciLevelsCalculator,
            MatexFibonacciLevelsState, Future<FibonacciLevelsResult>> {
  final MatexConfig config;

  MatexFibonacciLevelsCalculator({
    @required this.config,
    MatexFibonacciLevelsState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState,
          validators: validators,
        );

  @override
  Future<FibonacciLevelsResult> value() async {
    return fibonacciLevels(initialState: state).value();
  }
}

MatexFibonacciLevelsCalculator matexFibonacciLevels({
  MatexConfig config,
  MatexFibonacciLevelsState initialState,
  List<StateValidator> validators,
}) {
  return MatexFibonacciLevelsCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
