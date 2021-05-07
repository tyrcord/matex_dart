import 'package:matex_dart/matex_dart.dart';

List<MatexStateValidator> dividendPayoutRatioValidators = [
  (MatexBaseCoreState state) {
    return state.netIncome != null && state.totalDividend != null;
  },
  (MatexBaseCoreState state) {
    return state.netIncome! > 0 && state.totalDividend! > 0;
  },
];
