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
    final taxRate = state.taxRate;

    if (taxRate != null) {
      return taxRate >= 0 && taxRate <= 100;
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
  (MatexBaseCoreState state) {
    final exitDiscountPercentage = state.exitDiscountPercentage;

    if (exitDiscountPercentage != null) {
      return exitDiscountPercentage >= 0 && exitDiscountPercentage <= 100;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    final exitDiscountAmount = state.exitDiscountAmount;

    if (exitDiscountAmount != null) {
      final exitPrice = state.exitPrice;

      return exitDiscountAmount >= 0 && exitDiscountAmount <= exitPrice!;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    final fixedCosts = state.fixedCosts;

    if (fixedCosts != null) {
      return fixedCosts >= 0;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    final fee = state.entryFeePercentagePerUnit;

    if (fee != null) {
      return fee >= 0 && fee <= 100;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    final fee = state.entryFeeAmountPerUnit;

    if (fee != null) {
      return fee >= 0;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    final fee = state.exitFeePercentagePerUnit;

    if (fee != null) {
      return fee >= 0 && fee <= 100;
    }

    return true;
  },
  (MatexBaseCoreState state) {
    final fee = state.exitFeeAmountPerUnit;

    if (fee != null) {
      return fee >= 0;
    }

    return true;
  },
];
