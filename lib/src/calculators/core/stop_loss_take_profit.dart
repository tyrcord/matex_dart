import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexStopLossTakeProfitCalculator extends StopLossTakeProfitCalculator
    with MatexPipValueMixin {
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

  Future<StopLossTakeProfitResult> asyncValue() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
      return super.value();
    }

    return super.value();
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
