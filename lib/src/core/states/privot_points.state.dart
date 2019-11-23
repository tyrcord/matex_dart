import 'package:matex_dart/src/core/enums/enums.dart';

final Map<CalculatorKey, dynamic> initialPivotPointsState = {
  CalculatorKey.ClosePrice: 0,
  CalculatorKey.HighPrice: 0,
  CalculatorKey.LowPrice: 0,
  CalculatorKey.PivotPointsMethod: PivotPointsMethods.Standard,
  CalculatorKey.OpenPrice: 0,
};
