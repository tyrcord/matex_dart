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
    patchState(MatexBaseCoreState(entryFeeAmount: sanitizeDouble(fee)));

    return resetStateProperties([
      MatexCoreStateProperty.entryFeePercentagePerUnit,
      MatexCoreStateProperty.entryFeeAmountPerUnit,
      MatexCoreStateProperty.entryFeePercentage,
    ]);
  }

  C exitFeeAmount(double fee) {
    patchState(MatexBaseCoreState(exitFeeAmount: sanitizeDouble(fee)));

    return resetStateProperties([
      MatexCoreStateProperty.exitFeeAmountPerUnit,
      MatexCoreStateProperty.exitFeePercentage,
      MatexCoreStateProperty.exitFeePercentagePerUnit,
    ]);
  }

  C entryFeePercentage(double fee) {
    patchState(MatexBaseCoreState(entryFeePercentage: sanitizeDouble(fee)));

    return resetStateProperties([
      MatexCoreStateProperty.entryFeePercentagePerUnit,
      MatexCoreStateProperty.entryFeeAmountPerUnit,
      MatexCoreStateProperty.entryFeeAmount,
    ]);
  }

  C exitFeePercentage(double fee) {
    patchState(MatexBaseCoreState(exitFeePercentage: sanitizeDouble(fee)));

    return resetStateProperties([
      MatexCoreStateProperty.exitFeeAmount,
      MatexCoreStateProperty.exitFeeAmountPerUnit,
      MatexCoreStateProperty.exitFeePercentagePerUnit,
    ]);
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
    patchState(MatexBaseCoreState(exitDiscountAmount: amount));

    return resetStateProperties([
      MatexCoreStateProperty.exitDiscountPercentage,
    ]);
  }

  C exitDiscountPercentage(double rate) {
    patchState(
      MatexBaseCoreState(exitDiscountPercentage: sanitizeDouble(rate)),
    );

    return resetStateProperties([
      MatexCoreStateProperty.exitDiscountAmount,
    ]);
  }

  C entryFeePercentagePerUnit(double fee) {
    patchState(MatexBaseCoreState(
      entryFeePercentagePerUnit: sanitizeDouble(fee),
    ));

    return resetStateProperties([
      MatexCoreStateProperty.entryFeeAmountPerUnit,
      MatexCoreStateProperty.entryFeePercentage,
      MatexCoreStateProperty.entryFeeAmount,
    ]);
  }

  C entryFeeAmountPerUnit(double fee) {
    patchState(MatexBaseCoreState(entryFeeAmountPerUnit: sanitizeDouble(fee)));

    return resetStateProperties([
      MatexCoreStateProperty.entryFeePercentagePerUnit,
      MatexCoreStateProperty.entryFeePercentage,
      MatexCoreStateProperty.entryFeeAmount,
    ]);
  }

  C exitFeePercentagePerUnit(double fee) {
    patchState(
      MatexBaseCoreState(exitFeePercentagePerUnit: sanitizeDouble(fee)),
    );

    return resetStateProperties([
      MatexCoreStateProperty.exitFeeAmountPerUnit,
      MatexCoreStateProperty.exitFeePercentage,
      MatexCoreStateProperty.exitFeeAmount,
    ]);
  }

  C exitFeeAmountPerUnit(double fee) {
    patchState(MatexBaseCoreState(exitFeeAmountPerUnit: sanitizeDouble(fee)));

    return resetStateProperties([
      MatexCoreStateProperty.exitFeePercentagePerUnit,
      MatexCoreStateProperty.exitFeePercentage,
      MatexCoreStateProperty.exitFeeAmount,
    ]);
  }
}
