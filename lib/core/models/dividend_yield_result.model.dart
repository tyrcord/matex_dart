import 'package:equatable/equatable.dart';

class MatexDividendYieldResult extends Equatable {
  final double dividendYield;

  const MatexDividendYieldResult({
    this.dividendYield = 0,
  });

  @override
  List<double> get props => [dividendYield];
}
