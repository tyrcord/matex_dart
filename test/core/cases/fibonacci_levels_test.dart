import 'package:matex_dart/matex_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../samples/fibonacci-levels.sample.dart';
import '../shared/messages.dart';

void main() {
  group('FibonacciLevelsCalculator', () {
    FibonacciLevelsCalculator calculator;

    setUp(() {
      calculator = fibonacciLevels();
    });

    group('fibonnaciLevels()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator is FibonacciLevelsCalculator, equals(true));
      });
    });

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        final result = calculator.value();
        expect(result == defaultFibonacciLevelsResult, equals(true));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () {
        expect(calculator.value(), equals(calculator.value()));
      });
    });

    group('#lowPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.lowPrice(5), equals(calculator));
      });

      test('Should define the lowPrice value', () {
        calculator.lowPrice(1);
        expect(
          calculator.getState().lowPrice,
          equals(1),
        );
      });
    });

    group('#highPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.highPrice(5), equals(calculator));
      });

      test('Should define the highPrice value', () {
        calculator.highPrice(2);
        expect(
          calculator.getState().highPrice,
          equals(2),
        );
      });
    });

    group('#customPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.customPrice(5), equals(calculator));
      });

      test('Should define the customPrice value', () {
        calculator.customPrice(1.5);
        expect(
          calculator.getState().customPrice,
          equals(1.5),
        );
      });
    });

    group('#precision()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.precision(5), equals(calculator));
      });

      test('Should a default value', () {
        expect(
          calculator.getState().precision,
          equals(5),
        );
      });

      test('Should define the precision value', () {
        calculator.precision(2);
        expect(
          calculator.getState().precision,
          equals(2),
        );
      });

      test('Should define the level precision values', () {
        calculator.precision(2).lowPrice(1.4).highPrice(1.5).trend(Trend.Up);

        expect(calculator.value().extensionLevels[0].value, equals(1.76));
        expect(calculator.value().retracementLevels[0].value, equals(1.48));
      });
    });

    group('#extensionLevels()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.extensionLevels([23.6]), equals(calculator));
      });

      test('Should define the extension levels', () {
        calculator.extensionLevels([50]);
        expect(calculator.value().extensionLevels[0].level, equals('50%'));
      });

      test('Should reorder extension levels', () {
        calculator.extensionLevels([50, 23.6]);
        expect(
          calculator.getState().extensionLevels,
          equals([
            23.6,
            50,
          ]),
        );
      });
    });

    group('#retracementLevels()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.retracementLevels([23.6]), equals(calculator));
      });

      test('Should define the retracement levels', () {
        calculator.retracementLevels([50]);
        expect(calculator.value().retracementLevels[0].level, equals('50%'));
      });

      test('Should reorder retracement levels', () {
        calculator.retracementLevels([50, 23.6]);
        expect(
          calculator.getState().retracementLevels,
          equals([
            23.6,
            50,
          ]),
        );
      });
    });

    group('#trend()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.trend(Trend.Up), equals(calculator));
      });

      test('Should have a default value', () {
        expect(
          calculator.getState().trend,
          equals(Trend.Up),
        );
      });

      test('Should define the trend value', () {
        calculator.trend(Trend.Down);
        expect(
          calculator.getState().trend,
          equals(Trend.Down),
        );
      });

      test('Should reorder retracement and extension levels', () {
        FibonacciLevelsResult results = calculator
            .retracementLevels([50, 23.6]).extensionLevels([23.6, 50]).value();

        expect(
          calculator.getState().retracementLevels,
          equals([
            23.6,
            50,
          ]),
        );
        expect(
          calculator.getState().retracementLevels,
          equals([
            23.6,
            50,
          ]),
        );

        expect(results.retracementLevels[0].level, equals('23.6%'));
        expect(results.retracementLevels[1].level, equals('50%'));
        expect(results.extensionLevels[0].level, equals('50%'));
        expect(results.extensionLevels[1].level, equals('23.6%'));

        results = calculator.trend(Trend.Down).value();

        expect(results.retracementLevels[0].level, equals('50%'));
        expect(results.retracementLevels[1].level, equals('23.6%'));
        expect(results.extensionLevels[0].level, equals('23.6%'));
        expect(results.extensionLevels[1].level, equals('50%'));
      });
    });

    group('#isValid()', () {
      test('Should not be valid when no high and low prices are set', () {
        expect(calculator.isValid, equals(false));

        calculator.highPrice(0).lowPrice(0);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the low price is set', () {
        calculator.lowPrice(1.25);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the high price is set', () {
        calculator.highPrice(1.25);
        expect(calculator.isValid, equals(false));
      });

      test('Should be valid when: low price <= high price', () {
        calculator.highPrice(1.35).lowPrice(2);

        expect(calculator.isValid, equals(false));

        calculator.lowPrice(1.25);
        expect(calculator.isValid, equals(true));

        calculator.lowPrice(1.35);
        expect(calculator.isValid, equals(true));
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.reset(), equals(calculator));
      });

      test('should reset the calculator', () {
        final fibonnaciLevelsResult =
            fibonacciLevels().highPrice(1.35).lowPrice(1.25).reset().value();

        expect(
          fibonnaciLevelsResult == defaultFibonacciLevelsResult,
          equals(true),
        );
      });
    });
  });
}
