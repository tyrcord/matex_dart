// ignore_for_file: long-method
// ignore_for_file: code-metrics

import 'package:matex_dart/matex_dart.dart';
import 'package:tstore_dart/tstore_dart.dart';

class MatexBaseCoreState extends TDocument {
  final double? customPrice;
  final double? highPrice;
  final double? lowPrice;
  final int? precision;
  final MatexTrend? trend;
  final List<double>? extensionLevels;
  final List<double>? retracementLevels;
  final double? counterAccountCurrencyPairExchangeRate;
  final double? tradingPairExchangeRate;
  final double? positionSize;
  final int? pipPrecision;
  final MatexLotDescriptors? lotDescriptors;
  final bool? baseListedSecond;
  final double? leverage;
  final double? closePrice;
  final double? openPrice;
  final MatexPivotPointsMethods? method;
  final double? accountSize;
  final double? entryPrice;
  final double? amountAtRisk;
  final double? riskRatio;
  final MatexPosition? position;
  final double? stopLossPips;
  final double? stopLossPrice;
  final double? stopLossAmount;
  final double? takeProfitPips;
  final double? takeProfitPrice;
  final double? takeProfitAmount;
  final String? accountCode;
  final String? baseCode;
  final String? counterCode;
  final int? exchangeRateLastUpdateAt;
  final double? exitPrice;
  final double? entryFeePercentage;
  final double? entryFeeAmount;
  final double? exitFeePercentage;
  final double? exitFeeAmount;
  final double? taxRate;
  final double? priceA;
  final double? priceB;
  final double? fixedCosts;
  final double? exitDiscountAmount;
  final double? exitDiscountPercentage;
  final double? entryFeePercentagePerUnit;
  final double? entryFeeAmountPerUnit;
  final double? exitFeePercentagePerUnit;
  final double? exitFeeAmountPerUnit;
  final MatexFrequency? dividendPaymentFrequency;
  final double? annualSharePriceIncrease;
  final double? annualDividendIncrease;
  final double? annualContribution;
  final double? dividendYield;
  final double? numberOfShares;
  final double? sharePrice;
  final int? yearsToGrow;
  final bool? drip;
  final double? taxExemptAmountPerYear;
  final double? totalDividend;
  final double? netIncome;

  @override
  bool get stringify => true;

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
    this.counterAccountCurrencyPairExchangeRate,
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
    this.exchangeRateLastUpdateAt,
    this.exitPrice,
    this.entryFeePercentage,
    this.entryFeeAmount,
    this.exitFeePercentage,
    this.exitFeeAmount,
    this.taxRate,
    this.priceA,
    this.priceB,
    this.fixedCosts,
    this.exitDiscountAmount,
    this.exitDiscountPercentage,
    this.entryFeePercentagePerUnit,
    this.entryFeeAmountPerUnit,
    this.exitFeePercentagePerUnit,
    this.exitFeeAmountPerUnit,
    this.drip,
    this.dividendPaymentFrequency,
    this.annualSharePriceIncrease,
    this.annualDividendIncrease,
    this.annualContribution,
    this.numberOfShares,
    this.dividendYield,
    this.yearsToGrow,
    this.sharePrice,
    this.taxExemptAmountPerYear,
    this.totalDividend,
    this.netIncome,
  });

  @override
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
      counterAccountCurrencyPairExchangeRate:
          counterAccountCurrencyPairExchangeRate,
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
      exchangeRateLastUpdateAt: exchangeRateLastUpdateAt,
      exitPrice: exitPrice,
      entryFeePercentage: entryFeePercentage,
      entryFeeAmount: entryFeeAmount,
      exitFeePercentage: exitFeePercentage,
      exitFeeAmount: exitFeeAmount,
      taxRate: taxRate,
      priceA: priceA,
      priceB: priceB,
      fixedCosts: fixedCosts,
      exitDiscountAmount: exitDiscountAmount,
      exitDiscountPercentage: exitDiscountPercentage,
      entryFeePercentagePerUnit: entryFeePercentagePerUnit,
      entryFeeAmountPerUnit: entryFeeAmountPerUnit,
      exitFeePercentagePerUnit: exitFeePercentagePerUnit,
      exitFeeAmountPerUnit: exitFeeAmountPerUnit,
      dividendPaymentFrequency: dividendPaymentFrequency,
      annualSharePriceIncrease: annualSharePriceIncrease,
      annualDividendIncrease: annualDividendIncrease,
      annualContribution: annualContribution,
      numberOfShares: numberOfShares,
      dividendYield: dividendYield,
      yearsToGrow: yearsToGrow,
      sharePrice: sharePrice,
      drip: drip,
      taxExemptAmountPerYear: taxExemptAmountPerYear,
      totalDividend: totalDividend,
      netIncome: netIncome,
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
      counterAccountCurrencyPairExchangeRate:
          state.counterAccountCurrencyPairExchangeRate ??
              counterAccountCurrencyPairExchangeRate,
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
      exchangeRateLastUpdateAt:
          state.exchangeRateLastUpdateAt ?? exchangeRateLastUpdateAt,
      exitPrice: state.exitPrice ?? exitPrice,
      entryFeePercentage: state.entryFeePercentage ?? entryFeePercentage,
      entryFeeAmount: state.entryFeeAmount ?? entryFeeAmount,
      exitFeePercentage: state.exitFeePercentage ?? exitFeePercentage,
      exitFeeAmount: state.exitFeeAmount ?? exitFeeAmount,
      taxRate: state.taxRate ?? taxRate,
      priceA: state.priceA ?? priceA,
      priceB: state.priceB ?? priceB,
      fixedCosts: state.fixedCosts ?? fixedCosts,
      exitDiscountAmount: state.exitDiscountAmount ?? exitDiscountAmount,
      exitDiscountPercentage:
          state.exitDiscountPercentage ?? exitDiscountPercentage,
      entryFeePercentagePerUnit:
          state.entryFeePercentagePerUnit ?? entryFeePercentagePerUnit,
      entryFeeAmountPerUnit:
          state.entryFeeAmountPerUnit ?? entryFeeAmountPerUnit,
      exitFeePercentagePerUnit:
          state.exitFeePercentagePerUnit ?? exitFeePercentagePerUnit,
      exitFeeAmountPerUnit: state.exitFeeAmountPerUnit ?? exitFeeAmountPerUnit,
      annualContribution: state.annualContribution ?? annualContribution,
      numberOfShares: state.numberOfShares ?? numberOfShares,
      dividendYield: state.dividendYield ?? dividendYield,
      yearsToGrow: state.yearsToGrow ?? yearsToGrow,
      sharePrice: state.sharePrice ?? sharePrice,
      drip: state.drip ?? drip,
      dividendPaymentFrequency:
          state.dividendPaymentFrequency ?? dividendPaymentFrequency,
      annualSharePriceIncrease:
          state.annualSharePriceIncrease ?? annualSharePriceIncrease,
      annualDividendIncrease:
          state.annualDividendIncrease ?? annualDividendIncrease,
      taxExemptAmountPerYear:
          state.taxExemptAmountPerYear ?? taxExemptAmountPerYear,
      totalDividend: state.totalDividend ?? totalDividend,
      netIncome: state.netIncome ?? netIncome,
    );
  }

  MatexBaseCoreState copyWithOmittedProperties(
    List<String> properties, {
    MatexBaseCoreState? defaultState,
  }) {
    return MatexBaseCoreState(
      accountCode: properties.contains(MatexCoreStateProperty.accountCode)
          ? defaultState?.accountCode
          : accountCode,
      baseCode: properties.contains(MatexCoreStateProperty.baseCode)
          ? defaultState?.baseCode
          : baseCode,
      counterCode: properties.contains(MatexCoreStateProperty.counterCode)
          ? defaultState?.counterCode
          : counterCode,
      customPrice: properties.contains(MatexCoreStateProperty.customPrice)
          ? defaultState?.customPrice
          : customPrice,
      highPrice: properties.contains(MatexCoreStateProperty.highPrice)
          ? defaultState?.highPrice
          : highPrice,
      lowPrice: properties.contains(MatexCoreStateProperty.lowPrice)
          ? defaultState?.lowPrice
          : lowPrice,
      precision: properties.contains(MatexCoreStateProperty.precision)
          ? defaultState?.precision
          : precision,
      trend: properties.contains(MatexCoreStateProperty.trend)
          ? defaultState?.trend
          : trend,
      extensionLevels:
          properties.contains(MatexCoreStateProperty.extensionLevels)
              ? defaultState?.extensionLevels
              : extensionLevels,
      retracementLevels:
          properties.contains(MatexCoreStateProperty.retracementLevels)
              ? defaultState?.retracementLevels
              : retracementLevels,
      counterAccountCurrencyPairExchangeRate: properties.contains(
              MatexCoreStateProperty.counterAccountCurrencyPairExchangeRate)
          ? defaultState?.counterAccountCurrencyPairExchangeRate
          : counterAccountCurrencyPairExchangeRate,
      tradingPairExchangeRate:
          properties.contains(MatexCoreStateProperty.tradingPairExchangeRate)
              ? defaultState?.tradingPairExchangeRate
              : tradingPairExchangeRate,
      positionSize: properties.contains(MatexCoreStateProperty.positionSize)
          ? defaultState?.positionSize
          : positionSize,
      pipPrecision: properties.contains(MatexCoreStateProperty.pipPrecision)
          ? defaultState?.pipPrecision
          : pipPrecision,
      lotDescriptors: properties.contains(MatexCoreStateProperty.lotDescriptors)
          ? defaultState?.lotDescriptors
          : lotDescriptors,
      baseListedSecond:
          properties.contains(MatexCoreStateProperty.baseListedSecond)
              ? defaultState?.baseListedSecond
              : baseListedSecond,
      leverage: properties.contains(MatexCoreStateProperty.leverage)
          ? defaultState?.leverage
          : leverage,
      closePrice: properties.contains(MatexCoreStateProperty.closePrice)
          ? defaultState?.closePrice
          : closePrice,
      openPrice: properties.contains(MatexCoreStateProperty.openPrice)
          ? defaultState?.openPrice
          : openPrice,
      method: properties.contains(MatexCoreStateProperty.method)
          ? defaultState?.method
          : method,
      accountSize: properties.contains(MatexCoreStateProperty.accountSize)
          ? defaultState?.accountSize
          : accountSize,
      amountAtRisk: properties.contains(MatexCoreStateProperty.amountAtRisk)
          ? defaultState?.amountAtRisk
          : amountAtRisk,
      riskRatio: properties.contains(MatexCoreStateProperty.riskRatio)
          ? defaultState?.riskRatio
          : riskRatio,
      entryPrice: properties.contains(MatexCoreStateProperty.entryPrice)
          ? defaultState?.entryPrice
          : entryPrice,
      position: properties.contains(MatexCoreStateProperty.position)
          ? defaultState?.position
          : position,
      stopLossPips: properties.contains(MatexCoreStateProperty.stopLossPips)
          ? defaultState?.stopLossPips
          : stopLossPips,
      stopLossPrice: properties.contains(MatexCoreStateProperty.stopLossPrice)
          ? defaultState?.stopLossPrice
          : stopLossPrice,
      stopLossAmount: properties.contains(MatexCoreStateProperty.stopLossAmount)
          ? defaultState?.stopLossAmount
          : stopLossAmount,
      takeProfitPips: properties.contains(MatexCoreStateProperty.takeProfitPips)
          ? defaultState?.takeProfitPips
          : takeProfitPips,
      takeProfitPrice:
          properties.contains(MatexCoreStateProperty.takeProfitPrice)
              ? defaultState?.takeProfitPrice
              : takeProfitPrice,
      takeProfitAmount:
          properties.contains(MatexCoreStateProperty.takeProfitAmount)
              ? defaultState?.takeProfitAmount
              : takeProfitAmount,
      exchangeRateLastUpdateAt:
          properties.contains(MatexCoreStateProperty.exchangeRateLastUpdateAt)
              ? defaultState?.exchangeRateLastUpdateAt
              : exchangeRateLastUpdateAt,
      exitPrice: properties.contains(MatexCoreStateProperty.exitPrice)
          ? defaultState?.exitPrice
          : exitPrice,
      entryFeePercentage:
          properties.contains(MatexCoreStateProperty.entryFeePercentage)
              ? defaultState?.entryFeePercentage
              : entryFeePercentage,
      entryFeeAmount: properties.contains(MatexCoreStateProperty.entryFeeAmount)
          ? defaultState?.entryFeeAmount
          : entryFeeAmount,
      exitFeePercentage:
          properties.contains(MatexCoreStateProperty.exitFeePercentage)
              ? defaultState?.exitFeePercentage
              : exitFeePercentage,
      exitFeeAmount: properties.contains(MatexCoreStateProperty.exitFeeAmount)
          ? defaultState?.exitFeeAmount
          : exitFeeAmount,
      taxRate: properties.contains(MatexCoreStateProperty.taxRate)
          ? defaultState?.taxRate
          : taxRate,
      priceA: properties.contains(MatexCoreStateProperty.priceA)
          ? defaultState?.priceA
          : priceA,
      priceB: properties.contains(MatexCoreStateProperty.priceB)
          ? defaultState?.priceB
          : priceB,
      fixedCosts: properties.contains(MatexCoreStateProperty.fixedCosts)
          ? defaultState?.fixedCosts
          : fixedCosts,
      exitDiscountAmount:
          properties.contains(MatexCoreStateProperty.exitDiscountAmount)
              ? defaultState?.exitDiscountAmount
              : exitDiscountAmount,
      exitDiscountPercentage:
          properties.contains(MatexCoreStateProperty.exitDiscountPercentage)
              ? defaultState?.exitDiscountPercentage
              : exitDiscountPercentage,
      entryFeePercentagePerUnit:
          properties.contains(MatexCoreStateProperty.entryFeePercentagePerUnit)
              ? defaultState?.entryFeePercentagePerUnit
              : entryFeePercentagePerUnit,
      entryFeeAmountPerUnit:
          properties.contains(MatexCoreStateProperty.entryFeeAmountPerUnit)
              ? defaultState?.entryFeeAmountPerUnit
              : entryFeeAmountPerUnit,
      exitFeePercentagePerUnit:
          properties.contains(MatexCoreStateProperty.exitFeePercentagePerUnit)
              ? defaultState?.exitFeePercentagePerUnit
              : exitFeePercentagePerUnit,
      exitFeeAmountPerUnit:
          properties.contains(MatexCoreStateProperty.exitFeeAmountPerUnit)
              ? defaultState?.exitFeeAmountPerUnit
              : exitFeeAmountPerUnit,
      dividendPaymentFrequency:
          properties.contains(MatexCoreStateProperty.dividendPaymentFrequency)
              ? defaultState?.dividendPaymentFrequency
              : dividendPaymentFrequency,
      annualSharePriceIncrease:
          properties.contains(MatexCoreStateProperty.annualSharePriceIncrease)
              ? defaultState?.annualSharePriceIncrease
              : annualSharePriceIncrease,
      annualDividendIncrease:
          properties.contains(MatexCoreStateProperty.annualDividendIncrease)
              ? defaultState?.annualDividendIncrease
              : annualDividendIncrease,
      annualContribution:
          properties.contains(MatexCoreStateProperty.annualContribution)
              ? defaultState?.annualContribution
              : annualContribution,
      numberOfShares: properties.contains(MatexCoreStateProperty.numberOfShares)
          ? defaultState?.numberOfShares
          : numberOfShares,
      dividendYield: properties.contains(MatexCoreStateProperty.dividendYield)
          ? defaultState?.dividendYield
          : dividendYield,
      yearsToGrow: properties.contains(MatexCoreStateProperty.yearsToGrow)
          ? defaultState?.yearsToGrow
          : yearsToGrow,
      sharePrice: properties.contains(MatexCoreStateProperty.sharePrice)
          ? defaultState?.sharePrice
          : sharePrice,
      drip: properties.contains(MatexCoreStateProperty.drip)
          ? defaultState?.drip
          : drip,
      taxExemptAmountPerYear:
          properties.contains(MatexCoreStateProperty.taxExemptAmountPerYear)
              ? defaultState?.taxExemptAmountPerYear
              : taxExemptAmountPerYear,
      totalDividend: properties.contains(MatexCoreStateProperty.totalDividend)
          ? defaultState?.totalDividend
          : totalDividend,
      netIncome: properties.contains(MatexCoreStateProperty.netIncome)
          ? defaultState?.netIncome
          : netIncome,
    );
  }

  @override
  MatexBaseCoreState copyWith({
    double? customPrice,
    double? highPrice,
    double? lowPrice,
    int? precision,
    MatexTrend? trend,
    List<double>? extensionLevels,
    List<double>? retracementLevels,
    double? counterAccountCurrencyPairExchangeRate,
    double? tradingPairExchangeRate,
    double? positionSize,
    int? pipPrecision,
    MatexLotDescriptors? lotDescriptors,
    bool? baseListedSecond,
    double? leverage,
    double? closePrice,
    double? openPrice,
    MatexPivotPointsMethods? method,
    double? accountSize,
    double? entryPrice,
    double? amountAtRisk,
    double? riskRatio,
    MatexPosition? position,
    double? stopLossPips,
    double? stopLossPrice,
    double? stopLossAmount,
    double? takeProfitPips,
    double? takeProfitPrice,
    double? takeProfitAmount,
    String? accountCode,
    String? baseCode,
    String? counterCode,
    int? exchangeRateLastUpdateAt,
    double? exitPrice,
    double? entryFeePercentage,
    double? entryFeeAmount,
    double? exitFeePrecentage,
    double? exitFeeAmount,
    double? taxRate,
    double? priceA,
    double? priceB,
    double? exitFeePercentage,
    double? fixedCosts,
    double? exitDiscountAmount,
    double? exitDiscountPercentage,
    double? entryFeePercentagePerUnit,
    double? entryFeeAmountPerUnit,
    double? exitFeePercentagePerUnit,
    double? exitFeeAmountPerUnit,
    bool? drip,
    MatexFrequency? dividendPaymentFrequency,
    double? annualSharePriceIncrease,
    double? annualDividendIncrease,
    double? annualContribution,
    double? numberOfShares,
    double? dividendYield,
    int? yearsToGrow,
    double? sharePrice,
    double? taxExemptAmountPerYear,
    double? totalDividend,
    double? netIncome,
  }) {
    return MatexBaseCoreState(
      accountCode: accountCode ?? this.accountCode,
      baseCode: baseCode ?? this.baseCode,
      counterCode: counterCode ?? this.counterCode,
      customPrice: customPrice ?? this.customPrice,
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      precision: precision ?? this.precision,
      trend: trend ?? this.trend,
      extensionLevels: extensionLevels ?? this.extensionLevels,
      retracementLevels: retracementLevels ?? this.retracementLevels,
      counterAccountCurrencyPairExchangeRate:
          counterAccountCurrencyPairExchangeRate ??
              this.counterAccountCurrencyPairExchangeRate,
      tradingPairExchangeRate:
          tradingPairExchangeRate ?? this.tradingPairExchangeRate,
      positionSize: positionSize ?? this.positionSize,
      pipPrecision: pipPrecision ?? this.pipPrecision,
      lotDescriptors: lotDescriptors ?? this.lotDescriptors,
      baseListedSecond: baseListedSecond ?? this.baseListedSecond,
      leverage: leverage ?? this.leverage,
      closePrice: closePrice ?? this.closePrice,
      openPrice: openPrice ?? this.openPrice,
      method: method ?? this.method,
      accountSize: accountSize ?? this.accountSize,
      amountAtRisk: amountAtRisk ?? this.amountAtRisk,
      riskRatio: riskRatio ?? this.riskRatio,
      entryPrice: entryPrice ?? this.entryPrice,
      position: position ?? this.position,
      stopLossPips: stopLossPips ?? this.stopLossPips,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      stopLossAmount: stopLossAmount ?? this.stopLossAmount,
      takeProfitPips: takeProfitPips ?? this.takeProfitPips,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
      takeProfitAmount: takeProfitAmount ?? this.takeProfitAmount,
      exchangeRateLastUpdateAt:
          exchangeRateLastUpdateAt ?? this.exchangeRateLastUpdateAt,
      exitPrice: exitPrice ?? this.exitPrice,
      entryFeePercentage: entryFeePercentage ?? this.entryFeePercentage,
      entryFeeAmount: entryFeeAmount ?? this.entryFeeAmount,
      exitFeePercentage: exitFeePrecentage ?? this.exitFeePercentage,
      exitFeeAmount: exitFeeAmount ?? this.exitFeeAmount,
      taxRate: taxRate ?? this.taxRate,
      priceA: priceA ?? this.priceA,
      priceB: priceB ?? this.priceB,
      fixedCosts: fixedCosts ?? this.fixedCosts,
      exitDiscountAmount: exitDiscountAmount ?? this.exitDiscountAmount,
      exitDiscountPercentage:
          exitDiscountPercentage ?? this.exitDiscountPercentage,
      entryFeePercentagePerUnit:
          entryFeePercentagePerUnit ?? this.entryFeePercentagePerUnit,
      entryFeeAmountPerUnit:
          entryFeeAmountPerUnit ?? this.entryFeeAmountPerUnit,
      exitFeePercentagePerUnit:
          exitFeePercentagePerUnit ?? this.exitFeePercentagePerUnit,
      exitFeeAmountPerUnit: exitFeeAmountPerUnit ?? this.exitFeeAmountPerUnit,
      drip: drip ?? this.drip,
      dividendPaymentFrequency:
          dividendPaymentFrequency ?? this.dividendPaymentFrequency,
      annualSharePriceIncrease:
          annualSharePriceIncrease ?? this.annualSharePriceIncrease,
      annualDividendIncrease:
          annualDividendIncrease ?? this.annualDividendIncrease,
      annualContribution: annualContribution ?? this.annualContribution,
      numberOfShares: numberOfShares ?? this.numberOfShares,
      dividendYield: dividendYield ?? this.dividendYield,
      yearsToGrow: yearsToGrow ?? this.yearsToGrow,
      sharePrice: sharePrice ?? this.sharePrice,
      taxExemptAmountPerYear:
          taxExemptAmountPerYear ?? this.taxExemptAmountPerYear,
      totalDividend: totalDividend ?? this.totalDividend,
      netIncome: netIncome ?? this.netIncome,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accountCode': accountCode,
      'baseCode': baseCode,
      'counterCode': counterCode,
      'customPrice': customPrice,
      'highPrice': highPrice,
      'lowPrice': lowPrice,
      'precision': precision,
      'trend': trend?.index,
      'extensionLevels': extensionLevels,
      'retracementLevels': retracementLevels,
      'counterAccountCurrencyPairExchangeRate':
          counterAccountCurrencyPairExchangeRate,
      'tradingPairExchangeRate': tradingPairExchangeRate,
      'positionSize': positionSize,
      'pipPrecision': pipPrecision,
      'lotDescriptors': lotDescriptors?.toJson(),
      'baseListedSecond': baseListedSecond,
      'leverage': leverage,
      'closePrice': closePrice,
      'openPrice': openPrice,
      'method': method?.index,
      'accountSize': accountSize,
      'amountAtRisk': amountAtRisk,
      'riskRatio': riskRatio,
      'entryPrice': entryPrice,
      'position': position?.index,
      'stopLossPips': stopLossPips,
      'stopLossPrice': stopLossPrice,
      'stopLossAmount': stopLossAmount,
      'takeProfitPips': takeProfitPips,
      'takeProfitPrice': takeProfitPrice,
      'takeProfitAmount': takeProfitAmount,
      'exchangeRateLastUpdateAt': exchangeRateLastUpdateAt,
      'exitPrice': exitPrice,
      'entryFeePercentage': entryFeePercentage,
      'entryFeeAmount': entryFeeAmount,
      'exitFeePrecentage': exitFeePercentage,
      'exitFeeAmount': exitFeeAmount,
      'taxRate': taxRate,
      'priceA': priceA,
      'priceB': priceB,
      'fixedCosts': fixedCosts,
      'exitDiscountAmount': exitDiscountAmount,
      'exitDiscountPercentage': exitDiscountPercentage,
      'entryFeePercentagePerUnit': entryFeePercentagePerUnit,
      'entryFeeAmountPerUnit': entryFeeAmountPerUnit,
      'exitFeePercentagePerUnit': exitFeePercentagePerUnit,
      'exitFeeAmountPerUnit': exitFeeAmountPerUnit,
      'dividendPaymentFrequency': dividendPaymentFrequency?.index,
      'annualSharePriceIncrease': annualSharePriceIncrease,
      'annualDividendIncrease': annualDividendIncrease,
      'annualContribution': annualContribution,
      'numberOfShares': numberOfShares,
      'dividendYield': dividendYield,
      'yearsToGrow': yearsToGrow,
      'sharePrice': sharePrice,
      'drip': drip,
      'taxExemptAmountPerYear': taxExemptAmountPerYear,
      'totalDividend': totalDividend,
      'netIncome': netIncome,
    };
  }

  factory MatexBaseCoreState.fromJson(dynamic json) {
    var lotDescriptors = json['lotDescriptors'];
    var trend = json['trend'] as int?;
    var method = json['method'] as int?;
    var position = json['position'] as int?;
    var frequency = json['dividendPaymentFrequency'] as int?;

    return MatexBaseCoreState(
      accountCode: json['accountCode'] as String?,
      baseCode: json['baseCode'] as String?,
      counterCode: json['counterCode'] as String?,
      customPrice: json['customPrice'] as double?,
      highPrice: json['highPrice'] as double?,
      lowPrice: json['lowPrice'] as double?,
      precision: json['precision'] as int?,
      trend: trend != null ? MatexTrend.values[trend] : null,
      extensionLevels: json['extensionLevels'] as List<double>?,
      retracementLevels: json['retracementLevels'] as List<double>?,
      counterAccountCurrencyPairExchangeRate:
          json['counterAccountCurrencyPairExchangeRate'] as double?,
      tradingPairExchangeRate: json['tradingPairExchangeRate'] as double?,
      positionSize: json['positionSize'] as double?,
      pipPrecision: json['pipPrecision'] as int?,
      lotDescriptors: lotDescriptors != null
          ? MatexLotDescriptors.fromJson(json['lotDescriptors'])
          : null,
      baseListedSecond: json['baseListedSecond'] as bool?,
      leverage: json['leverage'] as double?,
      closePrice: json['closePrice'] as double?,
      openPrice: json['openPrice'] as double?,
      method: method != null ? MatexPivotPointsMethods.values[method] : null,
      accountSize: json['accountSize'] as double?,
      amountAtRisk: json['amountAtRisk'] as double?,
      riskRatio: json['riskRatio'] as double?,
      entryPrice: json['entryPrice'] as double?,
      position: position != null ? MatexPosition.values[position] : null,
      stopLossPips: json['stopLossPips'] as double?,
      stopLossPrice: json['stopLossPrice'] as double?,
      stopLossAmount: json['stopLossAmount'] as double?,
      takeProfitPips: json['takeProfitPips'] as double?,
      takeProfitPrice: json['takeProfitPrice'] as double?,
      takeProfitAmount: json['takeProfitAmount'] as double?,
      exchangeRateLastUpdateAt: json['exchangeRateLastUpdateAt'] as int?,
      exitPrice: json['exitPrice'] as double?,
      entryFeePercentage: json['entryFeePercentage'] as double?,
      entryFeeAmount: json['entryFeeAmount'] as double?,
      exitFeePercentage: json['exitFeePrecentage'] as double?,
      exitFeeAmount: json['exitFeeAmount'] as double?,
      taxRate: json['taxRate'] as double?,
      priceA: json['priceA'] as double?,
      priceB: json['priceB'] as double?,
      fixedCosts: json['fixedCosts'] as double?,
      exitDiscountAmount: json['exitDiscountAmount'] as double?,
      exitDiscountPercentage: json['exitDiscountPercentage'] as double?,
      entryFeePercentagePerUnit: json['entryFeePercentagePerUnit'] as double?,
      entryFeeAmountPerUnit: json['entryFeeAmountPerUnit'] as double?,
      exitFeePercentagePerUnit: json['exitFeePercentagePerUnit'] as double?,
      exitFeeAmountPerUnit: json['exitFeeAmountPerUnit'] as double?,
      dividendPaymentFrequency:
          frequency != null ? MatexFrequency.values[frequency] : null,
      annualSharePriceIncrease: json['annualSharePriceIncrease'] as double?,
      annualDividendIncrease: json['annualDividendIncrease'] as double?,
      annualContribution: json['annualContribution'] as double?,
      dividendYield: json['dividendYield'] as double?,
      numberOfShares: json['numberOfShares'] as double?,
      sharePrice: json['sharePrice'] as double?,
      yearsToGrow: json['yearsToGrow'] as int?,
      drip: json['drip'] as bool?,
      taxExemptAmountPerYear: json['taxExemptAmountPerYear'] as double?,
      totalDividend: json['totalDividend'] as double?,
      netIncome: json['netIncome'] as double?,
    );
  }

  @override
  List<Object?> get props => [
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
        counterAccountCurrencyPairExchangeRate,
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
        exchangeRateLastUpdateAt,
        exitPrice,
        entryFeePercentage,
        entryFeeAmount,
        exitFeePercentage,
        exitFeeAmount,
        taxRate,
        priceA,
        priceB,
        fixedCosts,
        exitDiscountAmount,
        exitDiscountPercentage,
        entryFeePercentagePerUnit,
        entryFeeAmountPerUnit,
        exitFeePercentagePerUnit,
        exitFeeAmountPerUnit,
        dividendPaymentFrequency,
        annualSharePriceIncrease,
        annualDividendIncrease,
        annualContribution,
        numberOfShares,
        dividendYield,
        yearsToGrow,
        sharePrice,
        drip,
        taxExemptAmountPerYear,
        totalDividend,
        netIncome,
      ];

  @override
  MatexBaseCoreState merge(covariant MatexBaseCoreState state) {
    return copyWithState(state);
  }
}
