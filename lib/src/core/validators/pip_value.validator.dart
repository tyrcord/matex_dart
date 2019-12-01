import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<PipValueState>> pipValueValidators = [
  (PipValueState state) => state.positionSize > 0,
  (PipValueState state) => state.tradingPairExchangeRate > 0,
];
