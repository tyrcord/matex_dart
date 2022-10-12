// ignore_for_file: unnecessary_type_check

import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../samples/config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Feature: Calculating the required margin', () {
    final matex = MatexApp(config: testMatexConfig);

    group('Scenario: When the currency account is listed second in a pair', () {
      final calculator = matex.requiredMargin();

      test('Given: my trading account is in USD', () {
        expect(calculator is MatexRequiredMarginCalculator, equals(true));
        calculator.accountCode('USD');
      });

      test('And: the exchange rate for the pair EUR/USD is 1.25', () {
        calculator.currencyPairCode('EUR', 'USD');
      });

      test('And: the position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('When: my leverage is 20:1', () {
        calculator.leverage(20);
      });

      test('Then: the required margin should be \$6,250', () async {
        expect(calculator.isValid, equals(true));
        expect(await calculator.value(), equals(6250));
      });
    });

    group('Scenario: When the currency account is listed first in a pair', () {
      final calculator = matex.requiredMargin();

      test('Given: my trading account is in EUR', () {
        expect(calculator is MatexRequiredMarginCalculator, equals(true));
        calculator.accountCode('EUR');
      });

      test('And: the exchange rate for the pair EUR/CAD is 1.25', () {
        calculator.currencyPairCode('EUR', 'CAD');
      });

      test('And: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('When: my leverage is 20:1', () {
        calculator.leverage(20);
      });

      test('Then: the required margin should be €5000', () async {
        expect(calculator.isValid, equals(true));
        expect(await calculator.value(), equals(5000));
      });
    });

    group('Scenario: When the currency account is not listed in a pair', () {
      final calculator = matex.requiredMargin();

      test('Given: my trading account is in USD', () {
        calculator.accountCode('USD');
        expect(calculator is MatexRequiredMarginCalculator, equals(true));
      });

      test('And: the exchange rate for the pair AUD/JPY is 100', () {
        calculator.currencyPairCode('AUD', 'JPY');
      });

      test('When: my position size is 100, 000', () {
        calculator.positionSize(100000);
      });

      test('When: my leverage is 20:1', () {
        calculator.leverage(20);
      });

      test('Then: the required margin should be \$3,750', () async {
        expect(await calculator.value(), equals(3750));
      });
    });
  });
}
