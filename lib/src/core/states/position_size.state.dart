import 'package:matex_dart/matex_dart.dart';

final Map<CalculatorKey, dynamic> initialPositionSizeState = {
  ...initialPipValueState,
  CalculatorKey.AccountSize: 0,
  CalculatorKey.AmountAtRisk: 0,
  CalculatorKey.EntryPrice: 0,
  CalculatorKey.RiskRatio: 0,
  CalculatorKey.StopLossPips: 0,
  CalculatorKey.StopLossPrice: 0,
  CalculatorKey.PositionSize: 1,
};
