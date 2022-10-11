import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';
import 'package:rational/rational.dart';

export './sort.helper.dart';

Decimal toDecimal(dynamic value) {
  assert(value is num || value is Rational || value is String);

  if (value is num) {
    return MatexDecimal.fromNumber(value);
  } else if (value is Rational) {
    return MatexDecimal.fromRational(value);
  }

  return Decimal.parse(value as String);
}
