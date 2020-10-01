import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexStopLossTakeProfitCalculator
    extends MatexAbstractPipValueCalculatorCore<
        MatexStopLossTakeProfitCalculator,
        MatexStopLossTakeProfitState,
        Future<MatexStopLossTakeProfitResult>>
    with
        MatexLotCoreMixin<
            MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState,
            Future<MatexStopLossTakeProfitResult>>,
        MatexPipValueCoreMixin<
            MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState,
            Future<MatexStopLossTakeProfitResult>>,
        MatexPipValueMixin<
            MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState,
            Future<MatexStopLossTakeProfitResult>>,
        MatexTakeProfitCoreMixin<
            MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState,
            Future<MatexStopLossTakeProfitResult>>,
        MatexStopLossCoreMixin<
            MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState,
            Future<MatexStopLossTakeProfitResult>> {
  @override
  final MatexConfig config;

  MatexStopLossTakeProfitCalculator({
    @required this.config,
    MatexStopLossTakeProfitState initialState,
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
  MatexStopLossTakeProfitState initialState,
  List<MatexStateValidator> validators,
}) {
  return MatexStopLossTakeProfitCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
