import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> matexRequiredMarginValidators = [
  ...matexPipValueValidators,
  (MatexBaseCoreState state) => state.leverage != null && state.leverage! > 0,
];
