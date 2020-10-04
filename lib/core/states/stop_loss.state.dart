import 'package:matex_dart/matex_dart.dart' hide positionSize;

const kInitialStopLossState = MatexBaseCoreState(
  baseExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 0.0,
  tradingPairExchangeRate: 0.0,
  entryPrice: 0.0,
  position: MatexPosition.Long,
  stopLossAmount: 0.0,
  stopLossPips: 0.0,
  stopLossPrice: 0.0,
);
