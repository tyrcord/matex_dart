import 'package:matex_dart/matex_dart.dart';

class PipValueCalculator
    extends BaseCalculator<PipValueCalculator, PipValueState, double>
    with
        LotMixin<PipValueCalculator, PipValueState, double>,
        PipValueMixin<PipValueCalculator, PipValueState, double> {
  PipValueCalculator({
    PipValueState initialState,
    List<StateValidator> validators,
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

PipValueCalculator pip({
  PipValueState initialState,
  List<StateValidator> validators,
}) =>
    PipValueCalculator(
      initialState: initialState,
      validators: validators,
    );
