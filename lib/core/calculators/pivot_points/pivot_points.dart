import 'package:matex_dart/matex_dart.dart';

class MatexPivotPointsCalculatorCore extends MatexBaseCalculator<
        MatexPivotPointsCalculatorCore, MatexPivotPointsResult>
    with
        MatexPivotPointsCoreMixin<MatexPivotPointsCalculatorCore,
            MatexPivotPointsResult> {
  MatexPivotPointsCalculatorCore({
    MatexBaseCoreState defaultState,
    List<MatexStateValidator> validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? pivotPointsValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialPivotPointsState;

  @override
  MatexPivotPointsResult value() {
    if (this.result != null) {
      return this.result;
    }

    final method = validState.method;
    final closePrice = validState.closePrice;
    final highPrice = validState.highPrice;
    final lowPrice = validState.lowPrice;
    MatexPivotPointsResult result;

    switch (method) {
      case MatexPivotPointsMethods.Camarilla:
        result = pivotPointsCamarilla(highPrice, lowPrice, closePrice);
        break;
      case MatexPivotPointsMethods.DeMark:
        final openPrice = validState.openPrice;
        result = pivotPointsDeMark(highPrice, lowPrice, closePrice, openPrice);
        break;
      case MatexPivotPointsMethods.Fibonacci:
        result = pivotPointsFibonacci(highPrice, lowPrice, closePrice);
        break;
      case MatexPivotPointsMethods.Woodie:
        result = pivotPointsWoodie(highPrice, lowPrice, closePrice);
        break;
      default:
        result = pivotPointsStandard(highPrice, lowPrice, closePrice);
        break;
    }

    return (this.result = result);
  }
}

MatexPivotPointsCalculatorCore pivotPoints({
  MatexBaseCoreState defaultState,
  List<MatexStateValidator> validators,
}) =>
    MatexPivotPointsCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
