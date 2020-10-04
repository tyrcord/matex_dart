import 'package:matex_dart/matex_dart.dart';

class MatexPipValueCalculatorCore
    extends MatexBaseCalculator<MatexPipValueCalculatorCore, double>
    with
        MatexLotCoreMixin<MatexPipValueCalculatorCore, double>,
        MatexPipValueCoreMixin<MatexPipValueCalculatorCore, double> {
  MatexPipValueCalculatorCore({
    MatexBaseCoreState initialState,
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
  MatexBaseCoreState initialState,
  List<MatexStateValidator> validators,
}) =>
    MatexPipValueCalculatorCore(
      initialState: initialState,
      validators: validators,
    );
