import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<PipValueState>> pipValueValidators = [
  (PipValueState state) => state.positionSize != null && state.positionSize > 0,
  (PipValueState state) =>
      state.tradingPairExchangeRate != null &&
      state.tradingPairExchangeRate > 0,
];
