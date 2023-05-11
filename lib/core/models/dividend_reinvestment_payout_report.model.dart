import 'package:matex_dart/matex_dart.dart';

class MatexDividendReinvestementPayoutReport
    extends MatexDividendReinvestementPayout {
  final double additionalSharesFromAnnualContribution;
  final double additionalSharesFromDrip;
  final double cumulativeGrossAmount;
  final double cumulativeNetAmount;
  final double averageSharePrice;
  final double numberOfShares;
  final double endingBalance;
  final double sharePrice;

  const MatexDividendReinvestementPayoutReport({
    this.additionalSharesFromAnnualContribution = 0,
    this.additionalSharesFromDrip = 0,
    this.cumulativeGrossAmount = 0,
    double grossDividendPayout = 0,
    this.cumulativeNetAmount = 0,
    double netDividendPayout = 0,
    this.averageSharePrice = 0,
    this.numberOfShares = 0,
    this.endingBalance = 0,
    this.sharePrice = 0,
  }) : super(
          grossDividendPayout: grossDividendPayout,
          netDividendPayout: netDividendPayout,
        );

  @override
  List<dynamic> get props => [
        additionalSharesFromAnnualContribution,
        additionalSharesFromDrip,
        cumulativeGrossAmount,
        cumulativeNetAmount,
        grossDividendPayout,
        averageSharePrice,
        netDividendPayout,
        numberOfShares,
        endingBalance,
        sharePrice,
      ];
}
