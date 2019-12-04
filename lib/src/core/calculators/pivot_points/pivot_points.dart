import 'package:matex_dart/matex_dart.dart';

class PivotPointsCalculator
    extends BaseCalculator<PivotPointsState, PivotPointsResult> {
  PivotPointsCalculator({
    PivotPointsState initialState,
    List<StateValidator<PivotPointsState>> validators,
  }) : super(
          initialState: initialState ?? kInitialPivotPointsState,
          validators: validators ?? pivotPointsValidators,
        );

  PivotPointsCalculator closePrice(double closePrice) {
    final sanitizedValue = sanitizeDouble(closePrice);
    return patchState(PivotPointsState(closePrice: sanitizedValue));
  }

  PivotPointsCalculator highPrice(double highPrice) {
    final sanitizedValue = sanitizeDouble(highPrice);
    return patchState(PivotPointsState(highPrice: sanitizedValue));
  }

  PivotPointsCalculator lowPrice(double lowPrice) {
    final sanitizedValue = sanitizeDouble(lowPrice);
    return patchState(PivotPointsState(lowPrice: sanitizedValue));
  }

  PivotPointsCalculator method(PivotPointsMethods method) {
    return patchState(PivotPointsState(method: method));
  }

  PivotPointsCalculator openPrice(double openPrice) {
    final sanitizedValue = sanitizeDouble(openPrice);
    return patchState(PivotPointsState(openPrice: sanitizedValue));
  }

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

PivotPointsCalculator pivotPoints() => PivotPointsCalculator();
