import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> matexPipValueValidators = [
  pipValueValidators[0],
  (MatexBaseCoreState state) => state.positionSize > 0,
  (MatexBaseCoreState state) =>
      state.baseCode != null &&
      state.counterCode != null &&
      state.accountCode != null,
];
