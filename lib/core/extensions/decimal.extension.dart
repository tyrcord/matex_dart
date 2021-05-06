import 'package:decimal/decimal.dart';

//FIXME: https://github.com/dart-lang/language/issues/723

class MatexDecimal {
  static final Decimal two = Decimal.fromInt(2);
  static final Decimal three = Decimal.fromInt(3);
  static final Decimal four = Decimal.fromInt(4);
  static final Decimal hundred = Decimal.fromInt(100);
  static Decimal fromDouble(double value) => Decimal.parse(value.toString());

  static Decimal fromNumber(num value) {
    if (value is int) {
      return Decimal.fromInt(value);
    }

    return fromDouble(value as double);
  }
}
