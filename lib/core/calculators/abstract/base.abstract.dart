import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

abstract class MatexBaseCalculator<C extends MatexBaseCalculator<C, R>, R> {
  @protected
  late MatexBaseCoreState state;
  @protected
  R? result;
  @protected
  bool isStateValid = true;
  @protected
  List<MatexStateValidator>? validators;
  @protected
  MatexBaseCoreState? defaultState;

  late MatexBaseCoreState _differenceState;

  MatexBaseCoreState get differenceState => _differenceState;

  set differenceState(MatexBaseCoreState candidateState) {
    _differenceState = _sanitizeDifferenceState(candidateState);
  }

  MatexBaseCoreState get defaultCalculatorState;

  bool get isValid => isStateValid;

  bool get isDirty => state != defaultState;

  Iterable<String> get propertiesUseForDifference => const [];

  MatexBaseCalculator({
    this.defaultState,
    this.validators,
  }) {
    reset();
  }

  R value();

  C reset() {
    defaultState ??= defaultCalculatorState;
    var calculator = setState(defaultState!);
    differenceState = const MatexBaseCoreState();

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

  C setDefaultState(MatexBaseCoreState nextDefaultState) {
    defaultState = nextDefaultState.clone();
    state = nextDefaultState.copyWithState(differenceState);

    return _checkStateValidity();
  }

  C setState(MatexBaseCoreState nextState) {
    state = nextState.clone();
    result = null;

    return _checkStateValidity();
  }

  // ignore: code-metrics, long-method
  MatexBaseCoreState _sanitizeDifferenceState(
    MatexBaseCoreState candidateState,
  ) {
    var candidateMap = candidateState.toJson();
    var defaultMap = defaultState!.toJson();
    var defaultCounterCode = defaultMap[MatexCoreStateProperty.counterCode];
    var defaultBaseCode = defaultMap[MatexCoreStateProperty.baseCode];
    var counterCode;
    var baseCode;

    for (var entry in candidateMap.entries) {
      var isCounterCode = entry.key == MatexCoreStateProperty.counterCode;
      var isBaseCode = entry.key == MatexCoreStateProperty.baseCode;

      // Special case (they are bounded)
      if (isBaseCode || isCounterCode) {
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
      } else if (!propertiesUseForDifference.contains(entry.key)) {
        candidateMap[entry.key] = null;
      }
    }

    return MatexBaseCoreState.fromJson(candidateMap);
  }

  C _checkStateValidity() {
    var validity = true;

    if (validators != null) {
      validity = validators!.every((validator) => validator(state));
    }

    isStateValid = validity;

    return this as C;
  }

  @protected
  double sanitizeDouble(double value) => value.abs();

  @protected
  Decimal toPercentageDecimal(num value) {
    return toDecimal(value / MatexDecimal.hundred.toDouble());
  }
}
