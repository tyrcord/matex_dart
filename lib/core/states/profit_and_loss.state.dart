import 'package:matex_dart/matex_dart.dart' hide positionSize;

const kInitialProfitAndLossState = MatexBaseCoreState(
  position: MatexPosition.long,
  positionSize: 0,
  entryPrice: 0,
  exitPrice: 0,
  taxeRate: 0,
);
