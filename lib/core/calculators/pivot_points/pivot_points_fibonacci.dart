import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

final _fibonacci382 = Decimal.parse('0.382');
final _fibonacci618 = Decimal.parse('0.618');

MatexPivotPointsResult pivotPointsFibonacci(
  double high,
  double low,
  double close,
) {
  final highParsed = Decimal.parse(high.toString());
  final lowParsed = Decimal.parse(low.toString());
  final closeParsed = Decimal.parse(close.toString());

  final pivotPoint =
      (highParsed + lowParsed + closeParsed) / MatexDecimal.three;
  final delta = highParsed - lowParsed;

  final resistance1 = pivotPoint + (delta * _fibonacci382);
  final resistance2 = pivotPoint + (delta * _fibonacci618);
  final resistance3 = pivotPoint + delta;

  final support1 = pivotPoint - (delta * _fibonacci382);
  final support2 = pivotPoint - (delta * _fibonacci618);
  final support3 = pivotPoint - delta;

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
