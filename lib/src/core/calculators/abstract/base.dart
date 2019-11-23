import 'package:matex_dart/src/core/enums/enums.dart';
import 'package:matex_dart/src/core/types/types.dart';
import 'package:meta/meta.dart';

abstract class BaseCalculator<R> {
  @protected
  Map<CalculatorKey, dynamic> state;
  @protected
  R result;
  @protected
  bool isStateValid = true;
  @protected
  Map<CalculatorKey, dynamic> initialState;
  @protected
  List<StateValidator> validators;

  Map<CalculatorKey, dynamic> get validState {
    return isStateValid ? state : initialState;
  }

  bool get isValid {
    return isStateValid;
  }

  BaseCalculator({
    this.initialState,
    this.validators,
  }) {
    state = {...initialState};
    checkStateValidity();
  }

  BaseCalculator<R> reset() {
    result = null;
    state = {...initialState};
    checkStateValidity();
    return this;
  }

  T getValueForKey<T>(CalculatorKey key) {
    return this.state[key] as T;
  }

  BaseCalculator<R> setState(Map<CalculatorKey, dynamic> state) {
    result = null;
    this.state = {
      ...this.state,
      ...state,
    };

    checkStateValidity();
    return this;
  }

  BaseCalculator<R> setValue(CalculatorKey key, dynamic value) {
    if (value is num) {
      value = value.abs();
    }

    this.result = null;
    this.state = {
      ...this.state,
    }..addEntries([MapEntry(key, value)]);

    checkStateValidity();
    return this;
  }

  R value();

  @protected
  void checkStateValidity() {
    bool validity = true;

    if (validators != null) {
      validity = validators.every((validator) => validator(state));
    }

    this.isStateValid = validity;
  }
}
