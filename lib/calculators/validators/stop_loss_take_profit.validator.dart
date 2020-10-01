import 'package:matex_dart/matex_dart.dart';

final List<StateValidator> matexStopLossTakeProfitValidators = [
  ...stopLossTakeProfitValidators,
  ...matexPipValueValidators,
];
