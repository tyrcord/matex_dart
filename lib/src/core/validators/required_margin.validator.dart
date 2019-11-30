import 'package:matex_dart/matex_dart.dart';

final List<StateValidator<RequiredMarginState>> requiredMarginValidators = [
  (RequiredMarginState state) =>
      state.positionSize != null && state.positionSize > 0,
  (RequiredMarginState state) =>
      state.tradingPairExchangeRate != null &&
      state.tradingPairExchangeRate > 0,
];
