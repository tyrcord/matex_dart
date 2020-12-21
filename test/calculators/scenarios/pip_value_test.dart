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
        calculator.currencyPairCode('EUR', 'USD');
      });

      test('When: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$10', () async {
        expect(await calculator.value(), equals(10));
        expect(calculator.getState().baseListedSecond, equals(true));
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
        calculator.currencyPairCode('EUR', 'USD');
      });

      test('When: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$10', () async {
        expect(await calculator.value(), equals(10));
        expect(calculator.getState().baseListedSecond, equals(true));
      });

      test('Given: the exchange rate for the pair USD/AUD is 1.6', () {
        calculator.currencyPairCode('USD', 'AUD');
      });

      test('Then: the pip value should be equal to €7.5', () async {
        expect(await calculator.value(), equals(7.5));
        expect(!calculator.getState().baseListedSecond, equals(true));
      });
    });

    group('Scenario: When the currency account is listed first in a pair', () {
      final calculator = matex.pipValue();

      test('Given: my trading account is in EUR', () {
        calculator.accountCode('EUR');
        expect(calculator is MatexPipValueCalculator, equals(true));
      });

      test('And: the exchange rate for the pair EUR/CAD is 1.25', () {
        calculator.currencyPairCode('EUR', 'CAD');
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
        calculator.currencyPairCode('AUD', 'JPY');
      });

      test('When: my position size is 100,000', () {
        calculator.positionSize(100000);
      });

      test('Then: the pip value should be equal to \$7.5', () async {
        expect(await calculator.value(), equals(7.5));
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
          calculator.currencyPairCode('AUD', 'JPY');
        });

        test('When: my position size is 100,000', () {
          calculator.positionSize(100000);
        });

        test('Then: the pip value should be equal to \$7.5', () async {
          expect(await calculator.value(), equals(7.5));
        });

        test('Given: My trading account switch to EUR', () {
          calculator.accountCode('EUR');
          expect(calculator.getState().accountCode == 'EUR', equals(true));
        });

        test('And: the exchange rate for the pair EUR/CAD is 1.25', () {
          calculator.currencyPairCode('EUR', 'CAD');
        });

        test('Then: the pip value should be equal to €8', () async {
          expect(await calculator.value(), equals(8));
          expect(
              calculator.getState().counterAccountCurrencyPairExchangeRate == 0,
              equals(true));
          expect(!calculator.getState().baseListedSecond, equals(true));
        });
      },
    );

    group(
      'Scenario: When a default currency account is set '
      'Then the default value should be used when the calculator is reset',
      () {
        final calculator = matex.pipValue();

        test('Given: my default account currency is USD', () {
          calculator.setDefaultState(
            kInitialMatexPipValueState.copyWith(accountCode: 'USD'),
          );

          expect(calculator is MatexPipValueCalculator, equals(true));
          expect(calculator.getState().accountCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(false));
        });

        test('And: I set my account currency to EUR', () {
          calculator.accountCode('EUR');
          expect(calculator.getState().accountCode == 'EUR', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('When: I reset the calculator', () {
          calculator.reset();
        });

        test('Then: my default account currency should be set', () async {
          expect(calculator.getState().accountCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(false));
        });
      },
    );

    group(
      'Scenario: When a default currency pair is set '
      'Then the default value should be used when the calculator is reset',
      () {
        final calculator = matex.pipValue();

        test('Given: my default currency pair is EUR/USD', () {
          calculator.setDefaultState(
            kInitialMatexPipValueState.copyWith(
              baseCode: 'EUR',
              counterCode: 'USD',
            ),
          );

          expect(calculator is MatexPipValueCalculator, equals(true));
          expect(calculator.getState().baseCode == 'EUR', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(false));
        });

        test('And: I set my currency pair to AUD/USD', () {
          calculator.currencyPairCode('AUD', 'USD');
          expect(calculator.getState().baseCode == 'AUD', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('When: I reset the calculator', () {
          calculator.reset();
        });

        test('Then: my default currency pair should be set', () async {
          expect(calculator.getState().baseCode == 'EUR', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(false));
        });
      },
    );

    group(
      'Scenario: When a default currency pair and an account currency are set '
      'Then the default values should be used when the calculator is reset',
      () {
        final calculator = matex.pipValue();

        test(
          'Given: my default currency pair is EUR/USD and '
          'my account currency to USD',
          () {
            calculator.setDefaultState(
              kInitialMatexPipValueState.copyWith(
                accountCode: 'USD',
                baseCode: 'EUR',
                counterCode: 'USD',
              ),
            );

            expect(calculator is MatexPipValueCalculator, equals(true));
            expect(calculator.getState().accountCode == 'USD', equals(true));
            expect(calculator.getState().baseCode == 'EUR', equals(true));
            expect(calculator.getState().counterCode == 'USD', equals(true));
            expect(calculator.isDirty, equals(false));
          },
        );

        test('And: I set my account currency to EUR', () {
          calculator.accountCode('EUR');
          expect(calculator.getState().accountCode == 'EUR', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('And: I set my currency pair to AUD/USD', () {
          calculator.currencyPairCode('AUD', 'USD');

          expect(calculator.getState().baseCode == 'AUD', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('When: I reset the calculator', () {
          calculator.reset();
        });

        test('Then: my default currency pair should be set', () async {
          expect(calculator.getState().accountCode == 'USD', equals(true));
          expect(calculator.getState().baseCode == 'EUR', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(false));
        });
      },
    );

    group(
      'Scenario: When a default currency pair and an account currency are set '
      'And the default values are changed'
      'Then the default values should be used when the calculator is reset',
      () {
        final calculator = matex.pipValue();

        test(
          'Given: my default currency pair is EUR/USD and '
          'my account currency to USD',
          () {
            calculator.setDefaultState(
              kInitialMatexPipValueState.copyWith(
                accountCode: 'USD',
                baseCode: 'EUR',
                counterCode: 'USD',
              ),
            );

            expect(calculator is MatexPipValueCalculator, equals(true));
            expect(calculator.getState().accountCode == 'USD', equals(true));
            expect(calculator.getState().baseCode == 'EUR', equals(true));
            expect(calculator.getState().counterCode == 'USD', equals(true));
            expect(calculator.isDirty, equals(false));
          },
        );

        test('And: I set my account currency to EUR', () {
          calculator.accountCode('EUR');
          expect(calculator.getState().accountCode == 'EUR', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('And: I set my default account currency to EUR', () {
          calculator.setDefaultState(
            kInitialMatexPipValueState.copyWith(
              accountCode: 'EUR',
              baseCode: 'EUR',
              counterCode: 'USD',
            ),
          );

          expect(calculator.getState().accountCode == 'EUR', equals(true));
          expect(calculator.isDirty, equals(false));
        });

        test('And: I set my currency pair to AUD/USD', () {
          calculator.currencyPairCode('AUD', 'USD');

          expect(calculator.getState().baseCode == 'AUD', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('When: I reset the calculator', () {
          calculator.reset();
        });

        test('Then: my default currency pair should be set', () async {
          expect(calculator.getState().accountCode == 'EUR', equals(true));
          expect(calculator.getState().baseCode == 'EUR', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(false));
        });
      },
    );

    group(
      'Scenario: When a default currency pair and an account currency are set '
      'And my default account currency value is reset'
      'Then the default values should be used when the calculator is reset',
      () {
        final calculator = matex.pipValue();

        test(
          'Given: my default currency pair is EUR/USD and '
          'my account currency to EUR',
          () {
            calculator.setDefaultState(
              kInitialMatexPipValueState.copyWith(
                accountCode: 'EUR',
                baseCode: 'EUR',
                counterCode: 'USD',
              ),
            );

            expect(calculator is MatexPipValueCalculator, equals(true));
            expect(calculator.getState().accountCode == 'EUR', equals(true));
            expect(calculator.getState().baseCode == 'EUR', equals(true));
            expect(calculator.getState().counterCode == 'USD', equals(true));
            expect(calculator.isDirty, equals(false));
          },
        );

        test('And: I set my account currency to USD', () {
          calculator.accountCode('USD');
          expect(calculator.getState().accountCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('And: I clear my default account currency', () {
          calculator.setDefaultState(
            kInitialMatexPipValueState.copyWith(
              baseCode: 'EUR',
              counterCode: 'USD',
            ),
          );

          expect(calculator.getState().accountCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('When: I reset the calculator', () {
          calculator.reset();
        });

        test('Then: my default currency pair should be set', () async {
          expect(calculator.getState().accountCode == null, equals(true));
          expect(calculator.getState().baseCode == 'EUR', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(false));
        });
      },
    );

    group(
      'Scenario: When a default currency pair and an account currency are set '
      'and my default currency pair value is reset '
      'then the default values should be used when the calculator is reset',
      () {
        final calculator = matex.pipValue();

        test(
          'Given: my default currency pair is EUR/USD and '
          'my account currency to EUR',
          () {
            calculator.setDefaultState(
              kInitialMatexPipValueState.copyWith(
                accountCode: 'EUR',
                baseCode: 'EUR',
                counterCode: 'USD',
              ),
            );

            expect(calculator is MatexPipValueCalculator, equals(true));
            expect(calculator.getState().accountCode == 'EUR', equals(true));
            expect(calculator.getState().baseCode == 'EUR', equals(true));
            expect(calculator.getState().counterCode == 'USD', equals(true));
            expect(calculator.isDirty, equals(false));
          },
        );
        test('And: I set my currency pair to AUD/USD', () {
          calculator.currencyPairCode('AUD', 'USD');

          expect(calculator.getState().baseCode == 'AUD', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('And: I clear my default currency pair', () {
          calculator.setDefaultState(
            kInitialMatexPipValueState.copyWith(
              accountCode: 'EUR',
            ),
          );

          expect(calculator.getState().baseCode == 'AUD', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('When: I reset the calculator', () {
          calculator.reset();
        });

        test('Then: my default currency pair should be set', () async {
          expect(calculator.getState().accountCode == 'EUR', equals(true));
          expect(calculator.getState().baseCode == null, equals(true));
          expect(calculator.getState().counterCode == null, equals(true));
          expect(calculator.isDirty, equals(false));
        });
      },
    );

    group(
      'Scenario: When a default currency pair and an account currency are set '
      'And the my default account currency value is reset, '
      'but my currency pair is set'
      'Then the default values should be used when the calculator is reset',
      () {
        final calculator = matex.pipValue();

        test(
          'Given: my default currency pair is EUR/USD and '
          'my account currency to EUR',
          () {
            calculator.setDefaultState(
              kInitialMatexPipValueState.copyWith(
                accountCode: 'EUR',
                baseCode: 'EUR',
                counterCode: 'USD',
              ),
            );

            expect(calculator is MatexPipValueCalculator, equals(true));
            expect(calculator.getState().accountCode == 'EUR', equals(true));
            expect(calculator.getState().baseCode == 'EUR', equals(true));
            expect(calculator.getState().counterCode == 'USD', equals(true));
            expect(calculator.isDirty, equals(false));
          },
        );

        test('And: I set my currency pair to AUD/USD', () {
          calculator.currencyPairCode('AUD', 'USD');

          expect(calculator.getState().baseCode == 'AUD', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('And: I clear my default account currency', () {
          calculator.setDefaultState(
            kInitialMatexPipValueState.copyWith(
              baseCode: 'EUR',
              counterCode: 'USD',
            ),
          );

          expect(calculator.getState().accountCode == null, equals(true));
          expect(calculator.getState().baseCode == 'AUD', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('When: I reset the calculator', () {
          calculator.reset();
        });

        test('Then: my default currency pair should be set', () async {
          expect(calculator.getState().accountCode == null, equals(true));
          expect(calculator.getState().baseCode == 'EUR', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(false));
        });
      },
    );

    group(
      'Scenario: When a default currency pair and an account currency are set '
      'And the my default values are reset, '
      'Then the default values should be used when the calculator is reset',
      () {
        final calculator = matex.pipValue();

        test(
          'Given: my default currency pair is EUR/USD and '
          'my account currency to EUR',
          () {
            calculator.setDefaultState(
              kInitialMatexPipValueState.copyWith(
                accountCode: 'EUR',
                baseCode: 'EUR',
                counterCode: 'USD',
              ),
            );

            expect(calculator is MatexPipValueCalculator, equals(true));
            expect(calculator.getState().accountCode == 'EUR', equals(true));
            expect(calculator.getState().baseCode == 'EUR', equals(true));
            expect(calculator.getState().counterCode == 'USD', equals(true));
            expect(calculator.isDirty, equals(false));
          },
        );

        test('And: I set my account currency to USD', () {
          calculator.accountCode('USD');
          expect(calculator.getState().accountCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('And: I set my currency pair to AUD/USD', () {
          calculator.currencyPairCode('AUD', 'USD');

          expect(calculator.getState().baseCode == 'AUD', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('And: I clear my default account currency', () {
          calculator.setDefaultState(kInitialMatexPipValueState);

          expect(calculator.getState().accountCode == 'USD', equals(true));
          expect(calculator.getState().baseCode == 'AUD', equals(true));
          expect(calculator.getState().counterCode == 'USD', equals(true));
          expect(calculator.isDirty, equals(true));
        });

        test('When: I reset the calculator', () {
          calculator.reset();
        });

        test('Then: my default currency pair should be set', () async {
          expect(calculator.getState().accountCode == null, equals(true));
          expect(calculator.getState().baseCode == null, equals(true));
          expect(calculator.getState().counterCode == null, equals(true));
          expect(calculator.isDirty, equals(false));
        });
      },
    );

    group('Scenario: When the currency pair is XAU/JPY', () {
      final calculator = matex.pipValue();

      test('Given: my trading account is in EUR', () {
        expect(calculator is MatexPipValueCalculator, equals(true));
        calculator.accountCode('EUR');
      });

      test('And: EUR is not listed second in the pair XAU/JPY', () {
        calculator.currencyPairCode('XAU', 'JPY');
      });

      test('When: my position size is 100', () {
        calculator.positionSize(100);
      });

      test('Then: the pip value should be equal to 50€', () async {
        expect(await calculator.value(), equals(50));
      });
    });
  });
}
