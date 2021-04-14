import 'package:matex_dart/matex_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/messages.dart';

void main() {
  group('MatexProfitAndLossCalculatorCore', () {
    late MatexProfitAndLossCalculatorCore calculator;

    setUp(() {
      calculator = profitAndLoss();
    });

    group('profitAndLoss()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator is MatexProfitAndLossCalculatorCore, isTrue);
      });
    });
    group('#isDirty', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.isDirty, isFalse);
        final result = calculator.value();
        expect(result, equals(MatexProfitAndLossResult()));
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
      test(SHOULD_RETURN_DEFAULT_RESULT, () {
        expect(calculator.value(), equals(MatexProfitAndLossResult()));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () {
        expect(calculator.value(), equals(calculator.value()));
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

      test('should impact the result', () {
        calculator.positionSize(100).entryPrice(10).exitPrice(15);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(500));
        expect(result.returnOnInvestement, equals(0.5));

        calculator.positionSize(10).entryPrice(10).exitPrice(15);
        result = calculator.value();

        expect(result.profitOrLoss, equals(50));
        expect(result.returnOnInvestement, equals(0.5));

        calculator.positionSize(100).entryPrice(10).exitPrice(5);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-500));
        expect(result.returnOnInvestement, equals(-0.5));

        calculator.positionSize(10).entryPrice(10).exitPrice(5);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-50));
        expect(result.returnOnInvestement, equals(-0.5));
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

      test('should impact the result', () {
        calculator.positionSize(100).entryPrice(10).exitPrice(15);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(500));
        expect(result.returnOnInvestement, equals(0.5));

        calculator.positionSize(100).entryPrice(5).exitPrice(15);
        result = calculator.value();

        expect(result.profitOrLoss, equals(1000));
        expect(result.returnOnInvestement, equals(2));

        calculator.positionSize(100).entryPrice(10).exitPrice(5);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-500));
        expect(result.returnOnInvestement, equals(-0.5));

        calculator.positionSize(100).entryPrice(7.5).exitPrice(5);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-250));
        expect(result.returnOnInvestement, equals(-1 / 3));
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

      test('should impact the result', () {
        calculator.positionSize(100).entryPrice(10).exitPrice(15);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(500));
        expect(result.returnOnInvestement, equals(0.5));

        calculator.positionSize(100).entryPrice(10).exitPrice(20);
        result = calculator.value();

        expect(result.profitOrLoss, equals(1000));
        expect(result.returnOnInvestement, equals(1));

        calculator.positionSize(100).entryPrice(10).exitPrice(5);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-500));
        expect(result.returnOnInvestement, equals(-0.5));

        calculator.positionSize(100).entryPrice(10).exitPrice(2.5);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-750));
        expect(result.returnOnInvestement, equals(-0.75));

        calculator.positionSize(100).entryPrice(10).exitPrice(0);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-1000));
        expect(result.returnOnInvestement, equals(-1));
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

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .position(MatexPosition.long);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(500));
        expect(result.returnOnInvestement, equals(0.5));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-500));
        expect(result.returnOnInvestement, equals(-0.5));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .position(MatexPosition.long);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-500));
        expect(result.returnOnInvestement, equals(-0.5));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(500));
        expect(result.returnOnInvestement, equals(0.5));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(30)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-2000));
        expect(result.returnOnInvestement, equals(-2));
      });
    });

    group('#taxeRate()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.taxeRate(30), equals(calculator));
      });

      test('should be equal to 0 by default', () {
        expect(calculator.getState().taxeRate, equals(0));
      });

      test('should invalid the state when its value is less than 0', () {
        calculator.taxeRate(-1);
        expect(calculator.isValid, isFalse);
      });

      test('should invalid the state when its value is greater than 100', () {
        calculator.taxeRate(101);
        expect(calculator.isValid, isFalse);
      });

      test('should define the tax rate', () {
        calculator.taxeRate(30);
        expect(calculator.getState().taxeRate, equals(30));

        calculator.taxeRate(15);
        expect(calculator.getState().taxeRate, equals(15));
      });

      test('should impact the result', () {
        calculator.positionSize(100).entryPrice(10).exitPrice(15).taxeRate(30);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(350));
        expect(result.returnOnInvestement, equals(0.35));

        calculator.positionSize(100).entryPrice(10).exitPrice(15).taxeRate(15);
        result = calculator.value();

        expect(result.profitOrLoss, equals(425));
        expect(result.returnOnInvestement, equals(0.425));

        calculator.positionSize(100).entryPrice(10).exitPrice(5).taxeRate(15);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-500));
        expect(result.returnOnInvestement, equals(-0.5));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .taxeRate(30)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(350));
        expect(result.returnOnInvestement, equals(0.35));
      });
    });

    group('#entryFeeAmount()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.entryFeeAmount(100), equals(calculator));
      });

      test('should define the entry fee amount', () {
        calculator.entryFeeAmount(100);
        expect(calculator.getState().entryFeeAmount, equals(100));

        calculator.entryFeeAmount(1000);
        expect(calculator.getState().entryFeeAmount, equals(1000));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .entryFeeAmount(50);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(450));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('0.4286'),
        );

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .entryFeeAmount(50);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-550));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.5238'),
        );

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .entryFeeAmount(50)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(450));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('0.4286'),
        );

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .entryFeeAmount(50)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-550));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.5238'),
        );
      });
    });

    group('#exitFeeAmount()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.exitFeeAmount(100), equals(calculator));
      });

      test('should define the exit fee amount', () {
        calculator.exitFeeAmount(100);
        expect(calculator.getState().exitFeeAmount, equals(100));

        calculator.exitFeeAmount(1000);
        expect(calculator.getState().exitFeeAmount, equals(1000));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitFeeAmount(50);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(450));
        expect(result.returnOnInvestement, equals(0.45));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitFeeAmount(50);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-550));
        expect(result.returnOnInvestement, equals(-0.55));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitFeeAmount(50)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(450));
        expect(result.returnOnInvestement, equals(0.45));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitFeeAmount(50)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-550));
        expect(result.returnOnInvestement, equals(-0.55));
      });
    });

    group('#exitFeePercentage()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.exitFeePercentage(100), equals(calculator));
      });

      test('should invalid the state when its value is less than 0', () {
        calculator.entryFeePercentage(-1);
        expect(calculator.isValid, isFalse);
      });

      test('should invalid the state when its value is greater than 100', () {
        calculator.entryFeePercentage(101);
        expect(calculator.isValid, isFalse);
      });

      test('should define the exit fee amount', () {
        calculator.exitFeePercentage(100);
        expect(calculator.getState().exitFeePercentage, equals(100));

        calculator.exitFeePercentage(50);
        expect(calculator.getState().exitFeePercentage, equals(50));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitFeePercentage(10);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(350));
        expect(result.returnOnInvestement, equals(0.35));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitFeePercentage(10);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-550));
        expect(result.returnOnInvestement, equals(-0.55));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitFeePercentage(10)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(450));
        expect(result.returnOnInvestement, equals(0.45));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitFeePercentage(10)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-650));
        expect(result.returnOnInvestement, equals(-0.65));
      });
    });

    group('#entryFeePercentage()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.entryFeePercentage(100), equals(calculator));
      });

      test('should invalid the state when its value is less than 0', () {
        calculator.entryFeePercentage(-1);
        expect(calculator.isValid, isFalse);
      });

      test('should invalid the state when its value is greater than 100', () {
        calculator.entryFeePercentage(101);
        expect(calculator.isValid, isFalse);
      });

      test('should define the entry fee percentage', () {
        calculator.entryFeePercentage(100);
        expect(calculator.getState().entryFeePercentage, equals(100));

        calculator.entryFeePercentage(50);
        expect(calculator.getState().entryFeePercentage, equals(50));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .entryFeePercentage(10);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(400));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('0.3636'),
        );

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .entryFeePercentage(10);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-600));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.5455'),
        );

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .entryFeePercentage(10)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(400));
        expect(result.returnOnInvestement.toStringAsFixed(4), equals('0.3636'));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .entryFeePercentage(10)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-600));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.5455'),
        );
      });
    });
    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator is MatexProfitAndLossCalculatorCore, isTrue);
      });

      test('should reset the calculator', () {
        var value = calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitFeeAmount(50)
            .reset()
            .value();
        expect(value, equals(MatexProfitAndLossResult()));
      });
    });
  });
}
