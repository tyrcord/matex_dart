import 'package:matex_dart/matex_dart.dart' hide positionSize;

class StopLossTakeProfitState extends BaseState {
  const StopLossTakeProfitState({
    double baseExchangeRate,
    double tradingPairExchangeRate,
    double positionSize,
    int pipPrecision,
    LotDescriptors lotDescriptors,
    bool baseListedSecond,
    double takeProfitPips,
    double takeProfitPrice,
    double takeProfitAmount,
    double entryPrice,
    Position position,
    double stopLossPips,
    double stopLossPrice,
    double stopLossAmount,
  }) : super(
          baseExchangeRate: baseExchangeRate,
          tradingPairExchangeRate: tradingPairExchangeRate,
          positionSize: positionSize,
          pipPrecision: pipPrecision,
          lotDescriptors: lotDescriptors,
          baseListedSecond: baseListedSecond,
          takeProfitPips: takeProfitPips,
          takeProfitPrice: takeProfitPrice,
          takeProfitAmount: takeProfitAmount,
          entryPrice: entryPrice,
          position: position,
          stopLossPips: stopLossPips,
          stopLossPrice: stopLossPrice,
          stopLossAmount: stopLossAmount,
        );

  StopLossTakeProfitState copyWithState(BaseState state) {
    return StopLossTakeProfitState(
      baseExchangeRate: state.baseExchangeRate ?? baseExchangeRate,
      tradingPairExchangeRate:
          state.tradingPairExchangeRate ?? tradingPairExchangeRate,
      positionSize: state.positionSize ?? positionSize,
      pipPrecision: state.pipPrecision ?? pipPrecision,
      lotDescriptors: state.lotDescriptors ?? lotDescriptors,
      baseListedSecond: state.baseListedSecond ?? baseListedSecond,
      entryPrice: state.entryPrice ?? entryPrice,
      position: state.position ?? position,
      takeProfitPips: state.takeProfitPips ?? takeProfitPips,
      takeProfitPrice: state.takeProfitPrice ?? takeProfitPrice,
      takeProfitAmount: state.takeProfitAmount ?? takeProfitAmount,
      stopLossPips: state.stopLossPips ?? stopLossPips,
      stopLossPrice: state.stopLossPrice ?? stopLossPrice,
      stopLossAmount: state.stopLossAmount ?? stopLossAmount,
    );
  }

  StopLossTakeProfitState clone() {
    return StopLossTakeProfitState(
      baseExchangeRate: baseExchangeRate,
      tradingPairExchangeRate: tradingPairExchangeRate,
      positionSize: positionSize,
      pipPrecision: pipPrecision,
      lotDescriptors: lotDescriptors,
      baseListedSecond: baseListedSecond,
      takeProfitPips: takeProfitPips,
      takeProfitPrice: takeProfitPrice,
      takeProfitAmount: takeProfitAmount,
      entryPrice: entryPrice,
      position: position,
      stopLossPips: stopLossPips,
      stopLossPrice: stopLossPrice,
      stopLossAmount: stopLossAmount,
    );
  }

  TakeProfitState toTakeProfitState() {
    return TakeProfitState(
      baseExchangeRate: baseExchangeRate,
      tradingPairExchangeRate: tradingPairExchangeRate,
      positionSize: positionSize,
      pipPrecision: pipPrecision,
      lotDescriptors: lotDescriptors,
      baseListedSecond: baseListedSecond,
      takeProfitPips: takeProfitPips,
      takeProfitPrice: takeProfitPrice,
      takeProfitAmount: takeProfitAmount,
      entryPrice: entryPrice,
      position: position,
    );
  }

  StopLossState toStopLossState() {
    return StopLossState(
      baseExchangeRate: baseExchangeRate,
      tradingPairExchangeRate: tradingPairExchangeRate,
      positionSize: positionSize,
      pipPrecision: pipPrecision,
      lotDescriptors: lotDescriptors,
      baseListedSecond: baseListedSecond,
      entryPrice: entryPrice,
      position: position,
      stopLossPips: stopLossPips,
      stopLossPrice: stopLossPrice,
      stopLossAmount: stopLossAmount,
    );
  }
}

const kInitialStopLossTakeProfitState = StopLossTakeProfitState(
  baseExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 0.0,
  tradingPairExchangeRate: 0.0,
  entryPrice: 0.0,
  position: Position.Long,
  takeProfitAmount: 0.0,
  takeProfitPips: 0.0,
  takeProfitPrice: 0.0,
  stopLossAmount: 0.0,
  stopLossPips: 0.0,
  stopLossPrice: 0.0,
);
