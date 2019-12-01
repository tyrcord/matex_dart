import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<PivotPointsState>> pivotPointsValidators = [
  (PivotPointsState state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;
    final closePrice = state.closePrice;
    bool isValid = lowPrice > 0 && highPrice > 0 && closePrice > 0;

    if (isValid) {
      isValid = highPrice >= lowPrice &&
          closePrice >= lowPrice &&
          closePrice <= highPrice;
    }

    return isValid;
  },
  (PivotPointsState state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;
    final openPrice = state.openPrice;
    final method = state.method;
    bool isValid = true;

    if (method == PivotPointsMethods.DeMark) {
      isValid = openPrice > 0;

      if (isValid) {
        isValid = openPrice >= lowPrice && openPrice <= highPrice;
      }
    }

    return isValid;
  },
];
