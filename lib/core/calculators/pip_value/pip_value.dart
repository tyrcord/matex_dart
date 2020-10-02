import 'package:matex_dart/matex_dart.dart';

class MatexPipValueCalculatorCore extends MatexBaseCalculator<
        MatexPipValueCalculatorCore, MatexPipValueCoreState, double>
    with
        MatexLotCoreMixin<MatexPipValueCalculatorCore, MatexPipValueCoreState,
            double>,
        MatexPipValueCoreMixin<MatexPipValueCalculatorCore,
            MatexPipValueCoreState, double> {
  MatexPipValueCalculatorCore({
    MatexPipValueCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialPipValueState,
          validators: validators ?? pipValueValidators,
        );

  @override
  double value() {
    if (result != null) {
      return result;
    }

    return (result = computePipValue().toDouble());
  }
}

MatexPipValueCalculatorCore pip({
  MatexPipValueCoreState initialState,
  List<MatexStateValidator> validators,
}) =>
    MatexPipValueCalculatorCore(
      initialState: initialState,
      validators: validators,
    );
