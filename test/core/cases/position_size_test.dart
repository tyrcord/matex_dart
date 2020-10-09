import 'package:matex_dart/matex_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../samples/position_size.sample.dart';
import '../shared/messages.dart';

void main() {
  group('PositionSizeCalculator', () {
    MatexPositionSizeCalculatorCore calculator;

    setUp(() {
      calculator = positionSize();
    });

    group('positionSize()', () {
      test(SHOULD_RETURN_CALCULATOR_INSTANCE, () {
        expect(calculator is MatexPositionSizeCalculatorCore, equals(true));
      });
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

          calculator.positionSize(kInitialPositionSizeState.positionSize);
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

      test('Should not be valid when only the account size is set', () {
        calculator.accountSize(5000);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the amount at risk is set', () {
        calculator.amountAtRisk(50);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the risk ratio is set', () {
        calculator.riskRatio(1);
        expect(calculator.isValid, equals(false));
      });

      test(
        'Should be valid when the account size and '
        'the amount at risk are set',
        () {
          calculator
              .accountSize(5000)
              .tradingPairExchangeRate(1)
              .amountAtRisk(50);

          expect(calculator.isValid, equals(true));
        },
      );

      test('Should be valid when the account size and the risk ratio are set',
          () {
        calculator.accountSize(5000).riskRatio(1).tradingPairExchangeRate(1);

        expect(calculator.isValid, equals(true));
      });

      test(
        'Should be valid when the account size and '
        'the risk ratio are incorrect',
        () {
          calculator.accountSize(5000).riskRatio(112);
          expect(calculator.isValid, equals(false));

          calculator.accountSize(5000).riskRatio(0);
          expect(calculator.isValid, equals(false));
        },
      );

      test(
          'Should be valid when the account size and the amount at risk are incorrect',
          () {
        calculator.accountSize(5000).amountAtRisk(10000);
        expect(calculator.isValid, equals(false));

        calculator.accountSize(5000).riskRatio(0);
        expect(calculator.isValid, equals(false));
      });
    });

    group('#setState()', () {
      test(SHOULD_UPDATE_CALCULATOR_STATE, () {
        calculator.setState(MatexBaseCoreState(
          positionSize: 1000,
        ));

        expect(calculator.getState().positionSize, equals(1000));
      });

      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        final instance = calculator.setState(MatexBaseCoreState(
          pipPrecision: 2,
        ));

        expect(instance, equals(calculator));
      });
    });

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        final results = calculator.value();
        expect(results == DEFAULT_RESULTS, equals(true));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () {
        expect(calculator.value(), equals(calculator.value()));
      });

      test('should return the default value when only the account size is set',
          () {
        final results = calculator.accountSize(5000).value();
        expect(results == DEFAULT_RESULTS, equals(true));
      });

      test(
          'should return the default value when only the amount at risk is set',
          () {
        final results = calculator.amountAtRisk(50).value();
        expect(results == DEFAULT_RESULTS, equals(true));
      });

      test(
          'should return a partial result when the account size and the risk ratio are set',
          () {
        final results = calculator
            .accountSize(5000)
            .riskRatio(1)
            .tradingPairExchangeRate(1)
            .value();

        expect(results == DEFAULT_PARTIAL_RESULTS, equals(true));
      });

      test(
          'should return a partial result when the account size and the amount at risk are set',
          () {
        final results = calculator
            .accountSize(5000)
            .amountAtRisk(50)
            .tradingPairExchangeRate(1)
            .value();
        expect(results == DEFAULT_PARTIAL_RESULTS, equals(true));
      });

      test(
          'should return a partial result when the account size, the entry price and the risk ratio are set',
          () {
        final results = calculator
            .accountSize(5000)
            .riskRatio(1)
            .entryPrice(1.02)
            .tradingPairExchangeRate(1)
            .value();
        expect(results == DEFAULT_PARTIAL_RESULTS, equals(true));
      });

      test(
          'should return a partial result when the account size, the stop loss price and the risk ratio are set',
          () {
        final results = calculator
            .accountSize(5000)
            .riskRatio(1)
            .stopLossPrice(1)
            .tradingPairExchangeRate(1)
            .value();
        expect(results == DEFAULT_PARTIAL_RESULTS, equals(true));
      });

      test(
          'should return a result when the account size, the stop loss price, the entry price and the risk ratio are set',
          () {
        final results = calculator
            .accountSize(5000)
            .riskRatio(1)
            .stopLossPrice(1)
            .entryPrice(1.02)
            .tradingPairExchangeRate(1)
            .value();
        expect(results, equals(DEFAULT_POSITION_SIZE_RESULTS));
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

    group('#baseExchangeRate()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.baseExchangeRate(1.2), equals(calculator));
      });

      test('should define the base exchange rate value', () {
        calculator.baseExchangeRate(1.25);
        expect(calculator.getState().baseExchangeRate, equals(1.25));
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

    group('#accountSize()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.accountSize(100), equals(calculator));
      });

      test('should define the amount at risk value', () {
        calculator.accountSize(100);
        expect(calculator.getState().accountSize, equals(100));
      });
    });

    group('#amountAtRisk()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.amountAtRisk(100), equals(calculator));
      });

      test('should define the amount at risk value', () {
        calculator.amountAtRisk(100);
        expect(calculator.getState().amountAtRisk, equals(100));
      });

      test('should reset the risk ratio value', () {
        calculator.riskRatio(15);
        expect(calculator.getState().riskRatio, equals(15));

        calculator.amountAtRisk(100);
        expect(calculator.getState().amountAtRisk, equals(100));
        expect(calculator.getState().riskRatio, equals(0));
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

      test('should reset the stop loss pips value', () {
        calculator.stopLossPips(15);
        expect(calculator.getState().stopLossPips, equals(15));

        calculator.entryPrice(1.5);
        expect(calculator.getState().entryPrice, equals(1.5));
        expect(calculator.getState().stopLossPips, equals(0));
      });
    });

    group('#riskRatio()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.riskRatio(50), equals(calculator));
      });

      test('should define the risk ratio value', () {
        calculator.riskRatio(50);
        expect(calculator.getState().riskRatio, equals(50));
      });

      test('should reset the amount at risk value', () {
        calculator.amountAtRisk(100);
        expect(calculator.getState().amountAtRisk, equals(100));

        calculator.riskRatio(15);
        expect(calculator.getState().riskRatio, equals(15));
        expect(calculator.getState().amountAtRisk, equals(0));
      });
    });

    group('#stopLossPips()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.stopLossPips(50), equals(calculator));
      });

      test('should define the risk ratio value', () {
        calculator.stopLossPips(50);
        expect(calculator.getState().stopLossPips, equals(50));
      });

      test('should reset the amount at risk value', () {
        calculator.entryPrice(1.4);
        expect(calculator.getState().entryPrice, equals(1.4));

        calculator.stopLossPips(15);
        expect(calculator.getState().stopLossPips, equals(15));
        expect(calculator.getState().entryPrice, equals(0));
      });

      test('should reset the stop Loss price value', () {
        calculator.stopLossPrice(1.5);
        expect(calculator.getState().stopLossPrice, equals(1.5));

        calculator.stopLossPips(15);
        expect(calculator.getState().stopLossPips, equals(15));
        expect(calculator.getState().stopLossPrice, equals(0));
      });
    });

    group('#stopLossPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.stopLossPrice(1.5), equals(calculator));
      });

      test('should define the risk ratio value', () {
        calculator.stopLossPrice(1.5);
        expect(calculator.getState().stopLossPrice, equals(1.5));
      });

      test('should reset the stop loss pips value', () {
        calculator.stopLossPips(100);
        expect(calculator.getState().stopLossPips, equals(100));

        calculator.stopLossPrice(15);
        expect(calculator.getState().stopLossPrice, equals(15));
        expect(calculator.getState().stopLossPips, equals(0));
      });
    });

    group('#lotDescriptors()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(
            calculator.lotDescriptors(kDefaultLotDescriptors),
            equals(
              calculator,
            ));
      });

      test('should update the lot descriptors value', () {
        MatexLotDescriptors lotDescriptors = kDefaultLotDescriptors.copyWith(
          standard: MatexLotDescriptor(
            exists: true,
            multiplier: 5000,
          ),
        );

        calculator.lotDescriptors(lotDescriptors);
        calculator.lot(1);

        expect(calculator.getState().positionSize, equals(5000));

        lotDescriptors = kDefaultLotDescriptors.copyWith(
          standard: MatexLotDescriptor(
            exists: false,
            multiplier: 5000,
          ),
        );

        calculator.lotDescriptors(lotDescriptors);
        calculator.lot(1);

        expect(calculator.getState().positionSize, equals(0));
      });
    });

    group('#lot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.lot(1), equals(calculator));
      });

      test('should update the postestion size value', () {
        calculator.lot(1);
        expect(calculator.getState().positionSize, equals(100000));
      });
    });

    group('#miniLot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.miniLot(1), equals(calculator));
      });

      test('should update the postestion size value', () {
        calculator.miniLot(1);
        expect(calculator.getState().positionSize, equals(10000));
      });
    });

    group('#microLot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.microLot(1), equals(calculator));
      });

      test('should update the postestion size value', () {
        calculator.microLot(1);
        expect(calculator.getState().positionSize, equals(1000));
      });
    });

    group('#nanoLot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.nanoLot(1), equals(calculator));
      });

      test('should update the postestion size value', () {
        calculator.nanoLot(1);
        expect(calculator.getState().positionSize, equals(100));
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.reset(), equals(calculator));
      });

      test('should reset the calculator', () {
        final results = calculator
            .accountSize(1000)
            .tradingPairExchangeRate(1)
            .riskRatio(5)
            .reset()
            .value();

        expect(results == DEFAULT_RESULTS, equals(true));
      });
    });
  });
}
