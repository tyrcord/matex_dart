import 'package:test/test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../samples/position_size.dart';

void main() {
  group('Feature: Calculating the perfect position size', () {
    group('Scenario: the currency account is listed second in a pair', () {
      final calculator = positionSize();

      test('Given: my trading account is in USD', () {
        expect(calculator is PositionSizeCalculator, equals(true));
      });

      test('And: USD is listed second in the pair EUR/USD', () {
        calculator.baseListedSecond(true);
      });

      test('And: the exchange rate for this pair is 1.25', () {
        calculator.tradingPairExchangeRate(1.25);
      });

      test('When: my account size is \$5,000', () {
        calculator.accountSize(5000);
      });

      test('And: my risk amount is \$50', () {
        calculator.amountAtRisk(50);
      });

      test('And: my stop loss is 200 (pips)', () {
        calculator.stopLossPips(200);
      });

      test('Then: my position size should be 2,500', () {
        expect(calculator.value(), equals(DEFAULT_POSITION_SIZE_RESULTS));
      });
    });

    group('Scenario: the currency account is listed second in a pair', () {
      final calculator = positionSize();

      test('Given: my trading account is in USD', () {
        expect(calculator is PositionSizeCalculator, equals(true));
      });

      test('And: USD is listed second in the pair EUR/USD', () {
        calculator.baseListedSecond(true);
      });

      test('And: the exchange rate for this pair is 1.25', () {
        calculator.tradingPairExchangeRate(1.25);
      });

      test('When: my account size is \$5,000', () {
        calculator.accountSize(5000);
      });

      test('And: my risk ratio is 1%', () {
        calculator.riskRatio(1);
      });

      test('And: my stop loss is 200 (pips)', () {
        calculator.stopLossPips(200);
      });

      test('Then: my position size should be 2,500', () {
        expect(calculator.value(), equals(DEFAULT_POSITION_SIZE_RESULTS));
      });
    });

    group('When the currency account is listed second in a pair', () {
      final calculator = positionSize();

      test('Given: my trading account is in USD', () {
        expect(calculator is PositionSizeCalculator, equals(true));
      });

      test('And: USD is listed second in the pair EUR/USD', () {
        calculator.baseListedSecond(true);
      });

      test('And: the exchange rate for this pair is 1.25', () {
        calculator.tradingPairExchangeRate(1.25);
      });

      test('When: my account size is \$5,000', () {
        calculator.accountSize(5000);
      });

      test('And: my risk ratio is 1%', () {
        calculator.riskRatio(1);
      });

      test('And: my entry price is 1.02', () {
        calculator.entryPrice(1.02);
      });

      test('And: my entry price is 1', () {
        calculator.stopLossPrice(1);
      });

      test('Then: my position size should be 2,500', () {
        expect(calculator.value(), equals(DEFAULT_POSITION_SIZE_RESULTS));
      });
    });

    group('Scenario: the currency account is listed second in a pair', () {
      final calculator = positionSize();

      test('Given: my trading account is in USD', () {
        expect(calculator is PositionSizeCalculator, equals(true));
      });

      test('And: USD is listed second in the pair EUR/USD', () {
        calculator.baseListedSecond(true);
      });

      test('And: the exchange rate for this pair is 1.25', () {
        calculator.tradingPairExchangeRate(1.25);
      });

      test('When: my account size is \$5,000', () {
        calculator.accountSize(5000);
      });

      test('And: my amount at risk is \$50', () {
        calculator.amountAtRisk(50);
      });

      test('And: my entry price is 1.02', () {
        calculator.entryPrice(1.02);
      });

      test('And: my entry price is 1', () {
        calculator.stopLossPrice(1);
      });

      test('Then: my position size should be 2,500', () {
        expect(calculator.value(), equals(DEFAULT_POSITION_SIZE_RESULTS));
      });
    });

    group('Scenario: the currency account is listed first in a pair', () {
      final calculator = positionSize();

      test('Given: my trading account is in EUR', () {
        expect(calculator is PositionSizeCalculator, equals(true));
      });

      test('And: EUR is listed first in the pair EUR/CAD', () {
        calculator.baseListedSecond(false); // default value
      });

      test('And: the exchange rate for this pair is 1.25', () {
        calculator.tradingPairExchangeRate(1.12);
      });

      test('When: my account size is 5,000€', () {
        calculator.accountSize(5000);
      });

      test('And: my risk amount is 50€', () {
        calculator.amountAtRisk(50);
      });

      test('And: my stop loss is 200 (pips)', () {
        calculator.stopLossPips(200);
      });

      test('Then: my position size should be 2,800', () {
        expect(
          calculator.value(),
          equals(PositionSizeResult(
            amountAtRisk: 50,
            pipValue: 0.25,
            positionSize: 2800,
            riskRatio: 1,
          )),
        );
      });
    });

    group('Scenario: the currency account is not listed in a pair', () {
      final calculator = positionSize();

      test('Given: my trading account is in USD', () {
        expect(calculator is PositionSizeCalculator, equals(true));
      });

      test('And: the exchange rate for the pair AUD/JPY is 100', () {
        calculator.tradingPairExchangeRate(100);
        calculator.pipPrecision(2);
      });

      test('And: the exchange rate for the pair USD/AUD is 1.6', () {
        calculator.baseExchangeRate(1.6);
      });

      test('When: my account size is \$5,000', () {
        calculator.accountSize(5000);
      });

      test('And: my amount at risk is \$50', () {
        calculator.amountAtRisk(50);
      });

      test('And: my stop loss is 200 (pips)', () {
        calculator.stopLossPips(200);
      });

      test('Then: my position size should be \$4,000', () {
        expect(
          calculator.value(),
          equals(PositionSizeResult(
            amountAtRisk: 50,
            pipValue: 0.25,
            positionSize: 4000,
            riskRatio: 1,
          )),
        );
      });
    });
  });
}
