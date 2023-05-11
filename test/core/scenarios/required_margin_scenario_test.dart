// ignore_for_file: unnecessary_type_check

import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

void main() {
  group('Feature: Calculating the required margin', () {
    group('Scenario: the currency account is listed second in a pair', () {
      final calculator = requiredMargin();

      test('Given: my trading account is in USD', () {
        expect(calculator is MatexRequiredMarginCalculatorCore, equals(true));
      });

      test('And: the exchange rate for the pair EUR/USD is 1.25', () {
        calculator.tradingPairExchangeRate(1.25);
        calculator.baseListedSecond(true);
      });

      test('And: the position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('When: my leverage is 20:1', () {
        calculator.leverage(20);
      });

      test('Then: the required margin should be \$6,250', () {
        expect(calculator.isValid, equals(true));
        expect(calculator.value(), equals(6250));
      });
    });

    group('Scenario: the currency account is listed first in a pair', () {
      final calculator = requiredMargin();

      test('Given: my trading account is in EUR', () {
        expect(calculator is MatexRequiredMarginCalculatorCore, equals(true));
      });

      test('And: the exchange rate for the pair EUR/CAD is 1.25', () {
        calculator.tradingPairExchangeRate(1);
      });

      test('And: the position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('When: my leverage is 20:1', () {
        calculator.leverage(20);
      });

      test('Then: the required margin should be €5000', () {
        expect(calculator.isValid, equals(true));
        expect(calculator.value(), equals(5000));
      });
    });

    group('Scenario: the currency account is not listed in a pair', () {
      final calculator = requiredMargin();

      test('Given: my trading account is in USD', () {
        expect(calculator is MatexRequiredMarginCalculatorCore, equals(true));
      });

      test('And: the exchange rate for the pair AUD/JPY is 100', () {
        calculator.counterAccountCurrencyPairExchangeRate(0.0075); // JPY/USD
        calculator.tradingPairExchangeRate(100); // AUD/JPY
      });

      test('When: my position size is 100, 000', () {
        calculator.positionSize(100000);
      });

      test('And: my leverage is 20:1', () {
        calculator.leverage(20);
      });

      test('Then: the required margin should be \$3,750', () {
        expect(calculator.value(), equals(3750));
      });
    });
  });
}
