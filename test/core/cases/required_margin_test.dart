import 'package:matex_dart/matex_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/messages.dart';

void main() {
  group('RequiredMarginCalculator', () {
    MatexRequiredMarginCalculatorCore calculator;

    setUp(() {
      calculator = requiredMargin();
    });

    group('requiredMargin()', () {
      test(SHOULD_RETURN_CALCULATOR_INSTANCE, () {
        expect(calculator is MatexRequiredMarginCalculatorCore, equals(true));
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

          calculator.positionSize(kInitialRequiredMarginState.positionSize);
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

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.value(), equals(0));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () {
        expect(calculator.value(), equals(calculator.value()));
      });
    });

    group('#baseExchangeRate()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.baseExchangeRate(1.5), equals(calculator));
      });

      test(SHOULD_RETURN_CALCULATOR_PROPERTY_STATE_VALUE, () {
        calculator.baseExchangeRate(2);
        expect(calculator.getState().baseExchangeRate, equals(2));
      });
    });

    group('#leverage()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.leverage(5), equals(calculator));
      });

      test(SHOULD_RETURN_CALCULATOR_PROPERTY_STATE_VALUE, () {
        calculator.leverage(2);
        expect(calculator.getState().leverage, equals(2));
      });
    });

    group('#positionSize()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.positionSize(1000), equals(calculator));
      });

      test(SHOULD_RETURN_CALCULATOR_PROPERTY_STATE_VALUE, () {
        calculator.positionSize(1000);
        expect(calculator.getState().positionSize, equals(1000));
      });
    });

    group('#lotDescriptors()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(
          calculator.lotDescriptors(kDefaultLotDescriptors),
          equals(calculator),
        );
      });

      test('should update the lot descriptors value', () {
        MatexLotDescriptors lotDescriptors = kDefaultLotDescriptors.copyWith(
          standard: MatexLotDescriptor(multiplier: 5000),
        );

        calculator.lotDescriptors(lotDescriptors);
        calculator.lot(1);

        expect(calculator.getState().positionSize, equals(5000));

        lotDescriptors = kDefaultLotDescriptors.copyWith(
          standard: MatexLotDescriptor(multiplier: 5000, exists: false),
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

      test('should update the position size value', () {
        calculator.lot(1);
        expect(calculator.getState().positionSize, equals(100000));
      });
    });

    group('#miniLot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.miniLot(1), equals(calculator));
      });

      test('should update the position size value', () {
        calculator.miniLot(1);
        expect(calculator.getState().positionSize, equals(10000));
      });
    });

    group('#microLot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.microLot(1), equals(calculator));
      });

      test('should update the position size value', () {
        calculator.microLot(1);
        expect(calculator.getState().positionSize, equals(1000));
      });
    });

    group('#nanoLot()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.nanoLot(1), equals(calculator));
      });

      test('should update the position size value', () {
        calculator.nanoLot(1);
        expect(calculator.getState().positionSize, equals(100));
      });
    });

    group('#isValid()', () {
      test(
          'Should be valid when the position size and the trading exchange rate are set',
          () {
        expect(calculator.isValid, equals(false));
        calculator.tradingPairExchangeRate(1);
        calculator.positionSize(100000);
        expect(calculator.isValid, equals(true));
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.reset(), equals(calculator));
      });

      test(SHOULD_RESET_CALCULATOR, () {
        final result = requiredMargin()
            .positionSize(1000)
            .baseExchangeRate(1.5)
            .leverage(5)
            .reset()
            .value();

        expect(result, equals(0));
      });
    });
  });
}
