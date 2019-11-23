import 'package:matex_dart/src/core/states/states.dart';
import 'package:matex_dart/src/core/enums/enums.dart';

final Map<CalculatorKey, dynamic> initialTakeProfitState = {
  ...initialPipValueState,
  CalculatorKey.EntryPrice: 0,
  CalculatorKey.Position: Position.Long,
  CalculatorKey.TakeProfitAmount: 0,
  CalculatorKey.TakeProfitPips: 0,
  CalculatorKey.TakeProfitPrice: 0,
};
