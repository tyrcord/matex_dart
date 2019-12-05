import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<BaseState>> pipValueValidators = [
  (BaseState state) => state.positionSize != null && state.positionSize > 0,
  (BaseState state) =>
      state.positionSize != null && state.tradingPairExchangeRate > 0,
];
