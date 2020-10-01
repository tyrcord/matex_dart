import 'package:matex_dart/matex_dart.dart';

class PivotPointsCalculator extends BaseCalculator<PivotPointsCalculator,
        PivotPointsState, PivotPointsResult>
    with
        PivotPointsMixin<PivotPointsCalculator, PivotPointsState,
            PivotPointsResult> {
  PivotPointsCalculator({
    PivotPointsState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialPivotPointsState,
          validators: validators ?? pivotPointsValidators,
        );

  @override
  PivotPointsResult value() {
    if (this.result != null) {
      return this.result;
    }

    final method = validState.method;
    final closePrice = validState.closePrice;
    final highPrice = validState.highPrice;
    final lowPrice = validState.lowPrice;
    PivotPointsResult result;

    switch (method) {
      case PivotPointsMethods.Camarilla:
        result = pivotPointsCamarilla(highPrice, lowPrice, closePrice);
        break;
      case PivotPointsMethods.DeMark:
        final openPrice = validState.openPrice;
        result = pivotPointsDeMark(highPrice, lowPrice, closePrice, openPrice);
        break;
      case PivotPointsMethods.Fibonacci:
        result = pivotPointsFibonacci(highPrice, lowPrice, closePrice);
        break;
      case PivotPointsMethods.Woodie:
        result = pivotPointsWoodie(highPrice, lowPrice, closePrice);
        break;
      default:
        result = pivotPointsStandard(highPrice, lowPrice, closePrice);
        break;
    }

    return (this.result = result);
  }
}

PivotPointsCalculator pivotPoints({
  PivotPointsState initialState,
  List<StateValidator> validators,
}) =>
    PivotPointsCalculator(
      initialState: initialState,
      validators: validators,
    );
