import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

abstract class BaseCalculator<S extends BaseState, R> {
  @protected
  S state;
  @protected
  R result;
  @protected
  bool isStateValid = true;
  @protected
  S initialState;
  @protected
  List<StateValidator<S>> validators;

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

  BaseCalculator<S, R> reset() => setState(initialState);

  S getState() => state.clone() as S;

  BaseCalculator<S, R> setState(BaseState state) {
    result = null;
    this.state = state.clone() as S;
    return checkStateValidity();
  }

  BaseCalculator<S, R> patchState(BaseState partialState) {
    result = null;
    state = state.copyWithState(partialState) as S;
    return checkStateValidity();
  }

  @protected
  BaseCalculator<S, R> checkStateValidity() {
    bool validity = true;

    if (validators != null) {
      validity = validators.every((validator) => validator(state));
    }

    this.isStateValid = validity;
    return this;
  }

  @protected
  double sanitizeDouble(double value) => value.abs();
}
