import 'package:matex_dart/matex_dart.dart';

const kInitialMatexForexProfitAndLossState = MatexBaseCoreState(
  accountCode: null,
  baseCode: null,
  counterCode: null,
  counterAccountCurrencyPairExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 0.0,
  tradingPairExchangeRate: 0.0,
  position: MatexPosition.long,
  entryPrice: 0,
  exitPrice: 0,
);
