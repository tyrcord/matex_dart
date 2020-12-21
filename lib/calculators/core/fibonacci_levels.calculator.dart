import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexFibonacciLevelsCalculator extends MatexBaseCalculator<
        MatexFibonacciLevelsCalculator, Future<FibonacciLevelsResult>>
    with
        MatexFibonacciLevelsCoreMixin<MatexFibonacciLevelsCalculator,
            Future<FibonacciLevelsResult>> {
  final MatexConfig config;

  MatexFibonacciLevelsCalculator({
    @required this.config,
    MatexBaseCoreState defaultState,
    List<MatexStateValidator> validators,
  })  : assert(config != null),
        super(
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
  @required MatexConfig config,
  MatexBaseCoreState defaultState,
  List<MatexStateValidator> validators,
}) {
  assert(config != null);

  return MatexFibonacciLevelsCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
