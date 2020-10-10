import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

abstract class MatexBaseCalculator<C extends MatexBaseCalculator<C, R>, R> {
  @protected
  MatexBaseCoreState state;
  @protected
  R result;
  @protected
  bool isStateValid = true;
  @protected
  List<MatexStateValidator> validators;
  @protected
  MatexBaseCoreState defaultState;

  MatexBaseCoreState differenceState;

  MatexBaseCoreState get defaultCalculatorState;

  MatexBaseCoreState get validState {
    return isStateValid ? state : defaultState;
  }

  bool get isValid => isStateValid;

  bool get isDirty => state != defaultState;

  MatexBaseCalculator({
    this.defaultState,
    this.validators,
  }) {
    reset();
  }

  R value();

  C reset() {
    defaultState ??= defaultCalculatorState;
    var calculator = setState(defaultState);
    differenceState = MatexBaseCoreState();
    return calculator;
  }

  MatexBaseCoreState getState() => state.clone();

  C patchState(MatexBaseCoreState partialState) {
    differenceState = differenceState.copyWithState(partialState);
    state = state.copyWithState(partialState);
    result = null;
    return _checkStateValidity();
  }

  C resetStateProperties(List<String> properties) {
    differenceState = state.copyWithOmittedProperties(properties);
    state = state.copyWithOmittedProperties(
      properties,
      defaultState: defaultCalculatorState,
    );

    result = null;

    return _checkStateValidity();
  }

  C setDefaultState(MatexBaseCoreState defaultState) {
    this.defaultState = defaultState.clone();
    state = defaultState.copyWithState(differenceState);
    return _checkStateValidity();
  }

  C setState(MatexBaseCoreState state) {
    this.state = state.clone();
    result = null;
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
