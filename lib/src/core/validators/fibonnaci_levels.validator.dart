import 'package:matex_dart/matex_dart.dart';

final List<StateValidator> fibonacciLevelsValidators = [
  (BaseState state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;

    return lowPrice != null && highPrice != null;
  },
  (BaseState state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;
    var isValid = lowPrice > 0 && highPrice > 0;

    if (isValid) {
      isValid = highPrice >= lowPrice;
    }

    return isValid;
  },
];
