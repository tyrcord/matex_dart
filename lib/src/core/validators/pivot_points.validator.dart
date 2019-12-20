import 'package:matex_dart/matex_dart.dart';

final List<StateValidator> pivotPointsValidators = [
  (BaseState state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;
    final closePrice = state.closePrice;
    return lowPrice != null && highPrice != null && closePrice != null;
  },
  (BaseState state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;
    final closePrice = state.closePrice;
    var isValid = lowPrice > 0 && highPrice > 0 && closePrice > 0;

    if (isValid) {
      isValid = highPrice >= lowPrice &&
          closePrice >= lowPrice &&
          closePrice <= highPrice;
    }

    return isValid;
  },
  (BaseState state) {
    final lowPrice = state.lowPrice;
    final highPrice = state.highPrice;
    final openPrice = state.openPrice;
    final method = state.method;
    var isValid = true;

    if (method == PivotPointsMethods.DeMark && openPrice != null) {
      isValid = openPrice > 0;

      if (isValid) {
        isValid = openPrice >= lowPrice && openPrice <= highPrice;
      }
    }

    return isValid;
  },
];
