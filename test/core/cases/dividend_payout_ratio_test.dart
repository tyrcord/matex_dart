// ignore_for_file: unnecessary_type_check

import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../shared/messages.dart';

void main() {
  group('MatexDividendPayoutRatioCalculatorCore', () {
    late MatexDividendPayoutRatioCalculatorCore calculator;

    setUp(() {
      calculator = dividendPayoutRatio();
    });

    group('dividendPayoutRatio()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator is MatexDividendPayoutRatioCalculatorCore, isTrue);
      });
    });
    group('#isDirty', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.isDirty, isFalse);
        final result = calculator.value();
        expect(result, equals(MatexDividendPayoutRatioResult()));
      });

      test('should return true when a calculator state is dirty', () {
        calculator.netIncome(1000000);
        expect(calculator.isDirty, isTrue);
      });

      test('should return false when a calculator state has been reset', () {
        calculator.netIncome(1000000);
        expect(calculator.isDirty, isTrue);

        calculator.reset();
        expect(calculator.isDirty, isFalse);
      });
    });

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.value(), equals(MatexDividendPayoutRatioResult()));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () {
        expect(calculator.value(), equals(calculator.value()));
      });
    });

    group('#netIncome()', () {
      test('Should return proper results', () {
        var results =
            calculator.netIncome(1000000).totalDividend(500000).value();

        expect(
          double.parse(results.dividendPayoutRatio.toStringAsFixed(2)),
          equals(0.5),
        );

        results = calculator.netIncome(750000).totalDividend(500000).value();

        expect(
          double.parse(results.dividendPayoutRatio.toStringAsFixed(2)),
          equals(0.67),
        );
      });
    });

    group('#totalDividend()', () {
      test('Should return proper results', () {
        var results =
            calculator.netIncome(1000000).totalDividend(50000).value();

        expect(
          double.parse(results.dividendPayoutRatio.toStringAsFixed(2)),
          equals(0.05),
        );

        results = calculator.netIncome(1000000).totalDividend(600000).value();

        expect(
          double.parse(results.dividendPayoutRatio.toStringAsFixed(2)),
          equals(0.6),
        );
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator is MatexDividendPayoutRatioCalculatorCore, isTrue);
      });

      test('should reset the calculator', () {
        var value = calculator.netIncome(1000000).reset().value();
        expect(value, equals(MatexDividendPayoutRatioResult()));
      });
    });
  });
}
