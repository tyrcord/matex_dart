import 'package:equatable/equatable.dart';

class MatexProfitAndLossResult extends Equatable {
  final double returnOnInvestement;
  final double entryCostsAmount;
  final double exitCostsAmount;
  final double profitOrLoss;
  final double netSellPrice;
  final double netBuyPrice;
  final double taxAmount;

  const MatexProfitAndLossResult({
    this.returnOnInvestement = 0,
    this.entryCostsAmount = 0,
    this.exitCostsAmount = 0,
    this.profitOrLoss = 0,
    this.netSellPrice = 0,
    this.netBuyPrice = 0,
    this.taxAmount = 0,
  });

  @override
  List<Object> get props => [
        exitCostsAmount,
        entryCostsAmount,
        returnOnInvestement,
        profitOrLoss,
        netSellPrice,
        netBuyPrice,
        taxAmount,
      ];
}
