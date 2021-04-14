import 'package:matex_dart/matex_dart.dart';

List<MatexStateValidator> profitAndLossValidators = [
  (MatexBaseCoreState state) {
    return state.positionSize != null &&
        state.entryPrice != null &&
        state.position != null &&
        state.exitPrice != null;
  },
  (MatexBaseCoreState state) {
    final positionSize = state.positionSize!;
    final entryPrice = state.entryPrice!;
    final exitPrice = state.exitPrice!;
    return entryPrice > 0 && exitPrice >= 0 && positionSize > 0;
  },
  (MatexBaseCoreState state) {
    final taxeRate = state.taxeRate;

    if (taxeRate != null) {
      return taxeRate >= 0 && taxeRate <= 100;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    final exitFeePercentage = state.exitFeePercentage;

    if (exitFeePercentage != null) {
      return exitFeePercentage >= 0 && exitFeePercentage <= 100;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    final entryFeePercentage = state.entryFeePercentage;

    if (entryFeePercentage != null) {
      return entryFeePercentage >= 0 && entryFeePercentage <= 100;
    }

    return true;
  },
];
