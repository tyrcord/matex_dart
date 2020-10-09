import 'package:equatable/equatable.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexBaseCoreState extends Equatable {
  final double customPrice;
  final double highPrice;
  final double lowPrice;
  final int precision;
  final MatexTrend trend;
  final List<double> extensionLevels;
  final List<double> retracementLevels;
  final double baseExchangeRate;
  final double tradingPairExchangeRate;
  final double positionSize;
  final int pipPrecision;
  final MatexLotDescriptors lotDescriptors;
  final bool baseListedSecond;
  final double leverage;
  final double closePrice;
  final double openPrice;
  final MatexPivotPointsMethods method;
  final double accountSize;
  final double entryPrice;
  final double amountAtRisk;
  final double riskRatio;
  final MatexPosition position;
  final double stopLossPips;
  final double stopLossPrice;
  final double stopLossAmount;
  final double takeProfitPips;
  final double takeProfitPrice;
  final double takeProfitAmount;
  final String accountCode;
  final String baseCode;
  final String counterCode;

  const MatexBaseCoreState({
    this.accountCode,
    this.baseCode,
    this.counterCode,
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

  MatexBaseCoreState clone() {
    return MatexBaseCoreState(
      accountCode: accountCode,
      baseCode: baseCode,
      counterCode: counterCode,
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

  MatexBaseCoreState copyWithState(MatexBaseCoreState state) {
    return MatexBaseCoreState(
      accountCode: state.accountCode ?? accountCode,
      baseCode: state.baseCode ?? baseCode,
      counterCode: state.counterCode ?? counterCode,
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
      takeProfitPrice: state.takeProfitPrice ?? takeProfitPrice,
      takeProfitAmount: state.takeProfitAmount ?? takeProfitAmount,
    );
  }

  MatexBaseCoreState copyWithOmittedProperties(
    List<String> properties,
    MatexBaseCoreState initialState,
  ) {
    return MatexBaseCoreState(
      accountCode: properties.contains(MatexCoreStateProperty.accountCode)
          ? initialState.accountCode
          : accountCode,
      baseCode: properties.contains(MatexCoreStateProperty.baseCode)
          ? initialState.baseCode
          : baseCode,
      counterCode: properties.contains(MatexCoreStateProperty.counterCode)
          ? initialState.counterCode
          : counterCode,
      customPrice: properties.contains(MatexCoreStateProperty.customPrice)
          ? initialState.customPrice
          : customPrice,
      highPrice: properties.contains(MatexCoreStateProperty.highPrice)
          ? initialState.highPrice
          : highPrice,
      lowPrice: properties.contains(MatexCoreStateProperty.lowPrice)
          ? initialState.lowPrice
          : lowPrice,
      precision: properties.contains(MatexCoreStateProperty.precision)
          ? initialState.precision
          : precision,
      trend: properties.contains(MatexCoreStateProperty.trend)
          ? initialState.trend
          : trend,
      extensionLevels:
          properties.contains(MatexCoreStateProperty.extensionLevels)
              ? initialState.extensionLevels
              : extensionLevels,
      retracementLevels:
          properties.contains(MatexCoreStateProperty.retracementLevels)
              ? initialState.retracementLevels
              : retracementLevels,
      baseExchangeRate:
          properties.contains(MatexCoreStateProperty.baseExchangeRate)
              ? initialState.baseExchangeRate
              : baseExchangeRate,
      tradingPairExchangeRate:
          properties.contains(MatexCoreStateProperty.tradingPairExchangeRate)
              ? initialState.tradingPairExchangeRate
              : tradingPairExchangeRate,
      positionSize: properties.contains(MatexCoreStateProperty.positionSize)
          ? initialState.positionSize
          : positionSize,
      pipPrecision: properties.contains(MatexCoreStateProperty.pipPrecision)
          ? initialState.pipPrecision
          : pipPrecision,
      lotDescriptors: properties.contains(MatexCoreStateProperty.lotDescriptors)
          ? initialState.lotDescriptors
          : lotDescriptors,
      baseListedSecond:
          properties.contains(MatexCoreStateProperty.baseListedSecond)
              ? initialState.baseListedSecond
              : baseListedSecond,
      leverage: properties.contains(MatexCoreStateProperty.leverage)
          ? initialState.leverage
          : leverage,
      closePrice: properties.contains(MatexCoreStateProperty.closePrice)
          ? initialState.closePrice
          : closePrice,
      openPrice: properties.contains(MatexCoreStateProperty.openPrice)
          ? initialState.openPrice
          : openPrice,
      method: properties.contains(MatexCoreStateProperty.method)
          ? initialState.method
          : method,
      accountSize: properties.contains(MatexCoreStateProperty.accountSize)
          ? initialState.accountSize
          : accountSize,
      amountAtRisk: properties.contains(MatexCoreStateProperty.amountAtRisk)
          ? initialState.amountAtRisk
          : amountAtRisk,
      riskRatio: properties.contains(MatexCoreStateProperty.riskRatio)
          ? initialState.riskRatio
          : riskRatio,
      entryPrice: properties.contains(MatexCoreStateProperty.entryPrice)
          ? initialState.entryPrice
          : entryPrice,
      position: properties.contains(MatexCoreStateProperty.position)
          ? initialState.position
          : position,
      stopLossPips: properties.contains(MatexCoreStateProperty.stopLossPips)
          ? initialState.stopLossPips
          : stopLossPips,
      stopLossPrice: properties.contains(MatexCoreStateProperty.stopLossPrice)
          ? initialState.stopLossPrice
          : stopLossPrice,
      stopLossAmount: properties.contains(MatexCoreStateProperty.stopLossAmount)
          ? initialState.stopLossAmount
          : stopLossAmount,
      takeProfitPips: properties.contains(MatexCoreStateProperty.takeProfitPips)
          ? initialState.takeProfitPips
          : takeProfitPips,
      takeProfitPrice:
          properties.contains(MatexCoreStateProperty.takeProfitPrice)
              ? initialState.takeProfitPrice
              : takeProfitPrice,
      takeProfitAmount:
          properties.contains(MatexCoreStateProperty.takeProfitAmount)
              ? initialState.takeProfitAmount
              : takeProfitAmount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountCode': accountCode,
      'baseCode': baseCode,
      'counterCode': counterCode,
      'customPrice': customPrice,
      'highPrice': highPrice,
      'lowPrice': lowPrice,
      'precision': precision,
      'trend': trend,
      'extensionLevels': extensionLevels,
      'retracementLevels': retracementLevels,
      'baseExchangeRate': baseExchangeRate,
      'tradingPairExchangeRate': tradingPairExchangeRate,
      'positionSize': positionSize,
      'pipPrecision': pipPrecision,
      'lotDescriptors': lotDescriptors.toJson(),
      'baseListedSecond': baseListedSecond,
      'leverage': leverage,
      'closePrice': closePrice,
      'openPrice': openPrice,
      'method': method,
      'accountSize': accountSize,
      'amountAtRisk': amountAtRisk,
      'riskRatio': riskRatio,
      'entryPrice': entryPrice,
      'position': position,
      'stopLossPips': stopLossPips,
      'stopLossPrice': stopLossPrice,
      'stopLossAmount': stopLossAmount,
      'takeProfitPips': takeProfitPips,
      'takeProfitPrice': takeProfitPrice,
      'takeProfitAmount': takeProfitAmount,
    };
  }

  factory MatexBaseCoreState.fromJson(dynamic json) {
    var lotDescriptors = json['lotDescriptors'];

    return MatexBaseCoreState(
      accountCode: json['accountCode'] as String,
      baseCode: json['baseCode'] as String,
      counterCode: json['counterCode'] as String,
      customPrice: json['customPrice'] as double,
      highPrice: json['highPrice'] as double,
      lowPrice: json['lowPrice'] as double,
      precision: json['precision'] as int,
      trend: json['trend'] as MatexTrend,
      extensionLevels: json['extensionLevels'] as List<double>,
      retracementLevels: json['retracementLevels'] as List<double>,
      baseExchangeRate: json['baseExchangeRate'] as double,
      tradingPairExchangeRate: json['tradingPairExchangeRate'] as double,
      positionSize: json['positionSize'] as double,
      pipPrecision: json['pipPrecision'] as int,
      lotDescriptors: lotDescriptors != null
          ? MatexLotDescriptors.fromJson(json['lotDescriptors'])
          : null,
      baseListedSecond: json['baseListedSecond'] as bool,
      leverage: json['leverage'] as double,
      closePrice: json['closePrice'] as double,
      openPrice: json['openPrice'] as double,
      method: json['method'] as MatexPivotPointsMethods,
      accountSize: json['accountSize'] as double,
      amountAtRisk: json['amountAtRisk'] as double,
      riskRatio: json['riskRatio'] as double,
      entryPrice: json['entryPrice'] as double,
      position: json['position'] as MatexPosition,
      stopLossPips: json['stopLossPips'] as double,
      stopLossPrice: json['stopLossPrice'] as double,
      stopLossAmount: json['stopLossAmount'] as double,
      takeProfitPips: json['takeProfitPips'] as double,
      takeProfitPrice: json['takeProfitPrice'] as double,
      takeProfitAmount: json['takeProfitAmount'] as double,
    );
  }

  @override
  List<Object> get props => [
        accountCode,
        baseCode,
        counterCode,
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
