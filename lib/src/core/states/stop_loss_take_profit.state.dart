import 'package:matex_dart/src/core/enums/enums.dart';
import 'package:matex_dart/src/core/states/states.dart';

final Map<CalculatorKey, dynamic> initialStopLossTakeProfitState = {
  ...initialPipValueState,
  ...initialStopLossState,
  ...initialTakeProfitState,
};
