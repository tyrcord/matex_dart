import 'package:matex_dart/matex_dart.dart' hide positionSize;

class MatexPositionSizeCoreState extends MatexPipValueCoreState {
  @override
  final double accountSize;
  @override
  final double entryPrice;
  @override
  final double amountAtRisk;
  @override
  final double riskRatio;
  @override
  final double stopLossPips;
  @override
  final double stopLossPrice;

  const MatexPositionSizeCoreState({
    double baseExchangeRate,
    double tradingPairExchangeRate,
    double positionSize,
    int pipPrecision,
    MatexLotDescriptors lotDescriptors,
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

  @override
  MatexPositionSizeCoreState copyWithState(MatexBaseCoreState state) {
    return MatexPositionSizeCoreState(
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

  @override
  MatexPositionSizeCoreState clone() {
    return MatexPositionSizeCoreState(
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

const kInitialPositionSizeState = MatexPositionSizeCoreState(
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
