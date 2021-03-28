import 'package:matex_dart/matex_dart.dart';

class MatexFibonacciLevelsCalculator extends MatexBaseCalculator<
        MatexFibonacciLevelsCalculator, Future<FibonacciLevelsResult>>
    with
        MatexFibonacciLevelsCoreMixin<MatexFibonacciLevelsCalculator,
            Future<FibonacciLevelsResult>> {
  final MatexConfig config;

  MatexFibonacciLevelsCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? fibonacciLevelsValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialFibonacciLevelsState;

  @override
  Future<FibonacciLevelsResult> value() async {
    return fibonacciLevels(defaultState: state).value();
  }
}

MatexFibonacciLevelsCalculator matexFibonacciLevels({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexFibonacciLevelsCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
