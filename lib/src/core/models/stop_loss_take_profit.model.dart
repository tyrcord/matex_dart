class StopLossResult {
  num amount;
  num pips;
  num price;
}

class TakeProfitResult extends StopLossResult {}

class StopLossTakeProfitResult {
  num pipValue;
  num riskRewardRatio;
  StopLossResult stopLoss;
  TakeProfitResult takeProfit;
}
