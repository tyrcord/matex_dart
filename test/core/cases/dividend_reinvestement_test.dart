import 'package:matex_dart/matex_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/messages.dart';

void main() {
  group('MatexDividendReinvestmentCalculatorCore', () {
    late MatexDividendReinvestmentCalculatorCore calculator;

    setUp(() {
      calculator = dividendReinvestment();
    });

    group('dividendReinvestment()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator is MatexDividendReinvestmentCalculatorCore, isTrue);
      });
    });
    group('#isDirty', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.isDirty, isFalse);
        final result = calculator.value();
        expect(result, equals(MatexDividendReinvestmentResult()));
      });

      test('should return true when a calculator state is dirty', () {
        calculator.sharePrice(100);
        expect(calculator.isDirty, isTrue);
      });

      test(
        'should return false when a calculator state property '
        'has been reset to its default\'s value',
        () {
          calculator.dividendPaymentFrequency(MatexFrequency.quarterly);

          calculator.dividendPaymentFrequency(
            kDefaultDividendReinvestmentState.dividendPaymentFrequency!,
          );

          expect(calculator.isDirty, isFalse);
        },
      );

      test('should return false when a calculator state has been reset', () {
        calculator.dividendPaymentFrequency(MatexFrequency.quarterly);
        expect(calculator.isDirty, isTrue);

        calculator.reset();
        expect(calculator.isDirty, isFalse);
      });
    });

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.value(), equals(MatexDividendReinvestmentResult()));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () {
        expect(calculator.value(), equals(calculator.value()));
      });
    });

    group('#annualContribution()', () {
      test('Should return proper results when set to annually', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.annually)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualContribution(100)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(220),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(14.2),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1420),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(174.40),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.74),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1374.4),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(210),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1410),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(168.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1368.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to semi-annually', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.semiAnnually)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualContribution(100)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(225.76),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(14.26),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1425.76),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(178.02),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.78),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1378.02),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(210.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1410.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(168.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1368.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to quarterly', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.quarterly)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualContribution(100)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(228.78),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(14.29),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1428.78),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(179.90),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.80),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1379.90),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(210),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1410.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(168.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1368.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to monthly', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.monthly)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualContribution(100)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(230.86),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(14.31),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1430.86),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(181.19),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.81),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1381.19),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(210.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1410.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(168.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1368.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });
    });

    group('#dividendPaymentFrequency()', () {
      test('Should return proper results when set to annually', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.annually)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(210.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1210.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(166.40),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.66),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1166.40),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(200.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1200.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(160.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1160.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to semi-annually', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.semiAnnually)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(215.51),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.16),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1215.51),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(169.86),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.70),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1169.86),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(200.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1200.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(160.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1160.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to quarterly', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.quarterly)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(218.40),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.18),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1218.40),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(171.66),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.72),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1171.66),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(200.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1200.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(160.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1160.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to monthly', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.monthly)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(220.39),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.20),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1220.39),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(172.89),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.73),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1172.89),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(200.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1200.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(160.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1160.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });
    });

    group('#annualSharePriceIncrease()', () {
      test('Should return proper results when set to annually', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.annually)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualSharePriceIncrease(10)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(209.09),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.81),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1429.09),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(165.82),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.44),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1383.82),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(200.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1410.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(160.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1370.00),
        );
        expect(results.yearlyReports.length, equals(2));

        // TODO: add bellow tests to different frequencies
        // once the calculator is done

        results =
            calculator.annualContribution(100).drip(true).taxRate(0).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(218.18),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.62),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1648.18),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(209.09),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.74),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1629.09),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(167.27),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.74),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1587.27),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.drip(true).taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(173.09),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.23),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1601.09),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to semi-annually', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.semiAnnually)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualSharePriceIncrease(10)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(214.28),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.90),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1439.74),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(169.08),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.50),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1391.38),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(200.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1410.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(160.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1370.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to quarterly', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.quarterly)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualSharePriceIncrease(10)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(217.06),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.95),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1445.46),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(170.82),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.53),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1395.40),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(200.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1410.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(160.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1370.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to monthly', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.monthly)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualSharePriceIncrease(10)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(218.99),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.98),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1449.43),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(172.02),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.56),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1398.18),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(200.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1410.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(160.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1370.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });
    });

    group('#annualDividendIncrease()', () {
      test('Should return proper results when set to annually', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.annually)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualDividendIncrease(10)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(221.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.21),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1221.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualContribution(100).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(232.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(14.32),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1432.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualContribution(0).taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(175.04),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.75),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1175.04),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualSharePriceIncrease(10).taxRate(0).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(220),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.90),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1440),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator
            .annualSharePriceIncrease(0)
            .taxRate(20)
            .annualContribution(100)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(183.84),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.84),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1383.84),
        );
        expect(results.yearlyReports.length, equals(2));

        results =
            calculator.annualContribution(0).taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(210.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1210.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(168.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1168.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to semi-annually', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.semiAnnually)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualDividendIncrease(10)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(227.11),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.27),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1227.11),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualContribution(100).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(238.41),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(14.38),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1438.41),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualContribution(0).taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(178.87),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.79),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1178.87),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualSharePriceIncrease(10).taxRate(0).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(225.73),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.00),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1451.45),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator
            .annualSharePriceIncrease(0)
            .taxRate(20)
            .annualContribution(100)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(187.87),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.88),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1387.87),
        );
        expect(results.yearlyReports.length, equals(2));

        results =
            calculator.annualContribution(0).taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(210.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1210.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(168.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1168.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to quarterly', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.quarterly)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualDividendIncrease(10)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(230.33),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.30),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1230.33),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualContribution(100).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(241.80),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(14.42),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1441.80),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualContribution(0).taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(180.88),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.81),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1180.88),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualSharePriceIncrease(10).taxRate(0).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(228.81),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.05),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1457.61),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator
            .annualSharePriceIncrease(0)
            .taxRate(20)
            .annualContribution(100)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(189.97),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.90),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1389.97),
        );
        expect(results.yearlyReports.length, equals(2));

        results =
            calculator.annualContribution(0).taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(210.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1210.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(168.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1168.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });

      test('Should return proper results when set to monthly', () {
        var results = calculator
            .dividendPaymentFrequency(MatexFrequency.monthly)
            .drip(true)
            .sharePrice(100)
            .numberOfShares(10)
            .dividendYield(10)
            .yearsToGrow(2)
            .annualDividendIncrease(10)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(232.55),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.33),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1232.55),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualContribution(100).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(244.12),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(14.44),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1444.12),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualContribution(0).taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(182.24),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(11.82),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1182.24),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.annualSharePriceIncrease(10).taxRate(0).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(230.95),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(12.08),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1461.90),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator
            .annualSharePriceIncrease(0)
            .taxRate(20)
            .annualContribution(100)
            .value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(191.41),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(13.91),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1391.41),
        );
        expect(results.yearlyReports.length, equals(2));

        results =
            calculator.annualContribution(0).taxRate(0).drip(false).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(210.0),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1210.00),
        );
        expect(results.yearlyReports.length, equals(2));

        results = calculator.taxRate(20).value();

        expect(
          double.parse(results.cumulativeNetAmount.toStringAsFixed(2)),
          equals(168.00),
        );
        expect(
          double.parse(results.numberOfShares.toStringAsFixed(2)),
          equals(10),
        );
        expect(
          double.parse(results.endingBalance.toStringAsFixed(2)),
          equals(1168.00),
        );
        expect(results.yearlyReports.length, equals(2));
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator is MatexDividendReinvestmentCalculatorCore, isTrue);
      });

      test('should reset the calculator', () {
        var value = calculator
            .dividendPaymentFrequency(MatexFrequency.quarterly)
            .reset()
            .value();
        expect(value, equals(MatexDividendReinvestmentResult()));
      });
    });
  });
}
