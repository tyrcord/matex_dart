import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<BaseState>> pipValueValidators = [
  (BaseState state) =>
      state.positionSize != null && state.tradingPairExchangeRate != null,
  (BaseState state) =>
      state.positionSize > 0 && state.tradingPairExchangeRate > 0,
];
