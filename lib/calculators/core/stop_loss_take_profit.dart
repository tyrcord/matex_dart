// ignore_for_file: overridden_fields

import 'package:matex_dart/matex_dart.dart';

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
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? matexStopLossTakeProfitValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kInitialMatexStopLossTakeProfitState;

  @override
  Future<MatexStopLossTakeProfitResult> value() async {
    final exchangeProvider = config.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
    }

    return stopLossTakeProfit(defaultState: state).value();
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.accountCode,
        MatexCoreStateProperty.baseCode,
        MatexCoreStateProperty.counterCode,
        MatexCoreStateProperty.entryPrice,
        MatexCoreStateProperty.positionSize,
        MatexCoreStateProperty.stopLossAmount,
        MatexCoreStateProperty.stopLossPips,
        MatexCoreStateProperty.stopLossPrice,
        MatexCoreStateProperty.takeProfitAmount,
        MatexCoreStateProperty.takeProfitPips,
        MatexCoreStateProperty.takeProfitPrice,
        MatexCoreStateProperty.position,
      ];
}

MatexStopLossTakeProfitCalculator matexStopLossTakeProfit({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexStopLossTakeProfitCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
