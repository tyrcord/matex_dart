import 'package:matex_dart/matex_dart.dart';

final List<StateValidator> matexPipValueValidators = [
  (BaseState state) => state.positionSize != null && state.positionSize > 0,
  (BaseState state) =>
      state.baseCode != null &&
      state.counterCode != null &&
      state.accountCode != null,
];
