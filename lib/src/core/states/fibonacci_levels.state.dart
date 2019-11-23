import 'package:matex_dart/matex_dart.dart';

final Map<CalculatorKey, dynamic> initialFibonacciLevelsState = {
  CalculatorKey.CustomPrice: 0,
  CalculatorKey.ExtensionLevels: [
    23.6,
    38.2,
    50,
    61.8,
    100,
    138.2,
    161.8,
    200,
    261.8,
  ],
  CalculatorKey.HighPrice: 0,
  CalculatorKey.LowPrice: 0,
  CalculatorKey.Precision: 5,
  CalculatorKey.RetracementLevels: [
    23.6,
    38.2,
    50,
    61.8,
    78.6,
  ],
  CalculatorKey.Trend: Trend.Up,
};
