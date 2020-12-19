import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> corePositionSizeValidators = [
  (MatexBaseCoreState state) =>
      (state.amountAtRisk != null && state.amountAtRisk > 0) ||
      (state.riskRatio != null &&
          state.riskRatio > 0 &&
          state.accountSize != null &&
          state.accountSize > 0),
  (MatexBaseCoreState state) {
    final amountAtRisk = state.amountAtRisk;
    final accountSize = state.accountSize;
    final riskRatio = state.riskRatio;
    var isValid = true;

    if (riskRatio != null && riskRatio > 0) {
      isValid = riskRatio > 0 && riskRatio <= 100;
    }

    if (amountAtRisk != null && amountAtRisk > 0) {
      isValid = amountAtRisk > 0;

      if (isValid && accountSize != null && accountSize > 0) {
        isValid = amountAtRisk <= accountSize;
      }
    }

    return isValid;
  },
];

final List<MatexStateValidator> positionSizeValidators = [
  ...pipValueValidators,
  ...corePositionSizeValidators,
];
