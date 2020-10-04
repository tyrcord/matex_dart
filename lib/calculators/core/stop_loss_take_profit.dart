import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexStopLossTakeProfitCalculator
    extends MatexAbstractPipValueCalculatorCore<
        MatexStopLossTakeProfitCalculator,
        Future<MatexStopLossTakeProfitResult>>
    with
        MatexLotCoreMixin<MatexStopLossTakeProfitCalculator,
            Future<MatexStopLossTakeProfitResult>>,
        MatexPipValueCoreMixin<MatexStopLossTakeProfitCalculator,
            Future<MatexStopLossTakeProfitResult>>,
        MatexPipValueMixin<MatexStopLossTakeProfitCalculator,
            Future<MatexStopLossTakeProfitResult>>,
        MatexTakeProfitCoreMixin<MatexStopLossTakeProfitCalculator,
            Future<MatexStopLossTakeProfitResult>>,
        MatexStopLossCoreMixin<MatexStopLossTakeProfitCalculator,
            Future<MatexStopLossTakeProfitResult>> {
  @override
  final MatexConfig config;

  MatexStopLossTakeProfitCalculator({
    @required this.config,
    MatexBaseCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialMatexStopLossTakeProfitState,
          validators: validators ?? matexStopLossTakeProfitValidators,
        );

  @override
  Future<MatexStopLossTakeProfitResult> value() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
    }

    return stopLossTakeProfit(initialState: state).value();
  }
}

MatexStopLossTakeProfitCalculator matexStopLossTakeProfit({
  MatexConfig config,
  MatexBaseCoreState initialState,
  List<MatexStateValidator> validators,
}) {
  return MatexStopLossTakeProfitCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
