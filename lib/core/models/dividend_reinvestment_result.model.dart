import 'package:equatable/equatable.dart';

import 'package:matex_dart/matex_dart.dart';

class MatexDividendReinvestmentResult extends Equatable {
  final List<MatexDividendReinvestementYearlyPayoutReport> yearlyReports;
  final double cumulativeGrossAmount;
  final double cumulativeNetAmount;
  final double numberOfShares;
  final double endingBalance;

  const MatexDividendReinvestmentResult({
    this.yearlyReports = const [],
    this.cumulativeGrossAmount = 0,
    this.cumulativeNetAmount = 0,
    this.numberOfShares = 0,
    this.endingBalance = 0,
  });

  @override
  List<Object> get props => [
        cumulativeGrossAmount,
        cumulativeNetAmount,
        numberOfShares,
        endingBalance,
        yearlyReports,
      ];
}
