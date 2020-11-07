import 'package:matex_dart/matex_dart.dart';

final List<MatexStateValidator> matexStopLossTakeProfitValidators = [
  ...coreStopLossTakeProfitValidators,
  ...matexPipValueValidators,
];
