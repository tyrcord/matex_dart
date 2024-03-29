// ignore_for_file: overridden_fields

import 'package:matex_dart/matex_dart.dart';

class MatexRequiredMarginCalculator extends MatexAbstractPipValueCalculatorCore<
        MatexRequiredMarginCalculator, Future<double>>
    with
        MatexLotCoreMixin<MatexRequiredMarginCalculator, Future<double>>,
        MatexPipValueCoreMixin<MatexRequiredMarginCalculator, Future<double>>,
        MatexPipValueMixin<MatexRequiredMarginCalculator, Future<double>>,
        MatexRequiredMarginCoreMixin<MatexRequiredMarginCalculator,
            Future<double>> {
  @override
  final MatexConfig config;

  MatexRequiredMarginCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? matexPipValueValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kInitialMatexRequiredMarginState;

  @override
  Future<double> value() async {
    final exchangeProvider = config.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      if (state.accountCode == state.baseCode) {
        tradingPairExchangeRate(1.0);
      } else {
        await setExchangeRates();
      }

      return requiredMargin(defaultState: state).value();
    }

    return 0.0;
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.accountCode,
        MatexCoreStateProperty.baseCode,
        MatexCoreStateProperty.counterCode,
        MatexCoreStateProperty.positionSize,
        MatexCoreStateProperty.leverage,
      ];
}

MatexRequiredMarginCalculator matexRequiredMargin({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexRequiredMarginCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
