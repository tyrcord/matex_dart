import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class StopLossCalculator extends BaseCalculator<StopLossState, StopLossResult>
    with
        StopLossMixin<StopLossCalculator, StopLossState, StopLossResult>,
        PipValueMixin<StopLossCalculator, StopLossState, StopLossResult> {
  StopLossCalculator({
    StopLossState initialState,
  }) : super(
          initialState: initialState ?? initialStopLossState,
        );

  @override
  StopLossResult value({double pipValue}) {
    if (result != null) {
      return result;
    }

    if (pipValue != null) {
      pipValue = computePipValue();
    }

    return (result = _computeStopLossLevels(pipValue));
  }

  StopLossResult _computeStopLossLevels(double pipValue) {
    final pipPrecision = validState.pipPrecision;
    final stopLossAmount = validState.stopLossAmount;
    final stopLossPips = validState.stopLossPips;
    final stopLossPrice = validState.stopLossPrice;
    final divider = Decimal.fromInt(10).pow(pipPrecision).toDouble();

    if (stopLossAmount > 0) {
      return _computeStopLossWithAmount(stopLossAmount, pipValue, divider);
    } else if (stopLossPips > 0) {
      return _computeStopLossWithPips(stopLossPips, pipValue, divider);
    } else if (stopLossPrice > 0) {
      return _computeStopLossWithPrice(stopLossPrice, pipValue, divider);
    }

    return _buildStopLossResult();
  }

  StopLossResult _computeStopLossWithAmount(
    double stopLossAmount,
    double pipValue,
    double divider,
  ) {
    final stopLossPips = (Decimal.parse(stopLossAmount.toString()) /
            Decimal.parse(pipValue.toString()))
        .toDouble();

    return _buildStopLossResult(
      amount: stopLossAmount,
      pips: stopLossPips,
      price: _computeStopLossPrice(stopLossPips, divider),
    );
  }

  StopLossResult _computeStopLossWithPrice(
    double stopLossPrice,
    double pipValue,
    double divider,
  ) {
    final position = validState.position;
    final entryPrice = validState.entryPrice;
    final _divider = Decimal.parse(divider.toString());
    final stopLossPriceParsed = Decimal.parse(stopLossPrice.toString());
    final entryPriceParsed = Decimal.parse(entryPrice.toString());
    double stopLossPips = 0.0;

    if (position == Position.Long && stopLossPrice < entryPrice) {
      stopLossPips =
          ((entryPriceParsed - stopLossPriceParsed) * _divider).toDouble();
    }

    if (position == Position.Short && stopLossPrice > entryPrice) {
      stopLossPips =
          ((stopLossPriceParsed - entryPriceParsed) * _divider).toDouble();
    }

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  StopLossResult _computeStopLossWithPips(
    double stopLossPips,
    double pipValue,
    double divider,
  ) {
    final stopLossPrice = _computeStopLossPrice(stopLossPips, divider);

    return _buildStopLossResult(
      amount: _computeStopLossAmount(stopLossPips, pipValue),
      pips: stopLossPips,
      price: stopLossPrice,
    );
  }

  double _computeStopLossAmount(double stopLossPips, double pipValue) {
    return (Decimal.parse(stopLossPips.toString()) *
            Decimal.parse(pipValue.toString()))
        .toDouble();
  }

  double _computeStopLossPrice(double stopLossPips, double divider) {
    final position = validState.position;
    final entryPrice = validState.entryPrice;
    final _divider = Decimal.parse(divider.toString());

    final deltaPrice = Decimal.parse(stopLossPips.toString()) / _divider;
    final entryPriceBigNumber = Decimal.parse(entryPrice.toString());

    return (position == Position.Long
            ? entryPriceBigNumber - deltaPrice
            : entryPriceBigNumber + deltaPrice)
        .toDouble();
  }

  StopLossResult _buildStopLossResult({
    double amount,
    double pips,
    double price,
  }) {
    return StopLossResult(
      amount: amount,
      pips: pips,
      price: price,
    );
  }
}

StopLossCalculator stopLoss() => StopLossCalculator();
