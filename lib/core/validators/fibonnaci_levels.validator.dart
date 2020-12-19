import 'package:matex_dart/matex_dart.dart';

List<MatexStateValidator> fibonacciLevelsValidators = [
  (MatexBaseCoreState state) {
    return state.lowPrice != null && state.highPrice != null;
  },
  (MatexBaseCoreState state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;
    var isValid = lowPrice > 0 && highPrice > 0;

    if (isValid) {
      isValid = highPrice > lowPrice;
    }

    return isValid;
  },
];
