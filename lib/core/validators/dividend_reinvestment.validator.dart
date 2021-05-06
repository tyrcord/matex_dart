import 'package:matex_dart/matex_dart.dart';

List<MatexStateValidator> dividendReinvestmentValidators = [
  (MatexBaseCoreState state) {
    return state.drip != null &&
        state.dividendPaymentFrequency != null &&
        state.numberOfShares != null &&
        state.dividendYield != null &&
        state.yearsToGrow != null &&
        state.sharePrice != null;
  },
  (MatexBaseCoreState state) {
    return state.numberOfShares! > 0 &&
        state.dividendYield! > 0 &&
        state.yearsToGrow! > 0 &&
        state.sharePrice! > 0;
  },

  //TODO
];
