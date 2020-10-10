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
    MatexBaseCoreState defaultState,
    List<MatexStateValidator> validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? matexStopLossTakeProfitValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kInitialMatexStopLossTakeProfitState;

  @override
  Future<MatexStopLossTakeProfitResult> value() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
    }

    return stopLossTakeProfit(defaultState: state).value();
  }
}

MatexStopLossTakeProfitCalculator matexStopLossTakeProfit({
  MatexConfig config,
  MatexBaseCoreState defaultState,
  List<MatexStateValidator> validators,
}) {
  return MatexStopLossTakeProfitCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
