import 'package:matex_dart/matex_dart.dart';

class MatexDividendReinvestementYearlyPayoutReport
    extends MatexDividendReinvestementPayoutReport {
  final List<MatexDividendReinvestementPayoutReport> payouts;
  final double dividendAmountPerShare;

  MatexDividendReinvestementYearlyPayoutReport({
    this.payouts = const <MatexDividendReinvestementPayoutReport>[],
    double additionalSharesFromAnnualContribution = 0,
    double additionalSharesFromDrip = 0,
    double cumulativeGrossAmount = 0,
    this.dividendAmountPerShare = 0,
    double cumulativeNetAmount = 0,
    double grossDividendPayout = 0,
    double netDividendPayout = 0,
    double averageSharePrice = 0,
    double numberOfShares = 0,
    double endingBalance = 0,
    double sharePrice = 0,
  }) : super(
          additionalSharesFromAnnualContribution:
              additionalSharesFromAnnualContribution,
          additionalSharesFromDrip: additionalSharesFromDrip,
          cumulativeGrossAmount: cumulativeGrossAmount,
          cumulativeNetAmount: cumulativeNetAmount,
          grossDividendPayout: grossDividendPayout,
          netDividendPayout: netDividendPayout,
          averageSharePrice: averageSharePrice,
          numberOfShares: numberOfShares,
          endingBalance: endingBalance,
          sharePrice: sharePrice,
        );

  @override
  List<dynamic> get props => [
        additionalSharesFromAnnualContribution,
        additionalSharesFromDrip,
        dividendAmountPerShare,
        cumulativeGrossAmount,
        cumulativeNetAmount,
        grossDividendPayout,
        averageSharePrice,
        netDividendPayout,
        numberOfShares,
        endingBalance,
        sharePrice,
        payouts,
      ];
}
