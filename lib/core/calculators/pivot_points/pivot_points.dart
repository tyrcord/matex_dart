import 'package:matex_dart/matex_dart.dart';

class MatexPivotPointsCalculatorCore extends MatexBaseCalculator<
        MatexPivotPointsCalculatorCore, MatexPivotPointsResult?>
    with
        MatexPivotPointsCoreMixin<MatexPivotPointsCalculatorCore,
            MatexPivotPointsResult?> {
  MatexPivotPointsCalculatorCore({
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? pivotPointsValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialPivotPointsState;

  @override
  MatexPivotPointsResult? value() {
    if (result != null) {
      return result;
    }

    final method = state.method!;

    if (!isValid) {
      return (result = _defaultValue(method));
    }

    return (result = _value(method));
  }

  MatexPivotPointsResult _defaultValue(MatexPivotPointsMethods method) {
    switch (method) {
      case MatexPivotPointsMethods.camarilla:
        return kDefaultCamarillaPivotPointsResult;
      case MatexPivotPointsMethods.deMark:
        return kDefaultDeMarkPivotPointsResult;
      case MatexPivotPointsMethods.fibonacci:
        return kDefaultFibonacciPivotPointsResult;
      case MatexPivotPointsMethods.woodie:
        return kDefaultWoodiePivotPointsResult;
      default:
        return kDefaultStandardPivotPointsResult;
    }
  }

  MatexPivotPointsResult _value(MatexPivotPointsMethods? method) {
    var closePrice = state.closePrice!;
    var highPrice = state.highPrice!;
    var lowPrice = state.lowPrice!;

    switch (method) {
      case MatexPivotPointsMethods.camarilla:
        return pivotPointsCamarilla(highPrice, lowPrice, closePrice);
      case MatexPivotPointsMethods.deMark:
        final openPrice = state.openPrice!;
        return pivotPointsDeMark(highPrice, lowPrice, closePrice, openPrice);
      case MatexPivotPointsMethods.fibonacci:
        return pivotPointsFibonacci(highPrice, lowPrice, closePrice);
      case MatexPivotPointsMethods.woodie:
        return pivotPointsWoodie(highPrice, lowPrice, closePrice);
      default:
        return pivotPointsStandard(highPrice, lowPrice, closePrice);
    }
  }
}

MatexPivotPointsCalculatorCore pivotPoints({
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) =>
    MatexPivotPointsCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
