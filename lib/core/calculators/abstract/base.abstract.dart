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

  MatexBaseCoreState _differenceState;

  MatexBaseCoreState get differenceState => _differenceState;

  set differenceState(MatexBaseCoreState candidateState) {
    if (candidateState != null) {
      candidateState = _sanitizeDifferenceState(candidateState);
    }

    _differenceState = candidateState;
  }

  MatexBaseCoreState get defaultCalculatorState;

  MatexBaseCoreState get validState {
    return isStateValid ? state : defaultState;
  }

  bool get isValid => isStateValid;

  bool get isDirty => state != defaultState;

  Iterable<String> get propertiesUseForDifference => null;

  MatexBaseCalculator({
    @required this.defaultState,
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

  MatexBaseCoreState _sanitizeDifferenceState(
    MatexBaseCoreState candidateState,
  ) {
    var defaultMap = defaultState.toJson();
    var candidateMap = candidateState.toJson();
    var defaultCounterCode = defaultMap[MatexCoreStateProperty.counterCode];
    var defaultBaseCode = defaultMap[MatexCoreStateProperty.baseCode];
    var baseCode;
    var counterCode;

    candidateMap.entries.forEach((MapEntry<String, dynamic> entry) {
      var isBaseCode = entry.key == MatexCoreStateProperty.baseCode;

      // Special case (they are bounded)
      if (isBaseCode || entry.key == MatexCoreStateProperty.counterCode) {
        if (isBaseCode) {
          baseCode = entry.value;
        } else {
          counterCode = entry.value;
        }

        if (baseCode == defaultBaseCode && counterCode == defaultCounterCode) {
          candidateMap[MatexCoreStateProperty.counterCode] = null;
          candidateMap[MatexCoreStateProperty.baseCode] = null;
        }
      } else if (entry.value == defaultMap[entry.key]) {
        candidateMap[entry.key] = null;
      } else if (propertiesUseForDifference != null &&
          !propertiesUseForDifference.contains(entry.key)) {
        candidateMap[entry.key] = null;
      }
    });

    return MatexBaseCoreState.fromJson(candidateMap);
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
