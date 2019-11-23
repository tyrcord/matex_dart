import 'package:matex_dart/src/core/enums/enums.dart';
import 'package:matex_dart/src/core/types/types.dart';

final List<StateValidator> pipValueValidators = [
  (Map<CalculatorKey, dynamic> state) =>
      state[CalculatorKey.PositionSize] as num > 0,
  (Map<CalculatorKey, dynamic> state) =>
      state[CalculatorKey.TradingPairExchangeRate] as num > 0,
];
