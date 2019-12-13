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

  C reset<C extends BaseCalculator<S, R>>() => setState(initialState) as C;

  S getState() => state.clone() as S;

  C patchState<C extends BaseCalculator<S, R>>(BaseState partialState) {
    result = null;
    state = state.copyWithState(partialState) as S;
    return _checkStateValidity() as C;
  }

  C setState<C extends BaseCalculator<S, R>>(BaseState state) {
    result = null;
    this.state = state.clone() as S;
    return _checkStateValidity() as C;
  }

  C _checkStateValidity<C extends BaseCalculator<S, R>>() {
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
