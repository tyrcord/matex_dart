import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class TakeProfitCalculator extends BaseCalculator<TakeProfitCalculator,
        TakeProfitState, TakeProfitResult>
    with
        TakeProfitMixin<TakeProfitCalculator, TakeProfitState,
            TakeProfitResult>,
        PipValueMixin<TakeProfitCalculator, TakeProfitState, TakeProfitResult> {
  TakeProfitCalculator({
    TakeProfitState initialState,
  }) : super(
          initialState: initialState ?? kInitialTakeProfitState,
        );

  @override
  TakeProfitResult value({Decimal pipValue}) {
    if (result != null) {
      return result;
    }

    pipValue ??= computePipValue();
    return (result = _computeTakeProfitLevels(pipValue));
  }

  TakeProfitResult _computeTakeProfitLevels(Decimal pipValue) {
    final pipPrecision = validState.pipPrecision;
    final takeProfitAmount = validState.takeProfitAmount;
    final takeProfitPips = validState.takeProfitPips;
    final takeProfitPrice = validState.takeProfitPrice;
    final divider = Decimal.fromInt(10).pow(pipPrecision).toDouble();

    if (takeProfitAmount > 0) {
      return _computeTakeProfitWithAmount(
        takeProfitAmount,
        pipValue,
        divider,
      );
    } else if (takeProfitPips > 0) {
      return _computeTakeProfitWithPips(takeProfitPips, pipValue, divider);
    } else if (takeProfitPrice > 0) {
      return _computeTakeProfitWithPrice(
        takeProfitPrice,
        pipValue,
        divider,
      );
    }

    return _buildTakeProfitResult();
  }

  TakeProfitResult _computeTakeProfitWithAmount(
    double takeProfitAmount,
    Decimal pipValue,
    double divider,
  ) {
    final takeProfitPips =
        (Decimal.parse(takeProfitAmount.toString()) / pipValue).toDouble();

    return _buildTakeProfitResult(
      amount: takeProfitAmount,
      pips: takeProfitPips,
      price: _computeTakeProfitPrice(takeProfitPips, divider),
    );
  }

  TakeProfitResult _computeTakeProfitWithPrice(
    double takeProfitPrice,
    Decimal pipValue,
    double divider,
  ) {
    final position = validState.position;
    final entryPrice = validState.entryPrice;
    final _divider = Decimal.parse(divider.toString());
    final takeProfitPriceParsed = Decimal.parse(takeProfitPrice.toString());
    final entryPriceParsed = Decimal.parse(entryPrice.toString());
    var takeProfitPips = 0.0;

    if (position == Position.Long && takeProfitPrice > entryPrice) {
      takeProfitPips =
          ((takeProfitPriceParsed - entryPriceParsed) * _divider).toDouble();
    }

    if (position == Position.Short && takeProfitPrice < entryPrice) {
      takeProfitPips =
          ((entryPriceParsed - takeProfitPriceParsed) * _divider).toDouble();
    }

    return _buildTakeProfitResult(
      amount: _computeTakeProfitAmount(takeProfitPips, pipValue),
      pips: takeProfitPips,
      price: takeProfitPrice,
    );
  }

  TakeProfitResult _computeTakeProfitWithPips(
    double takeProfitPips,
    Decimal pipValue,
    double divider,
  ) {
    final takeProfitPrice = _computeTakeProfitPrice(
      takeProfitPips,
      divider,
    );

    return _buildTakeProfitResult(
      amount: _computeTakeProfitAmount(takeProfitPips, pipValue),
      pips: takeProfitPips,
      price: takeProfitPrice,
    );
  }

  double _computeTakeProfitAmount(double takeProfitPips, Decimal pipValue) {
    return (Decimal.parse(takeProfitPips.toString()) * pipValue).toDouble();
  }

  double _computeTakeProfitPrice(double takeProfitPips, double divider) {
    final position = validState.position;
    final entryPrice = validState.entryPrice;
    final _divider = Decimal.parse(divider.toString());

    final deltaPrice = Decimal.parse(takeProfitPips.toString()) / _divider;
    final entryPriceBigNumber = Decimal.parse(entryPrice.toString());

    return (position == Position.Long
            ? entryPriceBigNumber + deltaPrice
            : entryPriceBigNumber - deltaPrice)
        .toDouble();
  }

  TakeProfitResult _buildTakeProfitResult({
    double amount,
    double pips,
    double price,
  }) {
    return TakeProfitResult(
      amount: amount,
      pips: pips,
      price: price,
    );
  }
}

TakeProfitCalculator takeProfit({
  TakeProfitState initialState,
}) =>
    TakeProfitCalculator(
      initialState: initialState,
    );
