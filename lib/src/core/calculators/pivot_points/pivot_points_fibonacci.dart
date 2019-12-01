import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

final _fibonacci382 = Decimal.parse('0.382');
final _fibonacci618 = Decimal.parse('0.618');

PivotPointsResult pivotPointsFibonacci(
  double high,
  double low,
  double close,
) {
  final highParsed = Decimal.parse(high.toString());
  final lowParsed = Decimal.parse(low.toString());
  final closeParsed = Decimal.parse(close.toString());

  final pivotPoint =
      (highParsed + lowParsed + closeParsed) / Decimal.fromInt(3);
  final delta = highParsed - lowParsed;

  final resistance1 = pivotPoint + (delta * _fibonacci382);
  final resistance2 = pivotPoint + (delta * _fibonacci618);
  final resistance3 = pivotPoint + delta;

  final support1 = pivotPoint - (delta * _fibonacci382);
  final support2 = pivotPoint - (delta * _fibonacci618);
  final support3 = pivotPoint - delta;

  return PivotPointsResult(
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
