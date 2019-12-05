import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<BaseState>> positionSizeValidators = [
  ...pipValueValidators,
  (BaseState state) => state.accountSize > 0,
  (BaseState state) => state.amountAtRisk > 0 || state.riskRatio > 0,
  (BaseState state) {
    final amountAtRisk = state.amountAtRisk;
    final accountSize = state.accountSize;
    final riskRatio = state.riskRatio;
    bool isValid = true;

    if (riskRatio > 0) {
      isValid = riskRatio > 0 && riskRatio <= 100;
    }

    if (amountAtRisk > 0) {
      isValid = amountAtRisk > 0 && amountAtRisk <= accountSize;
    }

    return isValid;
  },
];
