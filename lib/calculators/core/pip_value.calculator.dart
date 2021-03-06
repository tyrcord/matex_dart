import 'package:matex_dart/matex_dart.dart';

class MatexPipValueCalculator extends MatexAbstractPipValueCalculatorCore<
        MatexPipValueCalculator, Future<double>>
    with
        MatexLotCoreMixin<MatexPipValueCalculator, Future<double>>,
        MatexPipValueCoreMixin<MatexPipValueCalculator, Future<double>>,
        MatexPipValueMixin<MatexPipValueCalculator, Future<double>> {
  @override
  final MatexConfig config;

  MatexPipValueCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? matexPipValueValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialMatexPipValueState;

  @override
  Future<double> value() async {
    final exchangeProvider = config.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
    }

    return pipValue(defaultState: state).value().toDouble();
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.accountCode,
        MatexCoreStateProperty.baseCode,
        MatexCoreStateProperty.counterCode,
        MatexCoreStateProperty.positionSize,
      ];
}

MatexPipValueCalculator matexPipValue({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexPipValueCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
