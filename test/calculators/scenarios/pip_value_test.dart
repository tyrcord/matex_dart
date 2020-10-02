import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../samples/config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Feature: Calculating Pip Value', () {
    final matex = MatexApp(config: testMatexConfig);

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
        expect(calculator.getState().baseListedSecond == true, equals(true));
      });
    });

    group(
        'Scenario: When the currency account is listed second in a pair and '
        'switch to a pair where the currency account is listed second in this '
        'pair', () {
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
        expect(calculator.getState().baseListedSecond == true, equals(true));
      });

      test('Given: the exchange rate for the pair USD/AUD is 1.6', () {
        calculator.baseCode('USD').counterCode('AUD');
      });

      test('Then: the pip value should be equal to €6.25', () async {
        expect(await calculator.value(), equals(6.25));
        expect(calculator.getState().baseListedSecond == false, equals(true));
      });
    });

    group('Scenario: When the currency account is listed first in a pair', () {
      final calculator = matex.pipValue();

      test('Given: my trading account is in EUR', () {
        calculator.accountCode('EUR');
        expect(calculator is MatexPipValueCalculator, equals(true));
      });

      test('And: the exchange rate for the pair EUR/CAD is 1.25', () {
        calculator.baseCode('EUR').counterCode('CAD');
      });

      test('When: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to €8', () async {
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

      test('When: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$6.25', () async {
        expect(await calculator.value(), equals(6.25));
      });
    });

    group(
      'Scenario: When the currency account is not listed in a pair and the '
      'currency account changes after the first computation',
      () {
        final calculator = matex.pipValue();

        test('Given: my trading account is in USD', () {
          calculator.accountCode('USD');
          expect(calculator is MatexPipValueCalculator, equals(true));
        });

        test('And: the exchange rate for the pair AUD/JPY is 100', () {
          calculator.baseCode('AUD').counterCode('JPY');
        });

        test('When: my position size is 100,000', () {
          calculator.positionSize(100000);
        });

        test('Then: the pip value should be equal to \$6.25', () async {
          expect(await calculator.value(), equals(6.25));
        });

        test('Given: My trading account switch to EUR', () {
          calculator.accountCode('EUR');
          expect(calculator.getState().accountCode == 'EUR', equals(true));
        });

        test('And: the exchange rate for the pair EUR/CAD is 1.25', () {
          calculator.baseCode('EUR').counterCode('CAD');
        });

        test('Then: the pip value should be equal to €8', () async {
          expect(await calculator.value(), equals(8));
          expect(calculator.getState().baseExchangeRate == 0, equals(true));
          expect(calculator.getState().baseListedSecond == false, equals(true));
        });
      },
    );
  });
}
