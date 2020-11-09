import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

const List<double> _kDividers = [12.0, 6.0, 4.0, 2.0];

final List<Decimal> _dividers = _kDividers.map((double divider) {
  return Decimal.parse(divider.toString());
}).toList();

final _multiplier = Decimal.parse('1.1');

MatexPivotPointsResult pivotPointsCamarilla(
  double high,
  double low,
  double close,
) {
  final highParsed = Decimal.parse(high.toString());
  final lowParsed = Decimal.parse(low.toString());
  final closeParsed = Decimal.parse(close.toString());
  final pivotPoint =
      (highParsed + lowParsed + closeParsed) / MatexDecimal.three;

  final resistances = _dividers.map((Decimal divider) {
    return (((highParsed - lowParsed) * _multiplier / divider) + closeParsed)
        .toDouble();
  }).toList();

  final supports = _dividers.map((Decimal divider) {
    return (-((highParsed - lowParsed) * _multiplier / divider) + closeParsed)
        .toDouble();
  }).toList();

  return MatexPivotPointsResult(
    pivotPoint: pivotPoint.toDouble(),
    resistances: resistances,
    supports: supports,
  );
}
