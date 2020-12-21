import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../samples/stop_loss_take_profit.sample.dart';

void main() {
  group('Feature: Define SL & TP values', () {
    group('Scenario: the position is long', () {
      final calculator = stopLossTakeProfit();

      test('Given: my trading account is in USD', () {
        expect(
          calculator is MatexStopLossTakeProfitCalculatorCore,
          equals(true),
        );
      });

      test('And: USD is listed second in the pair EUR/USD', () {
        calculator.baseListedSecond(true);
      });

      test('And: the exchange rate for this pair is 1.10', () {
        calculator.tradingPairExchangeRate(1.1);
      });

      test('And: my entry price is 1.10', () {
        calculator.entryPrice(1.1);
      });

      test('And: my position size is 10,000', () {
        calculator.positionSize(10000);
      });

      test("And: i'm willing to loss \$200", () {
        calculator.stopLossAmount(200);
      });

      test("And: i'm willing to gain \$400", () {
        calculator.takeProfitAmount(400);
      });

      test('When: my position is buying', () {
        calculator.position(MatexPosition.long);
      });

      test(
        'Then:I should take my profit at 1.14 or accept my loss at 1.08',
        () {
          expect(
            calculator.value() == DEFAULT_STOP_LOSS_TAKE_PROFIT_UP,
            equals(true),
          );
        },
      );
    });

    group('Scenario:  a position is short', () {
      final calculator = stopLossTakeProfit();

      test('Given: my trading account is in USD', () {
        expect(
          calculator is MatexStopLossTakeProfitCalculatorCore,
          equals(true),
        );
      });

      test('And: USD is listed second in the pair EUR/USD', () {
        calculator.baseListedSecond(true);
      });

      test('And: the exchange rate for this pair is 1.10', () {
        calculator.tradingPairExchangeRate(1.1);
      });

      test('And: my entry price is 1.10', () {
        calculator.entryPrice(1.1);
      });

      test('And: my position size is 10,000', () {
        calculator.positionSize(10000);
      });

      test("And: i'm willing to loss \$200", () {
        calculator.stopLossAmount(200);
      });

      test("And: i'm willing to gain \$400", () {
        calculator.takeProfitAmount(400);
      });

      test('When: my position is short', () {
        calculator.position(MatexPosition.short);
      });

      test('Then:I should take my profit at 1.06 or accept my loss at 1.12',
          () {
        expect(
          calculator.value() == DEFAULT_STOP_LOSS_TAKE_PROFIT_DOWN,
          equals(true),
        );
      });
    });

    group(
      'Scenario: the position is short and '
      'when the currency account is listed first in a pair',
      () {
        final calculator = stopLossTakeProfit();

        test('Given: my trading account is in EUR', () {
          expect(
            calculator is MatexStopLossTakeProfitCalculatorCore,
            equals(true),
          );
        });

        test('And: EUR is listed first in the pair EUR/CAD', () {
          calculator.baseListedSecond(false);
        });

        test('And: the exchange rate for this pair is 1.25', () {
          calculator.tradingPairExchangeRate(1.25);
        });

        test('And: my entry price is 1.255', () {
          calculator.entryPrice(1.255);
        });

        test('And: my position size is 10,000', () {
          calculator.positionSize(10000);
        });

        test("And: i'm willing to loss 200€", () {
          calculator.stopLossAmount(200);
        });

        test("And: i'm willing to gain 400€", () {
          calculator.takeProfitAmount(400);
        });

        test('When: my position is short', () {
          calculator.position(MatexPosition.short);
        });

        test('Then: I should take my profit at 1.205 or accept my loss at 1.28',
            () {
          expect(
            calculator.value() ==
                MatexStopLossTakeProfitResult(
                  pipValue: 0.8,
                  riskRewardRatio: 2,
                  stopLoss: MatexStopLossResult(
                    amount: 200,
                    pips: 250,
                    price: 1.28,
                  ),
                  takeProfit: MatexTakeProfitResult(
                    amount: 400,
                    pips: 500,
                    price: 1.205,
                  ),
                ),
            equals(true),
          );
        });
      },
    );

    group(
      'Scenario: the position is long and '
      'when the currency account is listed first in a pair',
      () {
        final calculator = stopLossTakeProfit();

        test('Given: my trading account is in EUR', () {
          expect(calculator is MatexStopLossTakeProfitCalculatorCore,
              equals(true));
        });

        test('And: EUR is listed first in the pair EUR/CAD', () {
          calculator.baseListedSecond(false);
        });

        test('And: the exchange rate for this pair is 1.25', () {
          calculator.tradingPairExchangeRate(1.25);
        });

        test('And: my entry price is 1.255', () {
          calculator.entryPrice(1.255);
        });

        test('And: my position size is 10,000', () {
          calculator.positionSize(10000);
        });

        test("And: i'm willing to loss 200€", () {
          calculator.stopLossAmount(200);
        });

        test("And: i'm willing to gain 400€", () {
          calculator.takeProfitAmount(400);
        });

        test('When: my position is long', () {
          calculator.position(MatexPosition.long);
        });

        test('Then:I should take my profit at 1.06 or accept my loss at 1.12',
            () {
          expect(
            calculator.value() ==
                MatexStopLossTakeProfitResult(
                  pipValue: 0.8,
                  riskRewardRatio: 2,
                  stopLoss: MatexStopLossResult(
                    amount: 200,
                    pips: 250,
                    price: 1.23,
                  ),
                  takeProfit: MatexTakeProfitResult(
                    amount: 400,
                    pips: 500,
                    price: 1.305,
                  ),
                ),
            equals(true),
          );
        });
      },
    );

    group(
      'Scenario: the position is long and '
      'when the currency account is not listed in a pair',
      () {
        final calculator = stopLossTakeProfit();

        test('Given: my trading account is in USD', () {
          expect(calculator is MatexStopLossTakeProfitCalculatorCore,
              equals(true));
        });

        test('And: the exchange rate for the pair AUD/JPY is 100', () {
          calculator.tradingPairExchangeRate(100);
          calculator.pipPrecision(2);
        });

        test('And: the exchange rate for the pair JPY/USD is 0.05', () {
          calculator.counterAccountCurrencyPairExchangeRate(0.05);
        });

        test('And: my entry price is 100', () {
          calculator.entryPrice(100);
        });

        test('And: my position size is 10,000', () {
          calculator.positionSize(10000);
        });

        test("And: i'm willing to loss \$200", () {
          calculator.stopLossAmount(200);
        });

        test("And: i'm willing to gain \$400", () {
          calculator.takeProfitAmount(400);
        });

        test('When: my position is long', () {
          calculator.position(MatexPosition.long);
        });

        test('Then:I should take my profit at 100.8 or accept my loss at 99.6',
            () {
          expect(
            calculator.value() ==
                MatexStopLossTakeProfitResult(
                  pipValue: 5,
                  riskRewardRatio: 2,
                  stopLoss: MatexStopLossResult(
                    amount: 200,
                    pips: 40,
                    price: 99.6,
                  ),
                  takeProfit: MatexTakeProfitResult(
                    amount: 400,
                    pips: 80,
                    price: 100.8,
                  ),
                ),
            equals(true),
          );
        });
      },
    );
  });
}
