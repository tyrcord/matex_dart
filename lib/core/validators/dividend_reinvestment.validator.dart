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
        state.yearsToGrow! <= 100 &&
        state.sharePrice! > 0;
  },
  (MatexBaseCoreState state) {
    if (state.taxRate != null) {
      return state.taxRate! >= 0 && state.taxRate! <= 100;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    if (state.annualSharePriceIncrease != null) {
      return state.annualSharePriceIncrease! >= 0 &&
          state.annualSharePriceIncrease! <= 100;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    if (state.annualDividendIncrease != null) {
      return state.annualDividendIncrease! >= 0 &&
          state.annualDividendIncrease! <= 100;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    if (state.annualContribution != null) {
      return state.annualContribution! >= 0;
    }

    return true;
  },
];
