import 'package:matex_dart/matex_dart.dart' hide positionSize;

const kInitialRequiredMarginState = MatexBaseCoreState(
  counterAccountCurrencyPairExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 0.0,
  tradingPairExchangeRate: 0.0,
  leverage: 1.0,
);
