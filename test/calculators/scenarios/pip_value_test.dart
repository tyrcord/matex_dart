import 'package:matex_dart/matex_dart.dart';
import 'package:test/test.dart';

import '../samples/config.dart';

void main() {
  group('Feature: Calculating Pip Value', () {
    final matex = Matex(config: testMatexConfig);

    group('Scenario: When the currency account is listed second in a pair', () {
      final calculator = matex.pipValue();

      test('Given: my trading account is in USD', () {
        expect(calculator is MatexPipValueCalculator, equals(true));
        calculator.accountCode('USD');
      });

      test('And: USD is listed second in the pair EUR/USD', () {
        calculator.baseCode('EUR').counterCode('USD');
      });

      test('When: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$10', () async {
        expect(await calculator.value(), equals(10));
      });
    });

    group('Scenario: When the currency account is listed first in a pair', () {
      final calculator = matex.pipValue();

      test('Given: my trading account is in EUR', () {
        calculator.accountCode('EUR');
        expect(calculator is MatexPipValueCalculator, equals(true));
      });

      test('And: the exchange rate for this pair is 1.25', () {
        calculator.baseCode('EUR').counterCode('CAD');
      });

      test('When: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$8', () async {
        expect(await calculator.value(), equals(8));
      });
    });

    group('Scenario: When the currency account is not listed in a pair', () {
      final calculator = matex.pipValue();

      test('Given: my trading account is in USD', () {
        calculator.accountCode('USD');
        expect(calculator is MatexPipValueCalculator, equals(true));
      });

      test('And: the exchange rate for the pair AUD/JPY is 100', () {
        calculator.baseCode('AUD').counterCode('JPY');
      });

      test('When: my position size is 100, 000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$6.25', () async {
        expect(await calculator.value(), equals(6.25));
      });
    });
  });
}
