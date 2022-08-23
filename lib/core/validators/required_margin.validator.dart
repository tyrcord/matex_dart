import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> requiredMarginValidators = [
  ...pipValueValidators,
  (MatexBaseCoreState state) => state.leverage != null && state.leverage! > 0,
];
