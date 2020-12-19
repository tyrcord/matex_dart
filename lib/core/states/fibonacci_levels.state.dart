import 'package:matex_dart/matex_dart.dart';

const kInitialFibonacciLevelsState = MatexBaseCoreState(
  customPrice: 0.0,
  highPrice: 0.0,
  lowPrice: 0.0,
  precision: 5,
  trend: MatexTrend.up,
  extensionLevels: kMatexFibonacciExtensionLevels,
  retracementLevels: kMatexFibonacciRetracementLevels,
);
