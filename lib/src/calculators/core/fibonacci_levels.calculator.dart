import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexFibonacciLevelsCalculator extends FibonacciLevelsCalculator {
  final MatexConfig config;

  MatexFibonacciLevelsCalculator({
    @required this.config,
    MatexFibonacciLevelsState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState,
          validators: validators,
        );

  Future<FibonacciLevelsResult> asyncValue() async {
    return super.value();
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
