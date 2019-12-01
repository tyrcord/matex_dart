import 'package:matex_dart/matex_dart.dart';

class PipValueCalculator extends BaseCalculator<PipValueState, double>
    with
        LotMixin<PipValueCalculator, PipValueState, double>,
        PipValueMixin<PipValueCalculator, PipValueState, double> {
  PipValueCalculator({
    PipValueState initialState,
    List<StateValidator<PipValueState>> validators,
  }) : super(
          initialState: initialState ?? initialPipValueState,
          validators: validators ?? pipValueValidators,
        );

  double value() {
    if (result != null) {
      return result;
    }

    return (result = computePipValue());
  }
}

PipValueCalculator pip() => PipValueCalculator();
