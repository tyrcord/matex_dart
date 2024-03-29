import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexStopLossCalculatorCore extends MatexBaseCalculator<
        MatexStopLossCalculatorCore, MatexStopLossResult>
    with
        MatexStopLossCoreMixin<MatexStopLossCalculatorCore,
            MatexStopLossResult>,
        MatexPipValueCoreMixin<MatexStopLossCalculatorCore,
            MatexStopLossResult> {
  MatexStopLossCalculatorCore({
    MatexBaseCoreState? defaultState,
  }) : super(defaultState: defaultState);

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialStopLossState;

  @override
  MatexStopLossResult value({Decimal? pipValue}) {
    if (result != null) return result!;

    pipValue ??= computePipValue();

    return (result = _computeStopLossLevels(pipValue));
  }

  MatexStopLossResult _computeStopLossLevels(Decimal pipValue) {
    final pipPrecision = state.pipPrecision!;
    final stopLossAmount = state.stopLossAmount!;
    final stopLossPips = state.stopLossPips!;
    final stopLossPrice = state.stopLossPrice!;
    final divider = pow(10, pipPrecision).toDouble();

    if (stopLossAmount > 0) {
      return _computeStopLossWithAmount(stopLossAmount, pipValue, divider);
    } else if (stopLossPips > 0) {
      return _computeStopLossWithPips(stopLossPips, pipValue, divider);
    } else if (stopLossPrice > 0) {
      return _computeStopLossWithPrice(stopLossPrice, pipValue, divider);
    }

    return _buildStopLossResult();
  }

  MatexStopLossResult _computeStopLossWithAmount(
    double stopLossAmount,
    Decimal pipValue,
    double divider,
  ) {
    final stopLossPips =
        (Decimal.parse(stopLossAmount.toString()) / pipValue).toDouble();

    return _buildStopLossResult(
      amount: stopLossAmount,
      pips: stopLossPips,
      price: _computeStopLossPrice(stopLossPips, divider),
    );
  }

  MatexStopLossResult _computeStopLossWithPrice(
    double stopLossPrice,
    Decimal pipValue,
    double divider,
  ) {
    final position = state.position;
    final entryPrice = state.entryPrice!;
    final divider0 = Decimal.parse(divider.toString());
    final stopLossPriceParsed = Decimal.parse(stopLossPrice.toString());
    final entryPriceParsed = Decimal.parse(entryPrice.toString());
    var stopLossPips = 0.0;

    if (position == MatexPosition.long && stopLossPrice < entryPrice) {
      stopLossPips =
          ((entryPriceParsed - stopLossPriceParsed) * divider0).toDouble();
    }

    if (position == MatexPosition.short && stopLossPrice > entryPrice) {
      stopLossPips =
          ((stopLossPriceParsed - entryPriceParsed) * divider0).toDouble();
    }

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  MatexStopLossResult _computeStopLossWithPips(
    double stopLossPips,
    Decimal pipValue,
    double divider,
  ) {
    final stopLossPrice = _computeStopLossPrice(stopLossPips, divider);

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  double _computeStopLossAmount(double stopLossPips, Decimal pipValue) {
    return (Decimal.parse(stopLossPips.toString()) * pipValue).toDouble();
  }

  double _computeStopLossPrice(double stopLossPips, double divider) {
    final position = state.position;
    final entryPrice = state.entryPrice;
    final divider0 = Decimal.parse(divider.toString());

    final deltaPrice =
        toDecimal(Decimal.parse(stopLossPips.toString()) / divider0);
    final entryPriceBigNumber = Decimal.parse(entryPrice.toString());

    return (position == MatexPosition.long
            ? entryPriceBigNumber - deltaPrice
            : entryPriceBigNumber + deltaPrice)
        .toDouble();
  }

  MatexStopLossResult _buildStopLossResult({
    double amount = 0,
    double pips = 0,
    double price = 0,
  }) {
    return MatexStopLossResult(
      amount: amount,
      pips: pips,
      price: price,
    );
  }
}

MatexStopLossCalculatorCore stopLoss({MatexBaseCoreState? defaultState}) =>
    MatexStopLossCalculatorCore(defaultState: defaultState);
