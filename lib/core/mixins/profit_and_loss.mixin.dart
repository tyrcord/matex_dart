import 'package:matex_dart/matex_dart.dart';

mixin MatexProfitAndLossCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C entryPrice(double price) {
    return patchState(MatexBaseCoreState(entryPrice: sanitizeDouble(price)));
  }

  C exitPrice(double price) {
    return patchState(MatexBaseCoreState(exitPrice: sanitizeDouble(price)));
  }

  C entryFeeAmount(double fee) {
    return patchState(MatexBaseCoreState(entryFeeAmount: sanitizeDouble(fee)));
  }

  C exitFeeAmount(double fee) {
    return patchState(MatexBaseCoreState(exitFeeAmount: sanitizeDouble(fee)));
  }

  C entryFeePercentage(double fee) {
    return patchState(
      MatexBaseCoreState(entryFeePercentage: sanitizeDouble(fee)),
    );
  }

  C exitFeePercentage(double fee) {
    return patchState(
      MatexBaseCoreState(exitFeePercentage: sanitizeDouble(fee)),
    );
  }

  C taxeRate(double rate) {
    return patchState(MatexBaseCoreState(taxeRate: sanitizeDouble(rate)));
  }

  C position(MatexPosition position) {
    return patchState(MatexBaseCoreState(position: position));
  }

  C positionSize(double size) {
    return patchState(MatexBaseCoreState(positionSize: sanitizeDouble(size)));
  }

  C fixedCosts(double costs) {
    return patchState(MatexBaseCoreState(fixedCosts: sanitizeDouble(costs)));
  }

  C exitDiscountAmount(double amount) {
    return patchState(MatexBaseCoreState(exitDiscountAmount: amount));
  }

  C exitDiscountPercentage(double rate) {
    return patchState(MatexBaseCoreState(
      exitDiscountPercentage: sanitizeDouble(rate),
    ));
  }

  C entryFeePercentagePerUnit(double fee) {
    return patchState(MatexBaseCoreState(
      entryFeePercentagePerUnit: sanitizeDouble(fee),
    ));
  }

  C entryFeeAmountPerUnit(double fee) {
    return patchState(
      MatexBaseCoreState(entryFeeAmountPerUnit: sanitizeDouble(fee)),
    );
  }

  C exitFeePercentagePerUnit(double fee) {
    return patchState(
      MatexBaseCoreState(exitFeePercentagePerUnit: sanitizeDouble(fee)),
    );
  }

  C exitFeeAmountPerUnit(double fee) {
    return patchState(
      MatexBaseCoreState(exitFeeAmountPerUnit: sanitizeDouble(fee)),
    );
  }
}
