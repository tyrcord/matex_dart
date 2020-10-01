import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

MatexPivotPointsResult pivotPointsStandard(
  double high,
  double low,
  double close,
) {
  final highParsed = Decimal.parse(high.toString());
  final lowParsed = Decimal.parse(low.toString());
  final closeParsed = Decimal.parse(close.toString());
  final decimal2 = Decimal.fromInt(2);

  final pivotPoint =
      (highParsed + lowParsed + closeParsed) / Decimal.fromInt(3);

  final resistance1 = pivotPoint * decimal2 - lowParsed;
  final resistance2 = pivotPoint + (highParsed - lowParsed);
  final resistance3 = (pivotPoint - lowParsed) * decimal2 + highParsed;

  final support1 = pivotPoint * decimal2 - highParsed;
  final support2 = pivotPoint - (highParsed - lowParsed);
  final support3 = (highParsed - pivotPoint) * (-decimal2) + lowParsed;

  return MatexPivotPointsResult(
    pivotPoint: pivotPoint.toDouble(),
    resistances: [
      resistance1.toDouble(),
      resistance2.toDouble(),
      resistance3.toDouble(),
    ],
    supports: [
      support1.toDouble(),
      support2.toDouble(),
      support3.toDouble(),
    ],
  );
}