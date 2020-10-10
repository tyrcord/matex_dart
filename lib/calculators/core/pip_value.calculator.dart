import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPipValueCalculator extends MatexAbstractPipValueCalculatorCore<
        MatexPipValueCalculator, Future<double>>
    with
        MatexLotCoreMixin<MatexPipValueCalculator, Future<double>>,
        MatexPipValueCoreMixin<MatexPipValueCalculator, Future<double>>,
        MatexPipValueMixin<MatexPipValueCalculator, Future<double>> {
  @override
  final MatexConfig config;

  MatexPipValueCalculator({
    @required this.config,
    MatexBaseCoreState defaultState,
    List<MatexStateValidator> validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? matexPipValueValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialMatexPipValueState;

  @override
  Future<double> value() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
    }

    return pip(defaultState: state).value().toDouble();
  }
}

MatexPipValueCalculator matexPipValue({
  MatexConfig config,
  MatexBaseCoreState defaultState,
  List<MatexStateValidator> validators,
}) {
  return MatexPipValueCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
