import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

abstract class BaseCalculator<C extends BaseCalculator<C, S, R>,
    S extends BaseState, R> {
  @protected
  S state;
  @protected
  R result;
  @protected
  bool isStateValid = true;
  @protected
  S initialState;
  @protected
  List<StateValidator> validators;

  S get validState {
    return isStateValid ? state : initialState;
  }

  bool get isValid {
    return isStateValid;
  }

  BaseCalculator({
    this.initialState,
    this.validators,
  }) {
    reset();
  }

  R value();

  C reset() => setState(initialState);

  S getState() => state.clone() as S;

  C patchState(BaseState partialState) {
    result = null;
    state = state.copyWithState(partialState) as S;
    return _checkStateValidity();
  }

  C setState(BaseState state) {
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
