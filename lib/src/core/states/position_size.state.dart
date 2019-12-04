import 'package:matex_dart/matex_dart.dart';

class PositionSizeState extends BaseState {
  const PositionSizeState({
    double baseExchangeRate,
    double tradingPairExchangeRate,
    double positionSize,
    int pipPrecision,
    LotDescriptors lotDescriptors,
    bool baseListedSecond,
    double accountSize,
    double entryPrice,
    double amountAtRisk,
    double riskRatio,
    double stopLossPips,
    double stopLossPrice,
  }) : super(
          baseExchangeRate: baseExchangeRate,
          tradingPairExchangeRate: tradingPairExchangeRate,
          positionSize: positionSize,
          pipPrecision: pipPrecision,
          lotDescriptors: lotDescriptors,
          baseListedSecond: baseListedSecond,
          accountSize: accountSize,
          entryPrice: entryPrice,
          amountAtRisk: amountAtRisk,
          riskRatio: riskRatio,
          stopLossPips: stopLossPips,
          stopLossPrice: stopLossPrice,
        );

  PositionSizeState copyWithState(BaseState state) {
    return PositionSizeState(
      baseExchangeRate: state.baseExchangeRate ?? baseExchangeRate,
      tradingPairExchangeRate:
          state.tradingPairExchangeRate ?? tradingPairExchangeRate,
      positionSize: state.positionSize ?? this.positionSize,
      pipPrecision: state.pipPrecision ?? pipPrecision,
      lotDescriptors: state.lotDescriptors ?? lotDescriptors,
      baseListedSecond: state.baseListedSecond ?? baseListedSecond,
      accountSize: state.accountSize ?? accountSize,
      entryPrice: state.entryPrice ?? entryPrice,
      amountAtRisk: state.amountAtRisk ?? amountAtRisk,
      riskRatio: state.riskRatio ?? riskRatio,
      stopLossPips: state.stopLossPips ?? stopLossPips,
      stopLossPrice: state.stopLossPrice ?? stopLossPrice,
    );
  }

  PositionSizeState clone() {
    return PositionSizeState(
      baseExchangeRate: baseExchangeRate,
      tradingPairExchangeRate: tradingPairExchangeRate,
      positionSize: this.positionSize,
      pipPrecision: pipPrecision,
      lotDescriptors: lotDescriptors,
      baseListedSecond: baseListedSecond,
      accountSize: accountSize,
      entryPrice: entryPrice,
      amountAtRisk: amountAtRisk,
      riskRatio: riskRatio,
      stopLossPips: stopLossPips,
      stopLossPrice: stopLossPrice,
    );
  }
}

const kInitialPositionSizeState = PositionSizeState(
  baseExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 1.0,
  tradingPairExchangeRate: 0.0,
  accountSize: 0.0,
  amountAtRisk: 0.0,
  entryPrice: 0.0,
  riskRatio: 0.0,
  stopLossPips: 0.0,
  stopLossPrice: 0.0,
);
