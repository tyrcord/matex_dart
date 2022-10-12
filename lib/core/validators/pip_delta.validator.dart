import 'package:matex_dart/matex_dart.dart';

List<MatexStateValidator> pipDeltaValidators = [
  (MatexBaseCoreState state) {
    return state.priceA != null &&
        state.priceB != null &&
        state.pipPrecision != null;
  },
  (MatexBaseCoreState state) {
    final priceA = state.priceA!;
    final priceB = state.priceB!;

    return priceA >= 0 && priceB >= 0;
  },
  (MatexBaseCoreState state) {
    final priceA = state.priceA!;
    final priceB = state.priceB!;

    return priceA > 0 || priceB > 0;
  },
];
