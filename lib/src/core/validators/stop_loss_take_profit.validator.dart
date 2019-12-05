import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<BaseState>> stopLossTakeProfitValidators = [
  ...pipValueValidators,
  (BaseState state) => state.entryPrice != null && state.entryPrice > 0,
  (BaseState state) {
    final stopLossAmount = state.stopLossAmount;
    final stopLossPrice = state.stopLossPrice;
    final stopLossPips = state.stopLossPips;
    final takeProfitAmount = state.takeProfitAmount;
    final takeProfitPrice = state.takeProfitPrice;
    final takeProfitPips = state.takeProfitPips;

    return (stopLossAmount > 0 ||
        stopLossPrice > 0 ||
        stopLossPips > 0 ||
        (takeProfitAmount > 0 || takeProfitPrice > 0 || takeProfitPips > 0));
  },
];
