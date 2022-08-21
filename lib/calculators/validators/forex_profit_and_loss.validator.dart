import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> matexForexProfitAndLossValidators = [
  (MatexBaseCoreState state) =>
      state.baseCode != null &&
      state.baseCode!.isNotEmpty &&
      state.counterCode != null &&
      state.counterCode!.isNotEmpty &&
      state.accountCode != null &&
      state.accountCode!.isNotEmpty,
  ...profitAndLossValidators,
];
