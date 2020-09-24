import 'package:matex_dart/matex_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../samples/pivot_points.sample.dart';
import '../shared/messages.dart';

void main() {
  group('PivotPointsCalculator', () {
    PivotPointsCalculator calculator;

    setUp(() {
      calculator = pivotPoints();
    });

    group('pivotPoints()', () {
      test(SHOULD_RETURN_CALCULATOR_INSTANCE, () {
        expect(calculator is PivotPointsCalculator, equals(true));
      });
    });

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        final results = calculator.value();
        expect(results == PIVOT_POINTS_DEFAULT_RESULTS, equals(true));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () {
        expect(calculator.value(), equals(calculator.value()));
      });
    });

    group('#isValid', () {
      test('Should not be valid when no low, high and close prices are set',
          () {
        expect(calculator.isValid, equals(false));

        calculator.lowPrice(1);
        expect(calculator.isValid, equals(false));

        calculator.highPrice(2);
        expect(calculator.isValid, equals(false));

        calculator.closePrice(2);
        expect(calculator.isValid, equals(true));

        calculator.highPrice(0).lowPrice(0).closePrice(0);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the low price is set', () {
        calculator.lowPrice(1);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the high price is set', () {
        calculator.highPrice(1);
        expect(calculator.isValid, equals(false));
      });

      test('Should not be valid when only the close price is set', () {
        calculator.closePrice(1);
        expect(calculator.isValid, equals(false));
      });

      test(
          'Should be valid when: close price >= low price && close price <= high price',
          () {
        calculator.highPrice(2).lowPrice(1);

        expect(calculator.isValid, equals(false));

        calculator.closePrice(3);
        expect(calculator.isValid, equals(false));

        calculator.closePrice(0.5);
        expect(calculator.isValid, equals(false));

        calculator.closePrice(1.5);
        expect(calculator.isValid, equals(true));

        calculator.closePrice(1);
        expect(calculator.isValid, equals(true));

        calculator.closePrice(2);
        expect(calculator.isValid, equals(true));
      });

      test(
          'Should not be valid when no low, high, open and close prices are set when the method is DeMark',
          () {
        calculator.method(PivotPointsMethods.DeMark);
        expect(calculator.isValid, equals(false));

        calculator.lowPrice(1);
        expect(calculator.isValid, equals(false));

        calculator.highPrice(2);
        expect(calculator.isValid, equals(false));

        calculator.closePrice(2);
        expect(calculator.isValid, equals(false));

        calculator.openPrice(2);
        expect(calculator.isValid, equals(true));

        calculator.openPrice(0).highPrice(0).lowPrice(0).closePrice(0);
        expect(calculator.isValid, equals(false));
      });

      test(
          'Should be valid when: close price >= low price && open price <= high price',
          () {
        calculator.highPrice(2).lowPrice(1).closePrice(2);
        calculator.method(PivotPointsMethods.DeMark);

        expect(calculator.isValid, equals(false));

        calculator.openPrice(3);
        expect(calculator.isValid, equals(false));

        calculator.openPrice(0.5);
        expect(calculator.isValid, equals(false));

        calculator.openPrice(1.5);
        expect(calculator.isValid, equals(true));

        calculator.openPrice(1);
        expect(calculator.isValid, equals(true));

        calculator.openPrice(2);
        expect(calculator.isValid, equals(true));
      });
    });

    group('#setState()', () {
      test(SHOULD_UPDATE_CALCULATOR_STATE, () {
        calculator.setState(PivotPointsState(
          closePrice: 1,
        ));

        expect(calculator.getState().closePrice, equals(1));
      });

      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        final instance = calculator.setState(PivotPointsState(
          closePrice: 1,
        ));

        expect(instance == calculator, equals(true));
      });
    });

    group('#closePrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.closePrice(1), equals(calculator));
      });

      test('should define the close price value', () {
        calculator.closePrice(1);
        expect(calculator.getState().closePrice, equals(1));
      });
    });

    group('#highPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.highPrice(1), equals(calculator));
      });

      test('should define the high price value', () {
        calculator.highPrice(1);
        expect(calculator.getState().highPrice, equals(1));
      });
    });

    group('#lowPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.lowPrice(1), equals(calculator));
      });

      test('should define the low price value', () {
        calculator.lowPrice(1);
        expect(calculator.getState().lowPrice, equals(1));
      });
    });

    group('#method()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(
            calculator.method(PivotPointsMethods.DeMark),
            equals(
              calculator,
            ));
      });

      test('should define the method value', () {
        calculator.method(PivotPointsMethods.DeMark);
        expect(
            calculator.getState().method,
            equals(
              PivotPointsMethods.DeMark,
            ));
      });
    });

    group('#openPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.openPrice(1), equals(calculator));
      });

      test('should define the open price value', () {
        calculator.openPrice(1);
        expect(calculator.getState().openPrice, equals(1));
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.reset(), equals(calculator));
      });

      test(SHOULD_RESET_CALCULATOR, () {
        final results =
            calculator.openPrice(1).lowPrice(1).highPrice(2).reset().value();

        expect(results == PIVOT_POINTS_DEFAULT_RESULTS, equals(true));
      });
    });
  });
}
