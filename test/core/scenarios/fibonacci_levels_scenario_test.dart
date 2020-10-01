import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../samples/fibonacci-levels.sample.dart';

void main() {
  group('Feature: Calculating Fibonacci Levels', () {
    group('Scenario: the trend is up', () {
      final calculator = fibonacciLevels();

      test('Given: the low price is 1.4', () {
        calculator.lowPrice(1.4);
      });

      test('And: the high price is 1.5', () {
        calculator.highPrice(1.5);
      });

      test('When: the trend is up', () {
        calculator.trend(MatexTrend.Up);
      });

      test('Then: the fibonacci levels should be valid', () {
        expect(calculator.isValid, equals(true));
        final fibonacciLevelsResult = calculator.value();
        expect(fibonacciLevelsResult, equals(defaultFibonacciLevelsResultUp));
        expect(
          fibonacciLevelsResult.extensionLevels[0].level,
          equals('261.8%'),
        );
        expect(
          fibonacciLevelsResult.retracementLevels[0].level,
          equals('23.6%'),
        );
      });
    });

    group('Scenario: the trend is down', () {
      final calculator = fibonacciLevels();

      test('Given: the low price is 1.4', () {
        calculator.lowPrice(1.4);
      });

      test('And: the high price is 1.5', () {
        calculator.highPrice(1.5);
      });

      test('When: the trend is down', () {
        calculator.trend(MatexTrend.Down);
      });

      test('Then: the fibonacci levels should be valid', () {
        expect(calculator.isValid, equals(true));
        final fibonacciLevelsResult = calculator.value();
        expect(
          fibonacciLevelsResult,
          equals(defaultFibonacciLevelsResultDown),
        );
        expect(fibonacciLevelsResult.extensionLevels[0].level, equals('23.6%'));
        expect(
          fibonacciLevelsResult.retracementLevels[0].level,
          equals('78.6%'),
        );
      });
    });
  });
}
