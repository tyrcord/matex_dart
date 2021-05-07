import 'package:equatable/equatable.dart';

class MatexDividendPayoutRatioResult extends Equatable {
  final double dividendPayoutRatio;

  const MatexDividendPayoutRatioResult({
    this.dividendPayoutRatio = 0,
  });

  @override
  List<double> get props => [dividendPayoutRatio];
}
