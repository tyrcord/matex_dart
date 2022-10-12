// ignore_for_file: unnecessary_type_check

import 'package:matex_dart/matex_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/messages.dart';

void main() {
  group('PipValueCalculator', () {
    late MatexPipValueCalculatorCore calculator;

    setUp(() {
      calculator = pipValue();
    });

    group('pip', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator is MatexPipValueCalculatorCore, equals(true));
      });
    });

    group('#isDirty', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.isDirty, equals(false));
      });

      test('should return true when a calculator state is dirty', () {
        calculator.positionSize(5);
        expect(calculator.isDirty, equals(true));

        calculator.setDefaultState(
          kInitialPipValueState.copyWith(positionSize: 5),
        );
        expect(calculator.isDirty, equals(false));

        calculator.positionSize(kInitialPipValueState.positionSize!);
        expect(calculator.isDirty, equals(true));
      });

      test(
        'should return false when a calculator state property '
        'has been reset to its default\'s value',
        () {
          calculator.positionSize(5);
          expect(calculator.isDirty, equals(true));

          calculator.positionSize(kInitialPipValueState.positionSize!);
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
      test('should not be valid by default', () {
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the position size is set', () {
        calculator.positionSize(5000);
        expect(calculator.isValid, equals(false));
      });

      test(
        'Should not be valid when only the tradingPairExchangeRate is set',
        () {
          calculator.tradingPairExchangeRate(1.5);
          expect(calculator.isValid, equals(false));
        },
      );

      test(
        'Should be valid when only the position size and '
        'the base exchange rate are set',
        () {
          calculator.positionSize(5000).tradingPairExchangeRate(1.5);
          expect(calculator.isValid, equals(true));
        },
      );
    });

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.value(), equals(0));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () {
        expect(calculator.value(), equals(calculator.value()));
      });
    });

    group('#positionSize()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.positionSize(1000), equals(calculator));
      });

      test('should define the position size when calculating a pip value', () {
        var pipValue =
            calculator.positionSize(1).tradingPairExchangeRate(1).value();

        expect(
          calculator.getState().positionSize,
          equals(1),
        );
        expect(pipValue, equals(0.0001));

        pipValue = calculator.positionSize(1000).value();

        expect(
          calculator.getState().positionSize,
          equals(1000),
        );
        expect(pipValue, equals(0.1));
      });
    });

    group('#pipPrecision()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.pipPrecision(5), equals(calculator));
      });

      test('should define the pip precision when calculating a pip value', () {
        var pipValue = calculator
            .positionSize(1)
            .tradingPairExchangeRate(1)
            .pipPrecision(4)
            .value();

        expect(
          calculator.getState().pipPrecision,
          equals(4),
        );
        expect(pipValue, equals(0.0001));

        pipValue = calculator
            .positionSize(1)
            .tradingPairExchangeRate(1)
            .pipPrecision(2)
            .value();

        expect(
          calculator.getState().pipPrecision,
          equals(2),
        );
        expect(pipValue, equals(0.01));
      });
    });

    group('#tradingPairExchangeRate()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.tradingPairExchangeRate(1), equals(calculator));
      });

      test(
          'should define the exchange rate of the currency pair '
          'when calculating a pip value', () {
        var pipValue =
            calculator.positionSize(1).tradingPairExchangeRate(1.25).value();

        expect(
            calculator.getState().tradingPairExchangeRate,
            equals(
              1.25,
            ));
        expect(pipValue, equals(0.00008));

        pipValue =
            calculator.positionSize(1).tradingPairExchangeRate(2).value();

        expect(
          calculator.getState().tradingPairExchangeRate,
          equals(2),
        );
        expect(pipValue, equals(0.00005));
      });
    });

    group('#counterAccountCurrencyPairExchangeRate()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.counterAccountCurrencyPairExchangeRate(1.2),
            equals(calculator));
      });

      test(
          'should define the exchange rate between the account currency and '
          'the base currency when calculating a pip value', () {
        var pipValue = calculator
            .positionSize(1)
            .tradingPairExchangeRate(1)
            .counterAccountCurrencyPairExchangeRate(1.25)
            .value();

        expect(
          calculator.getState().counterAccountCurrencyPairExchangeRate,
          equals(1.25),
        );
        expect(pipValue, equals(0.000125));

        pipValue = calculator
            .positionSize(1)
            .tradingPairExchangeRate(1)
            .counterAccountCurrencyPairExchangeRate(2)
            .value();

        expect(
          calculator.getState().counterAccountCurrencyPairExchangeRate,
          equals(2),
        );
        expect(pipValue, equals(0.0002));
      });
    });

    group('#baseListedSecond()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.baseListedSecond(false), equals(calculator));
      });

      test('should not use the exchange rate when calculating a pip value', () {
        final pipValue = calculator
            .positionSize(1)
            .tradingPairExchangeRate(1.25)
            .baseListedSecond(true)
            .counterAccountCurrencyPairExchangeRate(1)
            .value();

        expect(
          calculator.getState().baseListedSecond,
          equals(true),
        );
        expect(pipValue, equals(0.0001));
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
        var lotDescriptors = kDefaultLotDescriptors.copyWith(
          standard: MatexLotDescriptor(
            multiplier: 5000,
          ),
        );
        calculator.lotDescriptors(lotDescriptors);
        calculator.lot(1);

        expect(
          calculator.getState().positionSize,
          equals(5000),
        );

        lotDescriptors = kDefaultLotDescriptors.copyWith(
          standard: MatexLotDescriptor(
            exists: false,
            multiplier: 5000,
          ),
        );

        calculator.lotDescriptors(lotDescriptors);
        calculator.lot(1);

        expect(
          calculator.getState().positionSize,
          equals(0),
        );
      });
    });

    group('#lot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.lot(1), equals(calculator));
      });

      test('should update the position size value', () {
        calculator.lot(1);
        expect(
          calculator.getState().positionSize,
          equals(100000),
        );
      });
    });

    group('#miniLot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.miniLot(1), equals(calculator));
      });

      test('should update the position size value', () {
        calculator.miniLot(1);
        expect(
          calculator.getState().positionSize,
          equals(10000),
        );
      });
    });

    group('#microLot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.microLot(1), equals(calculator));
      });

      test('should update the position size value', () {
        calculator.microLot(1);
        expect(
          calculator.getState().positionSize,
          equals(1000),
        );
      });
    });

    group('#nanoLot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.nanoLot(1), equals(calculator));
      });

      test('should update the position size value', () {
        calculator.nanoLot(1);
        expect(
          calculator.getState().positionSize,
          equals(100),
        );
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.reset(), equals(calculator));
      });

      test('should reset the calculator', () {
        var pipValue = calculator
            .positionSize(1000)
            .tradingPairExchangeRate(1)
            .reset()
            .value();

        expect(pipValue, equals(0));
      });
    });
  });
}
