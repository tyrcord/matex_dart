import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> matexPipDeltaValidators = [
  (MatexBaseCoreState state) {
    return state.counterCode != null && state.baseCode != null;
  },
  ...pipDeltaValidators,
];
