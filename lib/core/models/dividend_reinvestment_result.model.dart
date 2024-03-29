import 'package:equatable/equatable.dart';

import 'package:matex_dart/matex_dart.dart';

class MatexDividendReinvestmentResult extends Equatable {
  final List<MatexDividendReinvestementYearlyPayoutReport> yearlyReports;
  final double netDividendeIncome;
  final double grossDividendPaid;
  final double totalContribution;
  final double netDividendPaid;
  final double startingBalance;
  final double numberOfShares;
  final double endingBalance;
  final double totalReturn;
  final double sharePrice;

  const MatexDividendReinvestmentResult({
    this.yearlyReports = const [],
    this.netDividendeIncome = 0,
    this.grossDividendPaid = 0,
    this.totalContribution = 0,
    this.netDividendPaid = 0,
    this.startingBalance = 0,
    this.numberOfShares = 0,
    this.endingBalance = 0,
    this.totalReturn = 0,
    this.sharePrice = 0,
  });

  @override
  List<Object> get props => [
        netDividendeIncome,
        totalContribution,
        grossDividendPaid,
        netDividendPaid,
        startingBalance,
        numberOfShares,
        endingBalance,
        yearlyReports,
        totalReturn,
        sharePrice,
      ];
}
