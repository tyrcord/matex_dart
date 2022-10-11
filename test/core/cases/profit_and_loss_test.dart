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

      test('Should return proper results', () {
        calculator
            .fixedCosts(100)
            .positionSize(100)
            .entryPrice(10)
            .entryFeeAmountPerUnit(1)
            .exitPrice(20)
            .exitFeeAmountPerUnit(1)
            .taxRate(30);
        var result = calculator.value();

        expect(result.entryCostsAmount, equals(100));
        expect(result.exitCostsAmount, equals(100));
        expect(result.totalCosts, equals(300));
        expect(result.grossBuyPrice, equals(1000));
        expect(result.netBuyPrice, equals(1100));
        expect(result.grossSellPrice, equals(2000));
        expect(result.netSellPrice, equals(1900));
        expect(result.profitOrLoss, equals(490));
        expect(result.taxAmount, equals(210));
        expect(result.breakEvenUnits, equals(13));
        expect(result.returnOnInvestement.toStringAsFixed(4), equals('0.4455'));
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
        expect(
          result.returnOnInvestement,
          equals(-1 / 3),
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

    group('#taxRate()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.taxRate(30), equals(calculator));
      });

      test('should be equal to 0 by default', () {
        expect(calculator.getState().taxRate, equals(0));
      });

      test('should invalid the state when its value is less than 0', () {
        calculator.taxRate(-1);
        expect(calculator.isValid, isFalse);
      });

      test('should invalid the state when its value is greater than 100', () {
        calculator.taxRate(101);
        expect(calculator.isValid, isFalse);
      });

      test('should define the tax rate', () {
        calculator.taxRate(30);
        expect(calculator.getState().taxRate, equals(30));

        calculator.taxRate(15);
        expect(calculator.getState().taxRate, equals(15));
      });

      test('should impact the result', () {
        calculator.positionSize(100).entryPrice(10).exitPrice(15).taxRate(30);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(350));
        expect(result.returnOnInvestement, equals(0.35));

        calculator.positionSize(100).entryPrice(10).exitPrice(15).taxRate(15);
        result = calculator.value();

        expect(result.profitOrLoss, equals(425));
        expect(result.returnOnInvestement, equals(0.425));

        calculator.positionSize(100).entryPrice(10).exitPrice(5).taxRate(15);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-500));
        expect(result.returnOnInvestement, equals(-0.5));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .taxRate(30)
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

    group('#entryFeeAmountPerUnit()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.entryFeeAmountPerUnit(1), equals(calculator));
      });

      test('should define the entry fee amount', () {
        calculator.entryFeeAmountPerUnit(1);
        expect(calculator.getState().entryFeeAmountPerUnit, equals(1));

        calculator.entryFeeAmountPerUnit(2);
        expect(calculator.getState().entryFeeAmountPerUnit, equals(2));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .entryFeeAmountPerUnit(1);
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
            .entryFeeAmountPerUnit(1);
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
            .entryFeeAmountPerUnit(1)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(400));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('0.3636'),
        );

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .entryFeeAmountPerUnit(1)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-600));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.5455'),
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

    group('#exitFeeAmountPerUnit()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.exitFeeAmountPerUnit(1), equals(calculator));
      });

      test('should define the exit fee amount per unit', () {
        calculator.exitFeeAmountPerUnit(1);
        expect(calculator.getState().exitFeeAmountPerUnit, equals(1));

        calculator.exitFeeAmountPerUnit(2);
        expect(calculator.getState().exitFeeAmountPerUnit, equals(2));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitFeeAmountPerUnit(1);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(400));
        expect(result.returnOnInvestement, equals(0.4));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitFeeAmountPerUnit(1);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-600));
        expect(result.returnOnInvestement, equals(-0.6));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitFeeAmountPerUnit(1)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(400));
        expect(result.returnOnInvestement, equals(0.4));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitFeeAmountPerUnit(1)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-600));
        expect(result.returnOnInvestement, equals(-0.6));
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

    group('#exitFeePercentagePerUnit()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.exitFeePercentagePerUnit(1), equals(calculator));
      });

      test('should invalid the state when its value is less than 0', () {
        calculator.exitFeePercentagePerUnit(-1);
        expect(calculator.isValid, isFalse);
      });

      test('should invalid the state when its value is greater than 100', () {
        calculator.exitFeePercentagePerUnit(101);
        expect(calculator.isValid, isFalse);
      });

      test('should define the exit fee amount', () {
        calculator.exitFeePercentagePerUnit(1);
        expect(calculator.getState().exitFeePercentagePerUnit, equals(1));

        calculator.exitFeePercentagePerUnit(2);
        expect(calculator.getState().exitFeePercentagePerUnit, equals(2));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitFeePercentagePerUnit(1);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(485));
        expect(result.returnOnInvestement, equals(0.485));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitFeePercentagePerUnit(1);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-505));
        expect(result.returnOnInvestement, equals(-0.505));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitFeePercentagePerUnit(1)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(495));
        expect(result.returnOnInvestement, equals(0.495));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitFeePercentagePerUnit(1)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-515));
        expect(result.returnOnInvestement, equals(-0.515));
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

    group('#entryFeePercentagePerUnit()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.entryFeePercentagePerUnit(1), equals(calculator));
      });

      test('should invalid the state when its value is less than 0', () {
        calculator.entryFeePercentagePerUnit(-1);
        expect(calculator.isValid, isFalse);
      });

      test('should invalid the state when its value is greater than 100', () {
        calculator.entryFeePercentagePerUnit(101);
        expect(calculator.isValid, isFalse);
      });

      test('should define the entry fee percentage', () {
        calculator.entryFeePercentagePerUnit(1);
        expect(calculator.getState().entryFeePercentagePerUnit, equals(1));

        calculator.entryFeePercentagePerUnit(2);
        expect(calculator.getState().entryFeePercentagePerUnit, equals(2));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .entryFeePercentagePerUnit(1);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(490));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('0.4851'),
        );

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .entryFeePercentagePerUnit(1);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-510));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.5050'),
        );

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .entryFeePercentagePerUnit(1)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(490));
        expect(result.returnOnInvestement.toStringAsFixed(4), equals('0.4851'));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .entryFeePercentagePerUnit(1)
            .position(MatexPosition.short);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-510));
        expect(
          result.returnOnInvestement.toStringAsFixed(4),
          equals('-0.5050'),
        );
      });
    });

    group('#fixedCosts()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.fixedCosts(5), equals(calculator));
      });

      test('should define the fixed costs', () {
        calculator.fixedCosts(100);
        expect(calculator.getState().fixedCosts, equals(100));

        calculator.fixedCosts(1000);
        expect(calculator.getState().fixedCosts, equals(1000));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .fixedCosts(50);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(450));
        expect(result.returnOnInvestement, equals(0.45));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .fixedCosts(100);
        result = calculator.value();

        expect(result.profitOrLoss, equals(400));
        expect(result.returnOnInvestement, equals(0.4));

        calculator.positionSize(100).entryPrice(10).exitPrice(5).fixedCosts(50);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-550));
        expect(result.returnOnInvestement, equals(-0.55));

        calculator
            .positionSize(100)
            .entryPrice(7.5)
            .exitPrice(5)
            .fixedCosts(50);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-300));
        expect(result.returnOnInvestement, equals(-0.4));
      });
    });

    group('#exitDiscountAmount()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.exitDiscountAmount(5), equals(calculator));
      });

      test('should define the fixed costs', () {
        calculator.exitDiscountAmount(100);
        expect(calculator.getState().exitDiscountAmount, equals(100));

        calculator.exitDiscountAmount(1000);
        expect(calculator.getState().exitDiscountAmount, equals(1000));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitDiscountAmount(1);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(400));
        expect(result.returnOnInvestement, equals(0.4));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitDiscountAmount(2);
        result = calculator.value();

        expect(result.profitOrLoss, equals(300));
        expect(result.returnOnInvestement, equals(0.3));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitDiscountAmount(1);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-600));
        expect(result.returnOnInvestement, equals(-0.6));

        calculator
            .positionSize(100)
            .entryPrice(7.5)
            .exitPrice(5)
            .exitDiscountAmount(2);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-450));
        expect(result.returnOnInvestement, equals(-0.6));
      });
    });

    group('#exitDiscountPercentage()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.exitDiscountPercentage(5), equals(calculator));
      });

      test('should define the fixed costs', () {
        calculator.exitDiscountPercentage(5);
        expect(calculator.getState().exitDiscountPercentage, equals(5));

        calculator.exitDiscountPercentage(10);
        expect(calculator.getState().exitDiscountPercentage, equals(10));
      });

      test('should impact the result', () {
        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitDiscountPercentage(5);
        var result = calculator.value();

        expect(result.profitOrLoss, equals(425));
        expect(result.returnOnInvestement, equals(0.425));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(15)
            .exitDiscountPercentage(10);
        result = calculator.value();

        expect(result.profitOrLoss, equals(350));
        expect(result.returnOnInvestement, equals(0.35));

        calculator
            .positionSize(100)
            .entryPrice(10)
            .exitPrice(5)
            .exitDiscountPercentage(5);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-525));
        expect(result.returnOnInvestement, equals(-0.525));

        calculator
            .positionSize(100)
            .entryPrice(7.5)
            .exitPrice(5)
            .exitDiscountPercentage(10);
        result = calculator.value();

        expect(result.profitOrLoss, equals(-300));
        expect(result.returnOnInvestement, equals(-0.4));
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
