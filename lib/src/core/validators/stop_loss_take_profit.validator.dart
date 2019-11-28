// import 'package:matex_dart/src/core/enums/enums.dart';
// import 'package:matex_dart/src/core/types/types.dart';
// import 'package:matex_dart/src/core/validators/validators.dart';

// final List<StateValidator> stopLossTakeProfitValidators = [
//   ...pipValueValidators,
//   (Map<CalculatorKey, dynamic> state) =>
//       state[CalculatorKey.EntryPrice] as num > 0,
//   (Map<CalculatorKey, dynamic> state) =>
//       state[CalculatorKey.TradingPairExchangeRate] as num > 0,
//   (Map<CalculatorKey, dynamic> state) {
//     final stopLossAmount = state[CalculatorKey.StopLossAmount] as num;
//     final stopLossPrice = state[CalculatorKey.StopLossPrice] as num;
//     final stopLossPips = state[CalculatorKey.StopLossPips] as num;
//     final takeProfitAmount = state[CalculatorKey.TakeProfitAmount] as num;
//     final takeProfitPrice = state[CalculatorKey.TakeProfitPrice] as num;
//     final takeProfitPips = state[CalculatorKey.TakeProfitPips] as num;

//     return (stopLossAmount > 0 ||
//         stopLossPrice > 0 ||
//         stopLossPips > 0 ||
//         (takeProfitAmount > 0 || takeProfitPrice > 0 || takeProfitPips > 0));
//   },
// ];
