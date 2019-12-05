import 'package:matex_dart/matex_dart.dart' hide positionSize;

class PositionSizeState extends PipValueState {
  final double accountSize;
  final double entryPrice;
  final double amountAtRisk;
  final double riskRatio;
  final double stopLossPips;
  final double stopLossPrice;

  const PositionSizeState({
    double baseExchangeRate,
    double tradingPairExchangeRate,
    double positionSize,
    int pipPrecision,
    LotDescriptors lotDescriptors,
    bool baseListedSecond,
    this.accountSize,
    this.entryPrice,
    this.amountAtRisk,
    this.riskRatio,
    this.stopLossPips,
    this.stopLossPrice,
  }) : super(
          baseExchangeRate: baseExchangeRate,
          tradingPairExchangeRate: tradingPairExchangeRate,
          positionSize: positionSize,
          pipPrecision: pipPrecision,
          lotDescriptors: lotDescriptors,
          baseListedSecond: baseListedSecond,
        );

  PositionSizeState copyWithState(BaseState state) {
    return PositionSizeState(
      baseExchangeRate: state.baseExchangeRate ?? baseExchangeRate,
      tradingPairExchangeRate:
          state.tradingPairExchangeRate ?? tradingPairExchangeRate,
      positionSize: state.positionSize ?? positionSize,
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
