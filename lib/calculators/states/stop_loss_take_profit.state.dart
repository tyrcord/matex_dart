import 'package:matex_dart/matex_dart.dart' hide positionSize;

class MatexStopLossTakeProfitState extends MatexStopLossTakeProfitCoreState {
  @override
  final String accountCode;
  @override
  final String baseCode;
  @override
  final String counterCode;

  const MatexStopLossTakeProfitState({
    double baseExchangeRate,
    double tradingPairExchangeRate,
    double positionSize,
    int pipPrecision,
    MatexLotDescriptors lotDescriptors,
    bool baseListedSecond,
    this.accountCode,
    this.baseCode,
    this.counterCode,
    double entryPrice,
    MatexPosition position,
    double stopLossPips,
    double stopLossPrice,
    double stopLossAmount,
    double takeProfitPips,
    double takeProfitPrice,
    double takeProfitAmount,
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

  @override
  MatexStopLossTakeProfitState copyWithState(MatexBaseCoreState state) {
    return MatexStopLossTakeProfitState(
      accountCode: state.accountCode ?? accountCode,
      baseCode: state.baseCode ?? baseCode,
      counterCode: state.counterCode ?? counterCode,
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

  @override
  MatexStopLossTakeProfitState clone() {
    return MatexStopLossTakeProfitState(
      accountCode: accountCode,
      baseCode: baseCode,
      counterCode: counterCode,
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
}

const MatexStopLossTakeProfitState kInitialMatexStopLossTakeProfitState =
    MatexStopLossTakeProfitState(
  accountCode: null,
  baseCode: null,
  counterCode: null,
  baseExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 0.0,
  tradingPairExchangeRate: 0.0,
  entryPrice: 0.0,
  position: MatexPosition.Long,
  takeProfitAmount: 0.0,
  takeProfitPips: 0.0,
  takeProfitPrice: 0.0,
  stopLossAmount: 0.0,
  stopLossPips: 0.0,
  stopLossPrice: 0.0,
);
