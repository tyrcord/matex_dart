import 'package:matex_dart/matex_dart.dart';

final List<StateValidator> positionSizeValidators = [
  ...pipValueValidators,
  (BaseState state) => state.accountSize != null,
  (BaseState state) => state.accountSize > 0,
  (BaseState state) =>
      (state.amountAtRisk != null && state.amountAtRisk > 0) ||
      (state.riskRatio != null && state.riskRatio > 0),
  (BaseState state) {
    final amountAtRisk = state.amountAtRisk;
    final accountSize = state.accountSize;
    final riskRatio = state.riskRatio;
    var isValid = true;

    if (riskRatio != null && riskRatio > 0) {
      isValid = riskRatio > 0 && riskRatio <= 100;
    }

    if (amountAtRisk != null && amountAtRisk > 0) {
      isValid = amountAtRisk > 0 && amountAtRisk <= accountSize;
    }

    return isValid;
  },
];
