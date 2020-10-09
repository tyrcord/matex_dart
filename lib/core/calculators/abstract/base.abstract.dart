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
  MatexBaseCoreState initialState;
  @protected
  List<MatexStateValidator> validators;

  MatexBaseCoreState get validState {
    return isStateValid ? state : initialState;
  }

  bool get isValid => isStateValid;

  bool get isDirty => state != initialState;

  MatexBaseCalculator({
    @required this.initialState,
    this.validators,
  }) : assert(initialState != null) {
    reset();
  }

  R value();

  C reset() => setState(initialState);

  MatexBaseCoreState getState() => state.clone();

  C patchState(MatexBaseCoreState partialState) {
    result = null;
    state = state.copyWithState(partialState);
    return _checkStateValidity();
  }

  C resetStateProperties(List<String> properties) {
    result = null;
    state = state.copyWithOmittedProperties(properties, initialState);
    return _checkStateValidity();
  }

  C setInitialState(MatexBaseCoreState state) {
    initialState = state.clone();
    return this as C;
  }

  C setState(MatexBaseCoreState state) {
    result = null;
    this.state = state.clone();
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
