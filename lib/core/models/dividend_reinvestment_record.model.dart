import 'package:equatable/equatable.dart';

class MatexDividendReinvestementRecord extends Equatable {
  final double dividendAmount;
  final double numberOfshares;

  MatexDividendReinvestementRecord({
    this.dividendAmount = 0,
    this.numberOfshares = 0,
  });

  @override
  List<double> get props => [
        dividendAmount,
        numberOfshares,
      ];
}
