import 'package:equatable/equatable.dart';
import 'package:matex_dart/matex_dart.dart';

class BaseState extends Equatable {
  final double customPrice;
  final double highPrice;
  final double lowPrice;
  final int precision;
  final Trend trend;
  final List<double> extensionLevels;
  final List<double> retracementLevels;
  final double baseExchangeRate;
  final double tradingPairExchangeRate;
  final double positionSize;
  final int pipPrecision;
  final LotDescriptors lotDescriptors;
  final bool baseListedSecond;
  final double leverage;
  final double closePrice;
  final double openPrice;
  final PivotPointsMethods method;
  final double accountSize;
  final double entryPrice;
  final double amountAtRisk;
  final double riskRatio;
  final Position position;
  final double stopLossPips;
  final double stopLossPrice;
  final double stopLossAmount;
  final double takeProfitPips;
  final double takeProfitPrice;
  final double takeProfitAmount;

  const BaseState({
    this.customPrice,
    this.highPrice,
    this.lowPrice,
    this.precision,
    this.trend,
    this.extensionLevels,
    this.retracementLevels,
    this.baseExchangeRate,
    this.tradingPairExchangeRate,
    this.positionSize,
    this.pipPrecision,
    this.lotDescriptors,
    this.baseListedSecond,
    this.leverage,
    this.closePrice,
    this.openPrice,
    this.method,
    this.accountSize,
    this.entryPrice,
    this.amountAtRisk,
    this.riskRatio,
    this.stopLossPips,
    this.stopLossPrice,
    this.position,
    this.stopLossAmount,
    this.takeProfitPips,
    this.takeProfitPrice,
    this.takeProfitAmount,
  });

  BaseState clone() {
    return BaseState(
      customPrice: customPrice,
      highPrice: highPrice,
      lowPrice: lowPrice,
      precision: precision,
      extensionLevels: extensionLevels,
      baseExchangeRate: baseExchangeRate,
      retracementLevels: retracementLevels,
      trend: trend,
      tradingPairExchangeRate: tradingPairExchangeRate,
      positionSize: positionSize,
      pipPrecision: pipPrecision,
      lotDescriptors: lotDescriptors,
      baseListedSecond: baseListedSecond,
      leverage: leverage,
      closePrice: closePrice,
      openPrice: openPrice,
      method: method,
      accountSize: accountSize,
      amountAtRisk: amountAtRisk,
      riskRatio: riskRatio,
      entryPrice: entryPrice,
      position: position,
      stopLossPips: stopLossPips,
      stopLossPrice: stopLossPrice,
      stopLossAmount: stopLossAmount,
      takeProfitPips: takeProfitPips,
      takeProfitPrice: takeProfitPrice,
      takeProfitAmount: takeProfitAmount,
    );
  }

  BaseState copyWithState(BaseState state) {
    return BaseState(
      customPrice: state.customPrice ?? customPrice,
      highPrice: state.highPrice ?? highPrice,
      lowPrice: state.lowPrice ?? lowPrice,
      precision: state.precision ?? precision,
      trend: state.trend ?? trend,
      extensionLevels: state.extensionLevels ?? extensionLevels,
      retracementLevels: state.retracementLevels ?? retracementLevels,
      baseExchangeRate: state.baseExchangeRate ?? baseExchangeRate,
      tradingPairExchangeRate:
          state.tradingPairExchangeRate ?? tradingPairExchangeRate,
      positionSize: state.positionSize ?? positionSize,
      pipPrecision: state.pipPrecision ?? pipPrecision,
      lotDescriptors: state.lotDescriptors ?? lotDescriptors,
      baseListedSecond: state.baseListedSecond ?? baseListedSecond,
      leverage: state.leverage ?? leverage,
      closePrice: state.closePrice ?? closePrice,
      openPrice: state.openPrice ?? openPrice,
      method: state.method ?? method,
      accountSize: state.accountSize ?? accountSize,
      amountAtRisk: state.amountAtRisk ?? amountAtRisk,
      riskRatio: state.riskRatio ?? riskRatio,
      entryPrice: state.entryPrice ?? entryPrice,
      position: state.position ?? position,
      stopLossPips: state.stopLossPips ?? stopLossPips,
      stopLossPrice: state.stopLossPrice ?? stopLossPrice,
      stopLossAmount: state.stopLossAmount ?? stopLossAmount,
      takeProfitPips: state.takeProfitPips ?? takeProfitPips,
      takeProfitPrice: state.stopLossAmount ?? takeProfitPrice,
      takeProfitAmount: state.takeProfitAmount ?? takeProfitAmount,
    );
  }

  @override
  List<Object> get props => [
        customPrice,
        highPrice,
        lowPrice,
        precision,
        trend,
        extensionLevels,
        retracementLevels,
        baseExchangeRate,
        tradingPairExchangeRate,
        positionSize,
        pipPrecision,
        lotDescriptors,
        baseListedSecond,
        leverage,
        closePrice,
        openPrice,
        method,
        accountSize,
        entryPrice,
        amountAtRisk,
        riskRatio,
        stopLossPips,
        stopLossPrice,
        position,
        stopLossAmount,
        takeProfitPips,
        takeProfitPrice,
        takeProfitAmount,
      ];
}
