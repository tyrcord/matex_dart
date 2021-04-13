import 'package:matex_dart/matex_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/shared/messages.dart';
import '../samples/config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MatexPipDeltaCalculatorCore', () {
    late MatexPipDeltaCalculator calculator;
    late MatexApp matex;

    setUp(() {
      matex = MatexApp(config: testMatexConfig);
      calculator = matex.pipDelta();
    });

    group('pipDelta()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator is MatexPipDeltaCalculator, isTrue);
      });
    });

    group('#isDirty', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () async {
        expect(calculator.isDirty, isFalse);
        final result = await calculator.value();
        expect(result, equals(0));
      });

      test('should return true when a calculator state is dirty', () {
        calculator.priceA(1.5);
        expect(calculator.isDirty, isTrue);
      });

      test(
        'should return false when a calculator state property '
        'has been reset to its default\'s value',
        () {
          calculator.priceA(1.5);
          calculator.priceB(1.20);
          expect(calculator.isDirty, isTrue);

          calculator.priceA(kInitialPipDeltaState.priceA!);
          expect(calculator.isDirty, isTrue);

          calculator.priceB(kInitialPipDeltaState.priceB!);
          expect(calculator.isDirty, isFalse);
        },
      );

      test('should return false when a calculator state has been reset', () {
        calculator.priceA(1.5);
        expect(calculator.isDirty, isTrue);

        calculator.reset();
        expect(calculator.isDirty, isFalse);
      });
    });

    group('#isValid', () {
      test('should not be valid by default', () {
        expect(calculator.isValid, isFalse);
      });

      test('should not be valid when both prices are set to zero', () {
        calculator.priceA(0).priceB(0);
        expect(calculator.isValid, isFalse);
      });

      test('should be valid when only the price A is set', () {
        calculator.priceB(1.5).currencyPairCode('EUR', 'USD');
        expect(calculator.isValid, isTrue);
      });

      test('should be valid when only the price B is set', () {
        calculator.priceB(1.5).currencyPairCode('EUR', 'USD');
        expect(calculator.isValid, isTrue);
      });

      test('should be valid when the price A and B are set', () {
        calculator.priceA(1.5).priceB(1.6).currencyPairCode('EUR', 'USD');
        expect(calculator.isValid, isTrue);
      });
    });

    group('#priceA()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.priceA(1.5), equals(calculator));
      });

      test('should define the price A', () {
        calculator.priceA(1.5);
        expect(calculator.getState().priceA, equals(1.5));
      });

      test('should impact the result', () async {
        calculator
            .priceB(1.20502)
            .priceA(1.20460)
            .currencyPairCode('EUR', 'USD');
        expect(await calculator.value(), equals(4.2));

        calculator.priceB(1.205).priceA(1.204).currencyPairCode('USD', 'JPY');
        expect(await calculator.value(), equals(0.1));
      });
    });

    group('#priceB()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.priceB(1.5), equals(calculator));
      });

      test('should define the price B', () {
        calculator.priceB(1.5);
        expect(calculator.getState().priceB, equals(1.5));
      });

      test('should impact the result', () async {
        calculator
            .priceA(1.20502)
            .priceB(1.20460)
            .currencyPairCode('EUR', 'USD');
        expect(await calculator.value(), equals(4.2));

        calculator.priceA(1.205).priceB(1.204).currencyPairCode('USD', 'JPY');
        expect(await calculator.value(), equals(0.1));
      });
    });

    group('#pipPrecision()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.pipPrecision(2), equals(calculator));
      });

      test('should define the pip precision value', () {
        calculator.pipPrecision(2);
        expect(calculator.getState().pipPrecision, equals(2));
      });

      test('should impact the result', () async {
        calculator.priceA(1.50).priceB(1.40).currencyPairCode('USD', 'JPY');
        expect(await calculator.value(), equals(10));

        calculator.priceA(1.50).priceB(1.40).currencyPairCode('EUR', 'USD');
        expect(await calculator.value(), equals(1000));
      });
    });

    group('#value()', () {
      test(SHOULD_RETURN_DEFAULT_RESULT, () async {
        expect(await calculator.value(), equals(0));
      });

      test(SHOULD_MEMOIZE_LAST_VALUE, () async {
        expect(await calculator.value(), equals(await calculator.value()));
      });
    });

    group('#reset()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        expect(calculator.reset(), equals(calculator));
      });

      test('should reset the calculator', () async {
        var value = await calculator.priceA(1.5).priceB(1.6).reset().value();
        expect(value, equals(0));
      });
    });
  });
}
