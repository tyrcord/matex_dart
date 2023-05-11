import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../../core/shared/messages.dart';
import '../samples/config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MatexForexProfitAndLossCalculator', () {
    late MatexForexProfitAndLossCalculator calculator;
    late MatexApp matex;

    setUp(() {
      matex = MatexApp(config: testMatexConfig);
      calculator = matex.forexProfitAndLoss();
    });

    group('#forexProfitAndLoss()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        // ignore: unnecessary_type_check
        expect(calculator is MatexForexProfitAndLossCalculator, isTrue);
      });
    });

    group('#isDirty', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () async {
        expect(calculator.isDirty, isFalse);
        final result = await calculator.value();
        expect(result, equals(const MatexProfitAndLossResult()));
      });

      test('should return true when a calculator state is dirty', () {
        calculator.positionSize(100);
        expect(calculator.isDirty, isTrue);
      });

      test(
        'should return false when a calculator state property '
        'has been reset to its default\'s value',
        () {
          calculator.positionSize(100);
          calculator.entryPrice(1.50);
          expect(calculator.isDirty, isTrue);

          calculator.entryPrice(kInitialProfitAndLossState.entryPrice!);
          expect(calculator.isDirty, isTrue);

          calculator.positionSize(kInitialProfitAndLossState.positionSize!);
          expect(calculator.isDirty, isFalse);
        },
      );

      test('should return false when a calculator state has been reset', () {
        calculator.positionSize(100);
        expect(calculator.isDirty, isTrue);

        calculator.reset();
        expect(calculator.isDirty, isFalse);
      });
    });

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () async {
        expect(
            await calculator.value(), equals(const MatexProfitAndLossResult()));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () async {
        expect(await calculator.value(), equals(await calculator.value()));
      });
    });

    group('#positionSize()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.positionSize(100), equals(calculator));
      });

      test('should define the position size', () {
        calculator.positionSize(100);
        expect(calculator.getState().positionSize, equals(100));

        calculator.positionSize(1000);
        expect(calculator.getState().positionSize, equals(1000));
      });

      test('should impact the result', () async {
        calculator
            .positionSize(100000)
            .entryPrice(1.25)
            .exitPrice(1.26)
            .accountCode('USD')
            .currencyPairCode('USD', 'CAD');
        var result = await calculator.value();

        expect(result.profitOrLoss, equals(800));
        expect(result.returnOnInvestement, equals(0.008));

        calculator
            .positionSize(10000)
            .entryPrice(1.25)
            .exitPrice(1.26)
            .accountCode('USD')
            .currencyPairCode('USD', 'CAD');
        result = await calculator.value();
        expect(result.profitOrLoss, equals(80));
        expect(result.returnOnInvestement, equals(0.008));

        calculator
            .positionSize(100000)
            .entryPrice(1.25)
            .exitPrice(1.24)
            .accountCode('USD')
            .currencyPairCode('USD', 'CAD');
        result = await calculator.value();

        expect(result.profitOrLoss, equals(-800));
        expect(result.returnOnInvestement, equals(-0.008));

        calculator
            .positionSize(10000)
            .entryPrice(1.25)
            .exitPrice(1.24)
            .accountCode('USD')
            .currencyPairCode('USD', 'CAD');
        result = await calculator.value();

        expect(result.profitOrLoss, equals(-80));
        expect(result.returnOnInvestement, equals(-0.008));
      });
    });

    group('#entryPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.entryPrice(100), equals(calculator));
      });

      test('should define the entry size', () {
        calculator.entryPrice(100);
        expect(calculator.getState().entryPrice, equals(100));

        calculator.entryPrice(1000);
        expect(calculator.getState().entryPrice, equals(1000));
      });

      test('should impact the result', () async {
        calculator
            .positionSize(100000)
            .entryPrice(1.20)
            .exitPrice(1.21)
            .accountCode('USD')
            .currencyPairCode('EUR', 'USD');
        var result = await calculator.value();

        expect(result.profitOrLoss, equals(1000));
        expect(result.returnOnInvestement.toStringAsFixed(4), equals('0.0083'));

        calculator
            .positionSize(100000)
            .entryPrice(1.205)
            .exitPrice(1.21)
            .accountCode('USD')
            .currencyPairCode('EUR', 'USD');
        result = await calculator.value();

        expect(result.profitOrLoss, equals(500));
        expect(result.returnOnInvestement.toStringAsFixed(4), equals('0.0041'));

        calculator
            .positionSize(100000)
            .entryPrice(1.20)
            .exitPrice(1.15)
            .accountCode('USD')
            .currencyPairCode('EUR', 'USD');
        result = await calculator.value();

        expect(result.profitOrLoss, equals(-5000));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.0417'),
        );
      });
    });

    group('#exitPrice()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.exitPrice(100), equals(calculator));
      });

      test('should define the entry size', () {
        calculator.exitPrice(100);
        expect(calculator.getState().exitPrice, equals(100));

        calculator.exitPrice(1000);
        expect(calculator.getState().exitPrice, equals(1000));
      });

      test('should impact the result', () async {
        calculator
            .positionSize(100000)
            .entryPrice(1.20)
            .exitPrice(1.25)
            .accountCode('USD')
            .currencyPairCode('AUD', 'CAD');
        var result = await calculator.value();

        expect(result.profitOrLoss, equals(4000));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('0.0417'),
        );

        calculator
            .positionSize(100000)
            .entryPrice(1.20)
            .exitPrice(1.30)
            .accountCode('USD')
            .currencyPairCode('AUD', 'CAD');
        result = await calculator.value();

        expect(result.profitOrLoss, equals(8000));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('0.0833'),
        );

        calculator
            .positionSize(100000)
            .entryPrice(1.20)
            .exitPrice(1.15)
            .accountCode('USD')
            .currencyPairCode('AUD', 'CAD');
        result = await calculator.value();

        expect(result.profitOrLoss, equals(-4000));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.0417'),
        );
      });
    });

    group('#position()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.position(MatexPosition.short), equals(calculator));
      });

      test('should be equal to long by default', () {
        expect(calculator.getState().position, equals(MatexPosition.long));
      });

      test('should define the position', () {
        calculator.position(MatexPosition.short);
        expect(calculator.getState().position, equals(MatexPosition.short));

        calculator.position(MatexPosition.long);
        expect(calculator.getState().position, equals(MatexPosition.long));
      });

      test('should impact the result', () async {
        calculator
            .positionSize(100000)
            .entryPrice(1.20)
            .exitPrice(1.25)
            .accountCode('USD')
            .currencyPairCode('EUR', 'USD')
            .position(MatexPosition.long);
        var result = await calculator.value();

        expect(result.profitOrLoss, equals(5000));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('0.0417'),
        );

        calculator
            .positionSize(100000)
            .entryPrice(1.20)
            .exitPrice(1.15)
            .accountCode('USD')
            .currencyPairCode('EUR', 'USD')
            .position(MatexPosition.long);
        result = await calculator.value();

        expect(result.profitOrLoss, equals(-5000));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.0417'),
        );

        calculator
            .positionSize(100000)
            .entryPrice(1.20)
            .exitPrice(1.25)
            .accountCode('USD')
            .currencyPairCode('EUR', 'USD')
            .position(MatexPosition.short);
        result = await calculator.value();

        expect(result.profitOrLoss, equals(-5000));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.0417'),
        );

        calculator
            .positionSize(100000)
            .entryPrice(1.20)
            .exitPrice(1.15)
            .accountCode('USD')
            .currencyPairCode('EUR', 'USD')
            .position(MatexPosition.short);
        result = await calculator.value();

        expect(result.profitOrLoss, equals(5000));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('0.0417'),
        );
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        // ignore: unnecessary_type_check
        expect(calculator is MatexForexProfitAndLossCalculator, isTrue);
      });

      test('should reset the calculator', () async {
        var value = await calculator
            .positionSize(100000)
            .entryPrice(1.25)
            .exitPrice(1.26)
            .accountCode('USD')
            .currencyPairCode('USD', 'CAD')
            .reset()
            .value();
        expect(value, equals(const MatexProfitAndLossResult()));
      });
    });
  });
}
