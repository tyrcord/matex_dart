import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexPipDeltaCalculatorCore
    extends MatexBaseCalculator<MatexPipDeltaCalculatorCore, double>
    with MatexPipDeltaCoreMixin<MatexPipDeltaCalculatorCore, double> {
  MatexPipDeltaCalculatorCore({
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? pipDeltaValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialPipDeltaState;

  @override
  double value() {
    if (result != null) {
      return result!;
    }

    if (isValid) {
      final pipPrecision = state.pipPrecision!;
      final priceA = state.priceA!.toString();
      final priceB = state.priceB!.toString();
      final decimalMultiplicator = pow(10, pipPrecision).toString();

      final dPriceA = Decimal.parse(priceA);
      final dPriceB = Decimal.parse(priceB);
      final dDelta = dPriceA - dPriceB;
      final dDecimalMultiplicator = Decimal.parse(decimalMultiplicator);
      final dResult = dDelta * dDecimalMultiplicator;
      final absoluteResult = dResult.toDouble().abs();

      return (result = double.parse(absoluteResult.toStringAsFixed(1)));
    }

    return 0;
  }
}

MatexPipDeltaCalculatorCore pipDelta({
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) =>
    MatexPipDeltaCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
