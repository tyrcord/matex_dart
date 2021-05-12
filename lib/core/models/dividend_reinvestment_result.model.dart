import 'package:equatable/equatable.dart';

import 'package:matex_dart/matex_dart.dart';

class MatexDividendReinvestmentResult extends Equatable {
  final List<MatexDividendReinvestementYearlyPayoutReport> yearlyReports;
  final double grossDividendPaid;
  final double totalContribution;
  final double netDividendPaid;
  final double startingBalance;
  final double numberOfShares;
  final double endingBalance;
  final double totalReturn;

  const MatexDividendReinvestmentResult({
    this.yearlyReports = const [],
    this.grossDividendPaid = 0,
    this.totalContribution = 0,
    this.netDividendPaid = 0,
    this.startingBalance = 0,
    this.numberOfShares = 0,
    this.endingBalance = 0,
    this.totalReturn = 0,
  });

  @override
  List<Object> get props => [
        totalContribution,
        grossDividendPaid,
        netDividendPaid,
        startingBalance,
        numberOfShares,
        endingBalance,
        yearlyReports,
        totalReturn,
      ];
}
