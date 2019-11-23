import 'package:matex_dart/src/core/enums/enums.dart';
import 'package:matex_dart/src/core/types/types.dart';

final List<StateValidator> fibonacciLevelsValidators = [
  (Map<CalculatorKey, dynamic> state) {
    final lowPrice = state[CalculatorKey.LowPrice] as num;
    final highPrice = state[CalculatorKey.HighPrice] as num;
    bool isValid = lowPrice > 0 && highPrice > 0;

    if (isValid) {
      isValid = highPrice >= lowPrice;
    }

    return isValid;
  },
];
