import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> matexPipDeltaValidators = [
  (MatexBaseCoreState state) {
    return state.baseCode != null &&
        state.baseCode!.isNotEmpty &&
        state.counterCode != null &&
        state.counterCode!.isNotEmpty;
  },
  ...pipDeltaValidators,
];
