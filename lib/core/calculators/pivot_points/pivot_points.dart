import 'package:matex_dart/matex_dart.dart';

class MatexPivotPointsCalculatorCore extends MatexBaseCalculator<
        MatexPivotPointsCalculatorCore,
        MatexPivotPointsCoreState,
        MatexPivotPointsResult>
    with
        MatexPivotPointsCoreMixin<MatexPivotPointsCalculatorCore, MatexPivotPointsCoreState,
            MatexPivotPointsResult> {
  MatexPivotPointsCalculatorCore({
    MatexPivotPointsCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialPivotPointsState,
          validators: validators ?? pivotPointsValidators,
        );

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
  MatexPivotPointsCoreState initialState,
  List<MatexStateValidator> validators,
}) =>
    MatexPivotPointsCalculatorCore(
      initialState: initialState,
      validators: validators,
    );
