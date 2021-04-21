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
      final dTotalCosts = dEntryCosts + dExitCosts + dFixedCosts;
      final dNetPnl = dGrossPnl - dTotalCosts;
      final dTaxAmount = computeTaxAmount(dNetPnl);
      final dNetPnlAfterTaxe = dNetPnl - dTaxAmount;
      final dROI = computeReturnOnInvestment(dNetBuyPrice, dNetPnlAfterTaxe);
      final dBreakEvenUnits = _computBreakEvenUnits(
        dFixedCosts,
        dGrossSellPrice,
        dGrossBuyPrice,
        dEntryCosts,
        dExitCosts,
      );

      return MatexProfitAndLossResult(
        totalCosts: dTotalCosts.toDouble(),
        entryCostsAmount: dEntryCosts.toDouble(),
        exitCostsAmount: dExitCosts.toDouble(),
        grossSellPrice: dGrossSellPrice.toDouble(),
        grossBuyPrice: dGrossBuyPrice.toDouble(),
        netSellPrice: dNetSellPrice.toDouble(),
        netBuyPrice: dNetBuyPrice.toDouble(),
        profitOrLoss: dNetPnlAfterTaxe.toDouble(),
        returnOnInvestement: dROI.toDouble(),
        taxAmount: dTaxAmount.toDouble(),
        breakEvenUnits: dBreakEvenUnits.toDouble(),
      );
    }

    return MatexProfitAndLossResult();
  }

  Decimal _computBreakEvenUnits(
    Decimal dFixedCosts,
    Decimal dGrossSellPrice,
    Decimal dGrossBuyPrice,
    Decimal dEntryCosts,
    Decimal dExitCosts,
  ) {
    if (dFixedCosts > Decimal.zero) {
      final dFraction =
          dGrossSellPrice - dGrossBuyPrice - dEntryCosts - dExitCosts;

      if (dFraction > Decimal.zero) {
        final dPositionSize = MatexDecimal.fromDouble(state.positionSize!);
        return (dFixedCosts / dFraction * dPositionSize).ceil();
      }
    }

    return Decimal.zero;
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
    var entryFeePercentage = state.entryFeePercentage;
    var entryFeeAmount = state.entryFeeAmount;

    if (entryFeeAmount == null) {
      if (state.entryFeeAmountPerUnit != null) {
        final dPositionSize = MatexDecimal.fromDouble(state.positionSize!);
        final dAmountPerUnit = MatexDecimal.fromDouble(
          state.entryFeeAmountPerUnit!,
        );

        entryFeeAmount = (dAmountPerUnit * dPositionSize).toDouble();
      } else if (state.entryFeePercentagePerUnit != null) {
        final dPercent = MatexDecimal.fromDouble(
          state.entryFeePercentagePerUnit!,
        );

        final multiplicator = dPercent / MatexDecimal.hundred;
        entryFeeAmount = (dGrossBuyPrice * multiplicator).toDouble();
      }
    }

    return _computeCosts(dGrossBuyPrice, entryFeeAmount, entryFeePercentage);
  }

  Decimal _computeExitCosts(Decimal dGrossSellPrice) {
    var exitFeePercentage = state.exitFeePercentage;
    var exitFeeAmount = state.exitFeeAmount;

    if (exitFeeAmount == null) {
      if (state.exitFeeAmountPerUnit != null) {
        final dPositionSize = MatexDecimal.fromDouble(state.positionSize!);
        final dAmountPerUnit = MatexDecimal.fromDouble(
          state.exitFeeAmountPerUnit!,
        );

        exitFeeAmount = (dAmountPerUnit * dPositionSize).toDouble();
      } else if (state.exitFeePercentagePerUnit != null) {
        final dPercent = MatexDecimal.fromDouble(
          state.exitFeePercentagePerUnit!,
        );

        final multiplicator = dPercent / MatexDecimal.hundred;
        exitFeeAmount = (dGrossSellPrice * multiplicator).toDouble();
      }
    }

    return _computeCosts(dGrossSellPrice, exitFeeAmount, exitFeePercentage);
  }

  Decimal _computeCosts(
    Decimal grossPrice,
    double? feeAmount,
    double? feePercentage,
  ) {
    if (feeAmount != null && feeAmount > 0) {
      return MatexDecimal.fromDouble(feeAmount);
    } else if (feePercentage != null && feePercentage > 0) {
      final dPercent =
          MatexDecimal.fromDouble(feePercentage) / MatexDecimal.hundred;
      return grossPrice * dPercent;
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
