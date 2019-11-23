import 'package:matex_dart/src/core/descriptors/descriptors.dart';
import 'package:matex_dart/src/core/enums/enums.dart';

final Map<CalculatorKey, dynamic> initialPipValueState = {
  CalculatorKey.BaseExchangeRate: 0.0,
  CalculatorKey.BaseListedSecond: false,
  CalculatorKey.LotDescriptors: kDefaultLotDescriptors,
  CalculatorKey.PipPrecision: 4,
  CalculatorKey.PositionSize: 0.0,
  CalculatorKey.TradingPairExchangeRate: 0.0,
};
