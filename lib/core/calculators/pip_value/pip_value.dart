import 'package:matex_dart/matex_dart.dart';

class MatexPipValueCalculatorCore
    extends MatexBaseCalculator<MatexPipValueCalculatorCore, double>
    with
        MatexLotCoreMixin<MatexPipValueCalculatorCore, double>,
        MatexPipValueCoreMixin<MatexPipValueCalculatorCore, double> {
  MatexPipValueCalculatorCore({
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? pipValueValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialPipValueState;

  @override
  double value() {
    if (result != null) {
      return result!;
    }

    return (result = computePipValue().toDouble());
  }
}

MatexPipValueCalculatorCore pipValue({
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) =>
    MatexPipValueCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
