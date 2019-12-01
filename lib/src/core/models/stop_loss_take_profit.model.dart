import 'package:equatable/equatable.dart';

const kEmptyStopLossResult = StopLossResult();
const kEmptyTakeProfitResult = TakeProfitResult();
const kEmptyStopLossTakeProfitResult = StopLossTakeProfitResult();

class StopLossResult extends Equatable {
  final double amount;
  final double pips;
  final double price;

  const StopLossResult({
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

class TakeProfitResult extends Equatable {
  final double amount;
  final double pips;
  final double price;

  const TakeProfitResult({
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

class StopLossTakeProfitResult extends Equatable {
  final double pipValue;
  final double riskRewardRatio;
  final StopLossResult stopLoss;
  final TakeProfitResult takeProfit;

  const StopLossTakeProfitResult({
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

  StopLossTakeProfitResult clone() {
    return StopLossTakeProfitResult(
      pipValue: pipValue,
      riskRewardRatio: riskRewardRatio,
      stopLoss: stopLoss,
      takeProfit: takeProfit,
    );
  }
}
