import 'package:matex_dart/src/core/enums/enums.dart';
import 'package:matex_dart/src/core/types/types.dart';
import 'package:matex_dart/src/core/validators/pip_value.validator.dart';

final List<StateValidator> positionSizeValidators = [
  ...pipValueValidators,
  (Map<CalculatorKey, dynamic> state) =>
      state[CalculatorKey.AccountSize] as num > 0,
  (Map<CalculatorKey, dynamic> state) =>
      state[CalculatorKey.AmountAtRisk] as num != null ||
      state[CalculatorKey.RiskRatio] as num != null,
  (Map<CalculatorKey, dynamic> state) {
    final amountAtRisk = state[CalculatorKey.LowPrice] as num;
    final accountSize = state[CalculatorKey.LowPrice] as num;
    final riskRatio = state[CalculatorKey.HighPrice] as num;
    bool isValid = true;

    if (riskRatio != null) {
      isValid = riskRatio > 0 && riskRatio <= 100;
    }

    if (amountAtRisk != null) {
      isValid = amountAtRisk > 0 && amountAtRisk <= accountSize;
    }

    return isValid;
  },
];
