import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> stopLossTakeProfitValidators = [
  ...pipValueValidators,
  (MatexBaseCoreState state) =>
      state.entryPrice != null && state.entryPrice > 0,
  (MatexBaseCoreState state) {
    final stopLossAmount = state.stopLossAmount;
    final stopLossPrice = state.stopLossPrice;
    final stopLossPips = state.stopLossPips;
    final takeProfitAmount = state.takeProfitAmount;
    final takeProfitPrice = state.takeProfitPrice;
    final takeProfitPips = state.takeProfitPips;

    return (((stopLossAmount != null && stopLossAmount > 0) ||
            (stopLossPrice != null && stopLossPrice > 0) ||
            (stopLossPips != null && stopLossPips > 0)) ||
        ((takeProfitAmount != null && takeProfitAmount > 0) ||
            (takeProfitPrice != null && takeProfitPrice > 0) ||
            (takeProfitPips != null && takeProfitPips > 0)));
  },
];
