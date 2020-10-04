import 'package:matex_dart/matex_dart.dart' hide positionSize;

const kInitialStopLossTakeProfitState = MatexBaseCoreState(
  baseExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 0.0,
  tradingPairExchangeRate: 0.0,
  entryPrice: 0.0,
  position: MatexPosition.Long,
  takeProfitAmount: 0.0,
  takeProfitPips: 0.0,
  takeProfitPrice: 0.0,
  stopLossAmount: 0.0,
  stopLossPips: 0.0,
  stopLossPrice: 0.0,
);
