// import 'package:matex_dart/matex_dart.dart';

// final List<StateValidator<PositionSizeState>> positionSizeValidators = [
//   ...pipValueValidators,
//   (PositionSizeState state) => state.accountSize > 0,
//   (PositionSizeState state) =>
//       state.amountAtRisk != null || state.riskRatio != null,
//   (PositionSizeState state) {
//     final amountAtRisk = state.amountAtRisk;
//     final accountSize = state.accountSize;
//     final riskRatio = state.riskRatio;
//     bool isValid = true;

//     if (riskRatio != null) {
//       isValid = riskRatio > 0 && riskRatio <= 100;
//     }

//     if (amountAtRisk != null) {
//       isValid = amountAtRisk > 0 && amountAtRisk <= accountSize;
//     }

//     return isValid;
//   },
// ];
