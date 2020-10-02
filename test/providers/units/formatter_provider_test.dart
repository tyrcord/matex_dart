import 'package:flutter_test/flutter_test.dart';

import 'package:matex_dart/matex_dart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FormatterProvider', () {
    MatexFormatterProvider formatter;

    setUp(() {
      formatter = MatexFormatterProvider();
    });

    group('formatInstrument()', () {
      test('should format a currency according to a locale and an instrument',
          () {
        expect(
          formatter.formatInstrument(
            value: 10000,
            code: 'EUR',
            locale: 'en-US',
          ),
          completion(equals(
            '€10,000.000',
          )),
        );
        expect(
          formatter.formatInstrument(
            value: 10000,
            code: 'EUR',
            locale: 'fr-FR',
          ),
          completion(equals(
            '10 000,000 €',
          )),
        );
      });
    });

    group('formatQuote()', () {
      test('should format a quote according to a locale and an instrument', () {
        expect(
          formatter.formatQuote(
            value: 1.4255,
            pair: 'EURUSD',
            locale: 'en-US',
          ),
          completion(equals(
            '1.42550',
          )),
        );
      });
    });
  });
}
