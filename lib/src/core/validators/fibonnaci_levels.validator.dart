import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<BaseState>> fibonacciLevelsValidators = [
  (BaseState state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;
    bool isValid =
        lowPrice != null && lowPrice > 0 && highPrice != null && highPrice > 0;

    if (isValid) {
      isValid = highPrice >= lowPrice;
    }

    return isValid;
  },
];
