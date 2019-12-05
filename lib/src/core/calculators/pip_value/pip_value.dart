import 'package:matex_dart/matex_dart.dart';

class PipValueCalculator<S extends PipValueState, R>
    extends BaseCalculator<S, R>
    with
        LotMixin<PipValueCalculator<S, R>, S, R>,
        PipValueMixin<PipValueCalculator<S, R>, S, R> {
  PipValueCalculator({
    S initialState,
    List<StateValidator<S>> validators,
  }) : super(
          initialState: initialState ?? kInitialPipValueState as S,
          validators: validators ?? pipValueValidators,
        );

  R value() {
    if (result != null) {
      return result;
    }

    return (result = computePipValue() as R);
  }
}

PipValueCalculator<PipValueState, double> pip() =>
    PipValueCalculator<PipValueState, double>();
