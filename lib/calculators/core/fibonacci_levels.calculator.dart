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
    MatexBaseCoreState initialState,
    List<MatexStateValidator> validators,
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
  MatexBaseCoreState initialState,
  List<MatexStateValidator> validators,
}) {
  return MatexFibonacciLevelsCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
