import 'package:matex_dart/matex_dart.dart';

List<MatexStateValidator> dividendYieldValidators = [
  (MatexBaseCoreState state) {
    return state.sharePrice != null &&
        state.totalDividend != null &&
        state.dividendPaymentFrequency != null;
  },
  (MatexBaseCoreState state) {
    return state.sharePrice! > 0 && state.totalDividend! > 0;
  },
];
