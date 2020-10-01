import 'package:equatable/equatable.dart';

const kEmptyStopLossResult = MatexStopLossResult();
const kEmptyTakeProfitResult = MatexTakeProfitResult();
const kEmptyStopLossTakeProfitResult = MatexStopLossTakeProfitResult();

class MatexStopLossResult extends Equatable {
  final double amount;
  final double pips;
  final double price;

  const MatexStopLossResult({
    this.amount = 0.0,
    this.pips = 0.0,
    this.price = 0.0,
  }) : super();

  @override
  List<Object> get props => [
        amount,
        pips,
        price,
      ];
}

class MatexTakeProfitResult extends Equatable {
  final double amount;
  final double pips;
  final double price;

  const MatexTakeProfitResult({
    this.amount = 0.0,
    this.pips = 0.0,
    this.price = 0.0,
  }) : super();

  @override
  List<Object> get props => [
        amount,
        pips,
        price,
      ];
}

class MatexStopLossTakeProfitResult extends Equatable {
  final double pipValue;
  final double riskRewardRatio;
  final MatexStopLossResult stopLoss;
  final MatexTakeProfitResult takeProfit;

  const MatexStopLossTakeProfitResult({
    this.pipValue = 0.0,
    this.riskRewardRatio = 0.0,
    this.stopLoss = kEmptyStopLossResult,
    this.takeProfit = kEmptyTakeProfitResult,
  }) : super();

  @override
  List<Object> get props => [
        pipValue,
        riskRewardRatio,
        stopLoss,
        takeProfit,
      ];

  MatexStopLossTakeProfitResult clone() {
    return MatexStopLossTakeProfitResult(
      pipValue: pipValue,
      riskRewardRatio: riskRewardRatio,
      stopLoss: stopLoss,
      takeProfit: takeProfit,
    );
  }
}
