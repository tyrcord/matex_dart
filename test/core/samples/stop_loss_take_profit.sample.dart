import 'package:matex_dart/matex_dart.dart';

const DEFAULT_TAKE_PROFIT_UP = MatexTakeProfitResult(
  amount: 400,
  pips: 400,
  price: 1.14,
);

const DEFAULT_STOP_LOSS_UP = MatexStopLossResult(
  amount: 200,
  pips: 200,
  price: 1.08,
);

const DEFAULT_STOP_LOSS_TAKE_PROFIT_UP = MatexStopLossTakeProfitResult(
  pipValue: 1,
  riskRewardRatio: 2,
  stopLoss: DEFAULT_STOP_LOSS_UP,
  takeProfit: DEFAULT_TAKE_PROFIT_UP,
);

const DEFAULT_TAKE_PROFIT_DOWN = MatexTakeProfitResult(
  amount: 400,
  pips: 400,
  price: 1.06,
);

const DEFAULT_STOP_LOSS_DOWN = MatexStopLossResult(
  amount: 200,
  pips: 200,
  price: 1.12,
);

const DEFAULT_STOP_LOSS_TAKE_PROFIT_DOWN = MatexStopLossTakeProfitResult(
  pipValue: 1,
  riskRewardRatio: 2,
  stopLoss: DEFAULT_STOP_LOSS_DOWN,
  takeProfit: DEFAULT_TAKE_PROFIT_DOWN,
);

const DEFAULT_TAKE_PROFIT_EMPTY = MatexTakeProfitResult(
  amount: 0,
  pips: 0,
  price: 0,
);

const DEFAULT_STOP_LOSS_EMPTY = MatexStopLossResult(
  amount: 0,
  pips: 0,
  price: 0,
);

const DEFAULT_STOP_LOSS_TAKE_PROFIT_EMPTY = MatexStopLossTakeProfitResult(
  pipValue: 0,
  riskRewardRatio: 0,
  stopLoss: DEFAULT_STOP_LOSS_EMPTY,
  takeProfit: DEFAULT_TAKE_PROFIT_EMPTY,
);
