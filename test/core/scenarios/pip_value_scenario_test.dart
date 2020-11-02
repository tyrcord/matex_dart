import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

void main() {
  group('Feature: User calculating a Pip Value', () {
    group('Scenario: Currency account is listed second within a trading pair',
        () {
      final calculator = pip();

      test('Given: my trading account is in USD', () {
        expect(calculator is MatexPipValueCalculatorCore, equals(true));
      });

      test('And: the currency USD is listed second in the pair EUR/USD', () {
        calculator.baseListedSecond(true);
      });

      test('And: the exchange rate for this pair is 1.25', () {
        calculator.tradingPairExchangeRate(1.25);
      });

      test('When: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$10', () {
        expect(calculator.value(), equals(10));
      });
    });

    group('Scenario: Currency account is listed first within a trading pair',
        () {
      final calculator = pip();

      test('Given: my trading account is in EUR', () {
        expect(calculator is MatexPipValueCalculatorCore, equals(true));
      });

      test('And: the currency EUR is listed first in the pair EUR/CAD', () {
        calculator.baseListedSecond(false); // default value
      });

      test('And: the exchange rate for this pair is 1.25', () {
        calculator.tradingPairExchangeRate(1.25);
      });

      test('When: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$8', () {
        expect(calculator.value(), equals(8));
      });
    });

    group('Scenario: the currency account is not listed within a trading pair',
        () {
      final calculator = pip();

      test('Given: my trading account is in USD', () {
        expect(calculator is MatexPipValueCalculatorCore, equals(true));
      });

      test('And: the exchange rate for the pair AUD/JPY is 100', () {
        calculator.tradingPairExchangeRate(100);
        calculator.pipPrecision(2);
      });

      test('And: the exchange rate for the pair JPY/USD is 0.05', () {
        calculator.baseExchangeRate(0.05);
      });

      test('When: my position size is 100, 000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$50', () {
        expect(calculator.value(), equals(50));
      });
    });
  });
}
