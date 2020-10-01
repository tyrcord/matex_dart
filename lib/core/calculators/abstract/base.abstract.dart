import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

abstract class MatexBaseCalculator<C extends MatexBaseCalculator<C, S, R>,
    S extends MatexBaseCoreState, R> {
  @protected
  S state;
  @protected
  R result;
  @protected
  bool isStateValid = true;
  @protected
  S initialState;
  @protected
  List<MatexStateValidator> validators;

  S get validState {
    return isStateValid ? state : initialState;
  }

  bool get isValid {
    return isStateValid;
  }

  MatexBaseCalculator({
    this.initialState,
    this.validators,
  }) {
    reset();
  }

  R value();

  C reset() => setState(initialState);

  S getState() => state.clone() as S;

  C patchState(MatexBaseCoreState partialState) {
    result = null;
    state = state.copyWithState(partialState) as S;
    return _checkStateValidity();
  }

  C setState(MatexBaseCoreState state) {
    result = null;
    this.state = state.clone() as S;
    return _checkStateValidity();
  }

  C _checkStateValidity() {
    var validity = true;

    if (validators != null) {
      validity = validators.every((validator) => validator(state));
    }

    isStateValid = validity;
    return this as C;
  }

  @protected
  double sanitizeDouble(double value) => value.abs();
}
