import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexStopLossTakeProfitCalculator extends AbstractPipValueCalculator<
        MatexStopLossTakeProfitCalculator,
        MatexStopLossTakeProfitState,
        Future<StopLossTakeProfitResult>>
    with
        LotMixin<MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState, Future<StopLossTakeProfitResult>>,
        PipValueMixin<MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState, Future<StopLossTakeProfitResult>>,
        MatexPipValueMixin<MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState, Future<StopLossTakeProfitResult>>,
        TakeProfitMixin<MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState, Future<StopLossTakeProfitResult>>,
        StopLossMixin<MatexStopLossTakeProfitCalculator,
            MatexStopLossTakeProfitState, Future<StopLossTakeProfitResult>> {
  @override
  final MatexConfig config;

  MatexStopLossTakeProfitCalculator({
    @required this.config,
    MatexStopLossTakeProfitState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialMatexStopLossTakeProfitState,
          validators: validators ?? matexStopLossTakeProfitValidators,
        );

  @override
  Future<StopLossTakeProfitResult> value() async {
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
  List<StateValidator> validators,
}) {
  return MatexStopLossTakeProfitCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
