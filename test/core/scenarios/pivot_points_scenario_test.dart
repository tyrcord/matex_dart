import 'package:test/test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../samples/pivot_points.sample.dart';
import '../shared/messages.dart';

void main() {
  group('Feature: Calculating the pivot points', () {
    group('Scenario: the method is Woodie', () {
      final calculator = pivotPoints();

      test(lowPriceMessage(1.3), () {
        calculator.lowPrice(1.3);
      });

      test(highPriceMessage(1.5), () {
        calculator.highPrice(1.5);
      });

      test(closePriceMessage(1.45), () {
        calculator.closePrice(1.45);
      });

      test(pivotPointsMethodMessage('Woodie'), () {
        calculator.method(PivotPointsMethods.Woodie);
      });

      test(COMPUTE_RIGHT_VALUES, () {
        expect(calculator.isValid, equals(true));
        expect(calculator.value() == PIVOT_POINTS_WOODIE_RESULTS, equals(true));
      });
    });

    group('When the method is DeMark and close > open', () {
      final calculator = pivotPoints();

      test(lowPriceMessage(1.3), () {
        calculator.lowPrice(1.3);
      });

      test(highPriceMessage(1.5), () {
        calculator.highPrice(1.5);
      });

      test(openPriceMessage(1.35), () {
        calculator.openPrice(1.35);
      });

      test(closePriceMessage(1.45), () {
        calculator.closePrice(1.45);
      });

      test(pivotPointsMethodMessage('DeMark'), () {
        calculator.method(PivotPointsMethods.DeMark);
      });

      test(COMPUTE_RIGHT_VALUES, () {
        expect(calculator.isValid, equals(true));
        expect(
          calculator.value() == PIVOT_POINTS_DEMARK_RESULTS_CLOSE_GREATER_OPEN,
          equals(true),
        );
      });
    });

    group('When the method is DeMark and close < open', () {
      final calculator = pivotPoints();

      test(lowPriceMessage(1.3), () {
        calculator.lowPrice(1.3);
      });

      test(highPriceMessage(1.5), () {
        calculator.highPrice(1.5);
      });

      test(openPriceMessage(1.35), () {
        calculator.openPrice(1.35);
      });

      test(closePriceMessage(1.32), () {
        calculator.closePrice(1.32);
      });

      test(pivotPointsMethodMessage('DeMark'), () {
        calculator.method(PivotPointsMethods.DeMark);
      });

      test(COMPUTE_RIGHT_VALUES, () {
        expect(calculator.isValid, equals(true));
        expect(
          calculator.value() == PIVOT_POINTS_DEMARK_RESULTS_OPEN_GREATER_CLOSE,
          equals(true),
        );
      });
    });

    group('When the method is DeMark and close = open', () {
      final calculator = pivotPoints();

      test(lowPriceMessage(1.3), () {
        calculator.lowPrice(1.3);
      });

      test(highPriceMessage(1.5), () {
        calculator.highPrice(1.5);
      });

      test(openPriceMessage(1.35), () {
        calculator.openPrice(1.35);
      });

      test(closePriceMessage(1.35), () {
        calculator.closePrice(1.35);
      });

      test(pivotPointsMethodMessage('DeMark'), () {
        calculator.method(PivotPointsMethods.DeMark);
      });

      test(COMPUTE_RIGHT_VALUES, () {
        expect(calculator.isValid, equals(true));
        expect(calculator.value() == PIVOT_POINTS_DEMARK_RESULTS, equals(true));
      });
    });

    group('When the method is Standard', () {
      final calculator = pivotPoints();

      test(lowPriceMessage(1.25), () {
        calculator.lowPrice(1.25);
      });

      test(highPriceMessage(1.5), () {
        calculator.highPrice(1.5);
      });

      test(closePriceMessage(1.3), () {
        calculator.closePrice(1.3);
      });

      test(pivotPointsMethodMessage('Standard'), () {
        calculator.method(PivotPointsMethods.Standard);
      });

      test(COMPUTE_RIGHT_VALUES, () {
        expect(calculator.isValid, equals(true));
        expect(calculator.value() == PIVOT_POINTS_STANDARD, equals(true));
      });
    });

    group('When the method is Fibonacci', () {
      final calculator = pivotPoints();

      test(lowPriceMessage(1.25), () {
        calculator.lowPrice(1.25);
      });

      test(highPriceMessage(1.5), () {
        calculator.highPrice(1.5);
      });

      test(closePriceMessage(1.3), () {
        calculator.closePrice(1.3);
      });

      test(pivotPointsMethodMessage('Fibonacci'), () {
        calculator.method(PivotPointsMethods.Fibonacci);
      });

      test(COMPUTE_RIGHT_VALUES, () {
        expect(calculator.isValid, equals(true));
        expect(calculator.value() == PIVOT_POINTS_FIBONACCI, equals(true));
      });
    });

    group('When the method is Camarilla', () {
      final calculator = pivotPoints();

      test(lowPriceMessage(1.2), () {
        calculator.lowPrice(1.2);
      });

      test(highPriceMessage(1.5), () {
        calculator.highPrice(1.5);
      });

      test(closePriceMessage(1.3), () {
        calculator.closePrice(1.3);
      });

      test(pivotPointsMethodMessage('Camarilla'), () {
        calculator.method(PivotPointsMethods.Camarilla);
      });

      test(COMPUTE_RIGHT_VALUES, () {
        expect(calculator.isValid, equals(true));
        expect(calculator.value() == PIVOT_POINTS_CAMARILLA, equals(true));
      });
    });
  });
}
