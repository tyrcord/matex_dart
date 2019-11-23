import 'package:matex_dart/src/core/enums/enums.dart';
import 'package:matex_dart/src/core/types/types.dart';

final List<StateValidator> pivotPointsValidators = [
  (Map<CalculatorKey, dynamic> state) {
    final lowPrice = state[CalculatorKey.LowPrice] as num;
    final highPrice = state[CalculatorKey.LowPrice] as num;
    final closePrice = state[CalculatorKey.LowPrice] as num;
    bool isValid = lowPrice > 0 && highPrice > 0 && closePrice > 0;

    if (isValid) {
      isValid = highPrice >= lowPrice &&
          closePrice >= lowPrice &&
          closePrice <= highPrice;
    }

    return isValid;
  },
  (Map<CalculatorKey, dynamic> state) {
    final lowPrice = state[CalculatorKey.LowPrice] as num;
    final highPrice = state[CalculatorKey.LowPrice] as num;
    final openPrice = state[CalculatorKey.OpenPrice] as num;
    final method = state[CalculatorKey.PivotPointsMethod] as PivotPointsMethods;
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
