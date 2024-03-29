// ignore_for_file: unnecessary_type_check

import 'package:matex_dart/matex_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../samples/stop_loss_take_profit.sample.dart';
import '../shared/messages.dart';

void main() {
  group('StopLossTakeProfitCalculator', () {
    late MatexStopLossTakeProfitCalculatorCore calculator;

    setUp(() {
      calculator = stopLossTakeProfit();
    });

    group('stopLossTakeProfit()', () {
      test(
        SHOULD_RETURN_CALCULATOR_INSTANCE,
        () {
          expect(calculator is MatexStopLossTakeProfitCalculatorCore,
              equals(true));
        },
      );
    });

    group('#isDirty', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.isDirty, equals(false));
      });

      test('should return true when a calculator state is dirty', () {
        calculator.positionSize(5);
        expect(calculator.isDirty, equals(true));
      });

      test(
        'should return false when a calculator state property '
        'has been reset to its default\'s value',
        () {
          calculator.positionSize(5);
          expect(calculator.isDirty, equals(true));

          calculator
              .positionSize(kInitialStopLossTakeProfitState.positionSize!);
          expect(calculator.isDirty, equals(false));

          calculator.positionSize(5);
          calculator.stopLossPips(10);
          expect(calculator.isDirty, equals(true));

          calculator.resetStateProperties([
            MatexCoreStateProperty.positionSize,
            MatexCoreStateProperty.stopLossPips,
          ]);

          expect(calculator.isDirty, equals(false));
        },
      );

      test(
        'should return false when a calculator state has been reset',
        () {
          calculator.positionSize(5);
          expect(calculator.isDirty, equals(true));

          calculator.reset();
          expect(calculator.isDirty, equals(false));
        },
      );
    });

    group('#isValid', () {
      test(SHOULD_RETURN_CALCULATOR_VALIDITY, () {
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the entry price is set', () {
        calculator.entryPrice(1.5);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the position size is set', () {
        calculator.positionSize(5000);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the tradingPairExchangeRate is set',
          () {
        calculator.tradingPairExchangeRate(1.5);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the stopLossAmount is set', () {
        calculator.stopLossAmount(200);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the stopLossPips is set', () {
        calculator.stopLossPips(200);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the stopLossPrice is set', () {
        calculator.stopLossPrice(200);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the takeProfitAmount is set', () {
        calculator.takeProfitAmount(200);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the takeProfitPrice is set', () {
        calculator.takeProfitPrice(200);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the takeProfitPips is set', () {
        calculator.takeProfitPips(200);
        expect(calculator.isValid, equals(false));
      });

      test(
          'Should not be valid when only the position size and '
          'the base exchange rate are set', () {
        calculator.positionSize(5000).tradingPairExchangeRate(1.5);
        expect(calculator.isValid, equals(false));
      });

      test(
          'Should not be valid when only the position size and '
          'the entry price rate are set', () {
        calculator.positionSize(5000).entryPrice(1.5);
        expect(calculator.isValid, equals(false));
      });

      test(
          'Should not be valid when only the base exchange rate and '
          'the entry price rate are set', () {
        calculator.tradingPairExchangeRate(1.5).entryPrice(1.5);
        expect(calculator.isValid, equals(false));
      });

      test(
          'Should not be valid when only the entry price, '
          'the position size and the base exchange rate are set', () {
        calculator
            .positionSize(5000)
            .tradingPairExchangeRate(1.5)
            .entryPrice(1.5);
        expect(calculator.isValid, equals(false));
      });

      test(
          'Should be valid when only the entry price, the position size, '
          'the base exchange rate and the takeProfitAmount are set', () {
        calculator
            .positionSize(5000)
            .tradingPairExchangeRate(1.5)
            .takeProfitAmount(200)
            .entryPrice(1.5);
        expect(calculator.isValid, equals(true));
      });

      test(
          'Should be valid when only the entry price, the position size, '
          'the base exchange rate and the takeProfitPrice are set', () {
        calculator
            .positionSize(5000)
            .tradingPairExchangeRate(1.5)
            .takeProfitPrice(200)
            .entryPrice(1.5);
        expect(calculator.isValid, equals(true));
      });

      test(
          'Should be valid when only the entry price, the position size, '
          'the base exchange rate and the takeProfitPips are set', () {
        calculator
            .positionSize(5000)
            .tradingPairExchangeRate(1.5)
            .takeProfitPips(200)
            .entryPrice(1.5);
        expect(calculator.isValid, equals(true));
      });

      test(
        'Should be valid when only the entry price, the position size, '
        'the base exchange rate and the stopLossAmount are set',
        () {
          calculator
              .positionSize(5000)
              .tradingPairExchangeRate(1.5)
              .stopLossAmount(200)
              .entryPrice(1.5);
          expect(calculator.isValid, equals(true));
        },
      );

      test(
          'Should be valid when only the entry price, the position size, '
          'the base exchange rate and the stopLossPrice are set', () {
        calculator
            .positionSize(5000)
            .tradingPairExchangeRate(1.5)
            .stopLossPrice(200)
            .entryPrice(1.5);
        expect(calculator.isValid, equals(true));
      });

      test(
          'Should be valid when only the entry price, the position size, '
          'the base exchange rate and the stopLossPips are set', () {
        calculator
            .positionSize(5000)
            .tradingPairExchangeRate(1.5)
            .stopLossPips(200)
            .entryPrice(1.5);
        expect(calculator.isValid, equals(true));
      });
    });

    group('#setState()', () {
      test(SHOULD_UPDATE_CALCULATOR_STATE, () {
        calculator.setState(const MatexBaseCoreState(
          positionSize: 1000,
        ));

        expect(calculator.getState().positionSize, equals(1000));
      });

      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        final instance = calculator.setState(const MatexBaseCoreState(
          pipPrecision: 2,
        ));

        expect(instance, equals(calculator));
      });
    });

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        final results = calculator.value();
        expect(results == DEFAULT_STOP_LOSS_TAKE_PROFIT_EMPTY, equals(true));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () {
        expect(calculator.value(), equals(calculator.value()));
      });

      test('should define the risk ratio value', () {
        var results = calculator
            .positionSize(5000)
            .tradingPairExchangeRate(1.5)
            .stopLossAmount(200)
            .entryPrice(1.5)
            .value();

        expect(results.riskRewardRatio, equals(0));

        results = calculator.value();
        expect(results.riskRewardRatio, equals(0));

        results = calculator.takeProfitAmount(400).value();
        expect(results.riskRewardRatio, equals(2));

        results = calculator.takeProfitAmount(100).value();
        expect(results.riskRewardRatio, equals(0.5));
      });

      test(
          'should define the stopLossPips and stopLossPrice values '
          'when stopLossAmuont is set and the position is long', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .stopLossAmount(200)
            .entryPrice(1.1)
            .value();

        expect(
          results.stopLoss ==
              const MatexStopLossResult(
                amount: 200,
                pips: 220,
                price: 1.078,
              ),
          equals(true),
        );
      });

      test(
          'should define the stopLossAmount and stopLossPips values '
          'when stopLossPrice is set and the position is long', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .stopLossPrice(1.078)
            .entryPrice(1.1)
            .value();

        expect(
          results.stopLoss,
          equals(
            const MatexStopLossResult(
              amount: 200,
              pips: 220,
              price: 1.078,
            ),
          ),
        );
      });

      test(
          'should define the stopLossAmount and stopLossPrice values '
          'when stopLossPips is set and the position is long', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .stopLossPips(220)
            .entryPrice(1.1)
            .value();

        expect(
          results.stopLoss ==
              const MatexStopLossResult(
                amount: 200,
                pips: 220,
                price: 1.078,
              ),
          equals(true),
        );
      });

      test(
          'should define the takeProfitPips and takeProfitPrice values '
          'when takeProfitAmount is set and the position is long', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .takeProfitAmount(200)
            .entryPrice(1.1)
            .value();

        expect(
          results.takeProfit ==
              const MatexTakeProfitResult(
                amount: 200,
                pips: 220,
                price: 1.122,
              ),
          equals(true),
        );
      });

      test(
          'should define the takeProfitAmount and takeProfitPips values '
          'when takeProfitPrice is set and the position is long', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .takeProfitPrice(1.122)
            .entryPrice(1.1)
            .value();

        expect(
          results.takeProfit,
          equals(
            const MatexTakeProfitResult(
              amount: 200,
              pips: 220,
              price: 1.122,
            ),
          ),
        );
      });

      test(
          'should define the takeProfitAmount and takeProfitPrice values '
          'when takeProfitPips is set and the position is long', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .takeProfitPips(220)
            .entryPrice(1.1)
            .value();

        expect(
          results.takeProfit ==
              const MatexTakeProfitResult(
                amount: 200,
                pips: 220,
                price: 1.122,
              ),
          equals(true),
        );
      });

      test(
          'should define the stopLossPips and stopLossPrice values '
          'when stopLossAmuont is set and the position is short', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .stopLossAmount(200)
            .position(MatexPosition.short)
            .entryPrice(1.1)
            .value();

        expect(
          results.stopLoss ==
              const MatexStopLossResult(
                amount: 200,
                pips: 220,
                price: 1.122,
              ),
          equals(true),
        );
      });

      test(
          'should define the stopLossAmount and stopLossPips values '
          'when stopLossPrice is set and the position is short', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .stopLossPrice(1.122)
            .position(MatexPosition.short)
            .entryPrice(1.1)
            .value();

        expect(
          results.stopLoss,
          equals(
            const MatexStopLossResult(
              amount: 200,
              pips: 220,
              price: 1.122,
            ),
          ),
        );
      });

      test(
          'should define the stopLossAmount and stopLossPrice values '
          'when stopLossPips is set and the position is short', () {
        var results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .stopLossPips(220)
            .position(MatexPosition.short)
            .entryPrice(1.1)
            .value();

        expect(
          results.stopLoss,
          equals(
            const MatexStopLossResult(
              amount: 200,
              pips: 220,
              price: 1.122,
            ),
          ),
        );
      });

      test(
          'should define the takeProfitPips and takeProfitPrice values '
          'when takeProfitAmount is set and the position is short', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .takeProfitAmount(200)
            .position(MatexPosition.short)
            .entryPrice(1.1)
            .value();

        expect(
          results.takeProfit ==
              const MatexTakeProfitResult(
                amount: 200,
                pips: 220,
                price: 1.078,
              ),
          equals(true),
        );
      });

      test(
          'should define the takeProfitAmount and takeProfitPips values '
          'when takeProfitPrice is set and the position is short', () {
        final results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .takeProfitPrice(1.078)
            .position(MatexPosition.short)
            .entryPrice(1.1)
            .value();

        expect(
          results.takeProfit,
          equals(
            const MatexTakeProfitResult(
              amount: 200,
              pips: 220,
              price: 1.078,
            ),
          ),
        );
      });

      test(
          'should define the takeProfitAmount and takeProfitPrice values '
          'when takeProfitPips is set and the position is short', () {
        var results = calculator
            .positionSize(10000)
            .tradingPairExchangeRate(1.1)
            .takeProfitPips(220)
            .position(MatexPosition.short)
            .entryPrice(1.1)
            .value();

        expect(
          results.takeProfit,
          equals(
            const MatexTakeProfitResult(
              amount: 200,
              pips: 220,
              price: 1.078,
            ),
          ),
        );
      });
    });

    group('#pipPrecision()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.pipPrecision(5), equals(calculator));
      });

      test('should define the pip precision value', () {
        calculator.pipPrecision(4);
        expect(calculator.getState().pipPrecision, equals(4));
      });
    });

    group('#tradingPairExchangeRate()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.tradingPairExchangeRate(1), equals(calculator));
      });

      test('should define the exchange rate of the currency pair value', () {
        calculator.tradingPairExchangeRate(1.25);
        expect(calculator.getState().tradingPairExchangeRate, equals(1.25));
      });
    });

    group('#counterAccountCurrencyPairExchangeRate()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.counterAccountCurrencyPairExchangeRate(1.2),
            equals(calculator));
      });

      test('should define the base exchange rate value', () {
        calculator.counterAccountCurrencyPairExchangeRate(1.25);
        expect(calculator.getState().counterAccountCurrencyPairExchangeRate,
            equals(1.25));
      });
    });

    group('#baseListedSecond()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.baseListedSecond(false), equals(calculator));
      });

      test('should define the base listed second value', () {
        calculator.baseListedSecond(true);
        expect(calculator.getState().baseListedSecond, equals(true));
      });
    });

    group('#entryPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.entryPrice(100), equals(calculator));
      });

      test('should define the entry price value', () {
        calculator.entryPrice(1.5);
        expect(calculator.getState().entryPrice, equals(1.5));
      });
    });

    group('#position()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.position(MatexPosition.long), equals(calculator));
      });

      test('should define the position value', () {
        calculator.position(MatexPosition.long);
        expect(calculator.getState().position, equals(MatexPosition.long));
      });
    });

    group('#stopLossPips()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.stopLossPips(50), equals(calculator));
      });

      test('should define the stopLossPips value', () {
        calculator.stopLossPips(50);
        expect(calculator.getState().stopLossPips, equals(50));
      });
    });

    group('#stopLossPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.stopLossPrice(1.5), equals(calculator));
      });

      test('should define the stopLossPrice value', () {
        calculator.stopLossPrice(1.5);
        expect(calculator.getState().stopLossPrice, equals(1.5));
      });

      test('should reset the stopLossPips and the stopLossAmount values', () {
        calculator.stopLossPrice(1.5);
        expect(calculator.getState().stopLossPrice, equals(1.5));
        expect(calculator.getState().stopLossAmount, equals(0));
        expect(calculator.getState().stopLossPips, equals(0));
      });
    });

    group('#stopLossAmount()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.stopLossAmount(1.5), equals(calculator));
      });

      test('should define the stopLossAmount value', () {
        calculator.stopLossAmount(1.5);
        expect(calculator.getState().stopLossAmount, equals(1.5));
      });

      test('should reset the stopLossPips and the stopLossPrice values', () {
        calculator.stopLossAmount(1.5);
        expect(calculator.getState().stopLossAmount, equals(1.5));
        expect(calculator.getState().stopLossPrice, equals(0));
        expect(calculator.getState().stopLossPips, equals(0));
      });
    });

    group('#stopLossPips()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.stopLossPips(1.5), equals(calculator));
      });

      test('should define the stopLossAmount value', () {
        calculator.stopLossPips(1.5);
        expect(calculator.getState().stopLossPips, equals(1.5));
      });

      test('should reset the stopLossAmount and the stopLossAmount values', () {
        calculator.stopLossPips(1.5);
        expect(calculator.getState().stopLossPips, equals(1.5));
        expect(calculator.getState().stopLossAmount, equals(0));
        expect(calculator.getState().stopLossPrice, equals(0));
      });
    });

    group('#takeProfitAmount()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.takeProfitAmount(1.5), equals(calculator));
      });

      test('should define the takeProfitAmount value', () {
        calculator.takeProfitAmount(1.5);
        expect(calculator.getState().takeProfitAmount, equals(1.5));
      });

      test('should reset the takeProfitPrice and the takeProfitPips values',
          () {
        calculator.takeProfitAmount(1.5);
        expect(calculator.getState().takeProfitAmount, equals(1.5));
        expect(calculator.getState().takeProfitPrice, equals(0));
        expect(calculator.getState().takeProfitPips, equals(0));
      });
    });

    group('#takeProfitPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.takeProfitPrice(1.5), equals(calculator));
      });

      test('should define the takeProfitPrice value', () {
        calculator.takeProfitPrice(1.5);
        expect(calculator.getState().takeProfitPrice, equals(1.5));
      });

      test('should reset the takeProfitAmount and the takeProfitPips values',
          () {
        calculator.takeProfitPrice(1.5);
        expect(calculator.getState().takeProfitPrice, equals(1.5));
        expect(calculator.getState().takeProfitAmount, equals(0));
        expect(calculator.getState().takeProfitPips, equals(0));
      });
    });

    group('#takeProfitPips()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.takeProfitPips(1.5), equals(calculator));
      });

      test('should define the takeProfitPips value', () {
        calculator.takeProfitPips(1.5);
        expect(calculator.getState().takeProfitPips, equals(1.5));
      });

      test('should reset the takeProfitAmount and the takeProfitPrice values',
          () {
        calculator.takeProfitPips(1.5);
        expect(calculator.getState().takeProfitPips, equals(1.5));
        expect(calculator.getState().takeProfitAmount, equals(0));
        expect(calculator.getState().takeProfitPrice, equals(0));
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.reset(), equals(calculator));
      });

      test('should reset the calculator', () {
        final results =
            calculator.takeProfitAmount(1000).pipPrecision(2).reset().value();

        expect(results == DEFAULT_STOP_LOSS_TAKE_PROFIT_EMPTY, equals(true));
      });
    });
  });
}
