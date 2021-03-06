import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> pipValueValidators = [
  (MatexBaseCoreState state) =>
      state.positionSize != null &&
      state.tradingPairExchangeRate != null &&
      state.counterAccountCurrencyPairExchangeRate != null,
  (MatexBaseCoreState state) =>
      state.positionSize! > 0 && state.tradingPairExchangeRate! > 0,
];
