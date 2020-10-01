import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

MatexPivotPointsResult pivotPointsDeMark(
  double high,
  double low,
  double close,
  double open,
) {
  final highParsed = Decimal.parse(high.toString());
  final lowParsed = Decimal.parse(low.toString());
  final closeParsed = Decimal.parse(close.toString());
  final decimal2 = Decimal.fromInt(2);
  Decimal pivotPoint;

  if (close < open) {
    pivotPoint = lowParsed * decimal2 + highParsed + closeParsed;
  } else if (close > open) {
    pivotPoint = decimal2 * highParsed + lowParsed + closeParsed;
  } else {
    pivotPoint = closeParsed * decimal2 + highParsed + lowParsed;
  }

  final pivotPointDividedBy2 = pivotPoint / decimal2;
  final pivotPointDividedBy4 = pivotPoint / Decimal.fromInt(4);
  final resistance = pivotPointDividedBy2 - lowParsed;
  final support = pivotPointDividedBy2 - highParsed;

  return MatexPivotPointsResult(
    pivotPoint: pivotPointDividedBy4.toDouble(),
    resistances: [resistance.toDouble()],
    supports: [support.toDouble()],
  );
}
