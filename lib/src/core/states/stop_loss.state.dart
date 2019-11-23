import 'package:matex_dart/src/core/states/states.dart';
import 'package:matex_dart/src/core/enums/enums.dart';

final Map<CalculatorKey, dynamic> initialStopLossState = {
  ...initialPipValueState,
  CalculatorKey.EntryPrice: 0,
  CalculatorKey.Position: Position.Long,
  CalculatorKey.StopLossAmount: 0,
  CalculatorKey.StopLossPips: 0,
  CalculatorKey.StopLossPrice: 0,
};
