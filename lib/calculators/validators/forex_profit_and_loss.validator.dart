import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> matexForexProfitAndLossValidators = [
  (MatexBaseCoreState state) =>
      state.baseCode != null &&
      state.counterCode != null &&
      state.accountCode != null,
  ...profitAndLossValidators,
];
