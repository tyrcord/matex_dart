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
      final dBuyCommission = _computeBuyCommission(dGrossBuyPrice);
      final dGrossSellPrice = _computeGrossSellPrice();
      final dSellCommission = _computeSellCommission(dGrossSellPrice);
      final dNetBuyPrice = _computeNetGrossPrice(
        dGrossBuyPrice,
        dBuyCommission,
      );
      final dNetSellPrice = _computeNetSellPrice(
        dGrossSellPrice,
        dSellCommission,
      );
      final dGrossPnl = computeGrossProfitOrLoss(
        dGrossBuyPrice,
        dGrossSellPrice,
      );
      final dNetPnl = dGrossPnl - dBuyCommission - dSellCommission;
      final dTaxAmount = computeTaxAmount(dNetPnl);
      final dNetPnlAfterTaxe = dNetPnl - dTaxAmount;
      final dROI = computeReturnOnInvestment(dNetBuyPrice, dNetPnlAfterTaxe);

      return MatexProfitAndLossResult(
        buyCommissionAmount: dBuyCommission.toDouble(),
        sellCommissionAmount: dSellCommission.toDouble(),
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
    return dPositionSize * dExitPrice;
  }

  Decimal _computeBuyCommission(Decimal dGrossBuyPrice) {
    return _computeCommission(
      dGrossBuyPrice,
      state.entryFeeAmount,
      state.entryFeePercentage,
    );
  }

  Decimal _computeSellCommission(Decimal dGrossSellPrice) {
    return _computeCommission(
      dGrossSellPrice,
      state.exitFeeAmount,
      state.exitFeePercentage,
    );
  }

  Decimal _computeCommission(
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
    Decimal dBuyCommission,
  ) {
    return dGrossSellPrice + dBuyCommission;
  }

  Decimal _computeNetSellPrice(
    Decimal dGrossSellPrice,
    Decimal dSellCommission,
  ) {
    return dGrossSellPrice - dSellCommission;
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
