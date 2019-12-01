import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<StopLossTakeProfitState>>
    stopLossTakeProfitValidators = [
  (StopLossTakeProfitState state) => state.positionSize > 0,
  (StopLossTakeProfitState state) => state.tradingPairExchangeRate > 0,
  (StopLossTakeProfitState state) => state.entryPrice > 0,
  (StopLossTakeProfitState state) => state.tradingPairExchangeRate > 0,
  (StopLossTakeProfitState state) {
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
