import 'package:matex_dart/matex_dart.dart';

const DEFAULT_POSITION_SIZE_RESULTS = MatexPositionSizeResult(
  amountAtRisk: 50,
  pipValue: 0.25,
  positionSize: 2500,
  riskRatio: 1,
);

const DEFAULT_PARTIAL_RESULTS = MatexPositionSizeResult(
  amountAtRisk: 50,
  pipValue: 0,
  positionSize: 0,
  riskRatio: 1,
);
