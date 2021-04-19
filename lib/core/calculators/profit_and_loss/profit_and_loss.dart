import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexProfitAndLossCalculatorCore extends MatexBaseCalculator<
        MatexProfitAndLossCalculatorCore, MatexProfitAndLossResult>
    with
        MatexProfitAndLossCoreMixin<MatexProfitAndLossCalculatorCore,
            MatexProfitAndLossResult> {
  MatexProfitAndLossCalculatorCore({
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? profitAndLossValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialProfitAndLossState;

  @override
  MatexProfitAndLossResult value() {
    if (result != null) {
      return result!;
    }

    if (isValid) {
      final dGrossBuyPrice = _computeGrossBuyPrice();
      final dEntryCosts = _computeEntryCosts(dGrossBuyPrice);
      final dGrossSellPrice = _computeGrossSellPrice();
      final dExitCosts = _computeExitCosts(dGrossSellPrice);
      final dNetBuyPrice = _computeNetGrossPrice(
        dGrossBuyPrice,
        dEntryCosts,
      );
      final dNetSellPrice = _computeNetSellPrice(
        dGrossSellPrice,
        dExitCosts,
      );
      final dGrossPnl = computeGrossProfitOrLoss(
        dGrossBuyPrice,
        dGrossSellPrice,
      );

      final dFixedCosts = state.fixedCosts != null
          ? MatexDecimal.fromDouble(state.fixedCosts!)
          : Decimal.zero;
      final dNetPnl = dGrossPnl - dEntryCosts - dExitCosts - dFixedCosts;
      final dTaxAmount = computeTaxAmount(dNetPnl);
      final dNetPnlAfterTaxe = dNetPnl - dTaxAmount;
      final dROI = computeReturnOnInvestment(dNetBuyPrice, dNetPnlAfterTaxe);

      return MatexProfitAndLossResult(
        entryCostsAmount: dEntryCosts.toDouble(),
        exitCostsAmount: dExitCosts.toDouble(),
        netSellPrice: dNetSellPrice.toDouble(),
        netBuyPrice: dNetBuyPrice.toDouble(),
        profitOrLoss: dNetPnlAfterTaxe.toDouble(),
        returnOnInvestement: dROI.toDouble(),
        taxAmount: dTaxAmount.toDouble(),
      );
    }

    return MatexProfitAndLossResult();
  }

  Decimal _computeGrossBuyPrice() {
    final dPositionSize = MatexDecimal.fromDouble(state.positionSize!);
    final dEntryPrice = MatexDecimal.fromDouble(state.entryPrice!);
    return dPositionSize * dEntryPrice;
  }

  Decimal _computeGrossSellPrice() {
    final dPositionSize = MatexDecimal.fromDouble(state.positionSize!);
    final dExitPrice = MatexDecimal.fromDouble(state.exitPrice!);
    final exitDiscountPercentage = state.exitDiscountPercentage;
    final exitDiscountAmount = state.exitDiscountAmount;
    var dDiscountAmount = Decimal.zero;

    if (exitDiscountPercentage != null && exitDiscountPercentage > 0) {
      final dExitDiscountPercentage = MatexDecimal.fromDouble(
        exitDiscountPercentage,
      );

      final multiplicator = dExitDiscountPercentage / MatexDecimal.hundred;
      dDiscountAmount = multiplicator * dExitPrice;
    } else if (exitDiscountAmount != null && exitDiscountAmount > 0) {
      dDiscountAmount = MatexDecimal.fromDouble(exitDiscountAmount);
    }

    return dPositionSize * (dExitPrice - dDiscountAmount);
  }

  Decimal _computeEntryCosts(Decimal dGrossBuyPrice) {
    return _computeCosts(
      dGrossBuyPrice,
      state.entryFeeAmount,
      state.entryFeePercentage,
    );
  }

  Decimal _computeExitCosts(Decimal dGrossSellPrice) {
    return _computeCosts(
      dGrossSellPrice,
      state.exitFeeAmount,
      state.exitFeePercentage,
    );
  }

  Decimal _computeCosts(
    Decimal grossPrice,
    double? feeAmount,
    double? feePercentage,
  ) {
    if (feeAmount != null && feeAmount > 0) {
      return MatexDecimal.fromDouble(feeAmount);
    } else if (feePercentage != null && feePercentage > 0) {
      final dPercentage =
          MatexDecimal.fromDouble(feePercentage) / MatexDecimal.hundred;
      return grossPrice * dPercentage;
    }

    return Decimal.zero;
  }

  Decimal _computeNetGrossPrice(
    Decimal dGrossSellPrice,
    Decimal dEntryCosts,
  ) {
    return dGrossSellPrice + dEntryCosts;
  }

  Decimal _computeNetSellPrice(
    Decimal dGrossSellPrice,
    Decimal dExitCosts,
  ) {
    return dGrossSellPrice - dExitCosts;
  }

  Decimal computeGrossProfitOrLoss(Decimal netBuyPrice, Decimal netSellPrice) {
    late Decimal dDelta;

    if (state.position! == MatexPosition.long) {
      dDelta = netSellPrice - netBuyPrice;
    } else {
      dDelta = netBuyPrice - netSellPrice;
    }

    return dDelta;
  }

  Decimal computeReturnOnInvestment(Decimal netBuyPrice, Decimal dGrossPnl) {
    final balance = netBuyPrice + dGrossPnl;

    return balance / netBuyPrice - Decimal.one;
  }

  Decimal computeTaxAmount(Decimal grossPnl) {
    if (!grossPnl.isNegative && state.taxeRate != null && state.taxeRate! > 0) {
      final taxPercentage = state.taxeRate! / 100;
      return grossPnl * MatexDecimal.fromDouble(taxPercentage);
    }

    return Decimal.zero;
  }
}

MatexProfitAndLossCalculatorCore profitAndLoss({
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) =>
    MatexProfitAndLossCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
