import 'package:equatable/equatable.dart';

class MatexProfitAndLossResult extends Equatable {
  final double sellCommissionAmount;
  final double buyCommissionAmount;
  final double returnOnInvestement;
  final double profitOrLoss;
  final double netSellPrice;
  final double netBuyPrice;
  final double taxAmount;

  const MatexProfitAndLossResult({
    this.sellCommissionAmount = 0,
    this.buyCommissionAmount = 0,
    this.returnOnInvestement = 0,
    this.profitOrLoss = 0,
    this.netSellPrice = 0,
    this.netBuyPrice = 0,
    this.taxAmount = 0,
  });

  @override
  List<Object> get props => [
        sellCommissionAmount,
        buyCommissionAmount,
        returnOnInvestement,
        profitOrLoss,
        netSellPrice,
        netBuyPrice,
        taxAmount,
      ];
}
