import 'package:matex_dart/matex_dart.dart' hide positionSize;

const kInitialPositionSizeState = MatexBaseCoreState(
  counterAccountCurrencyPairExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 1.0,
  tradingPairExchangeRate: 0.0,
  accountSize: null,
  amountAtRisk: 0.0,
  entryPrice: 0.0,
  riskRatio: 0.0,
  stopLossPips: 0.0,
  stopLossPrice: 0.0,
);
