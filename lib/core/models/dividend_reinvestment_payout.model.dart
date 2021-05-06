import 'package:equatable/equatable.dart';

class MatexDividendReinvestementPayout extends Equatable {
  final double grossDividendPayout;
  final double netDividendPayout;

  MatexDividendReinvestementPayout({
    this.grossDividendPayout = 0,
    this.netDividendPayout = 0,
  });

  @override
  List<dynamic> get props => [
        grossDividendPayout,
        netDividendPayout,
      ];
}
