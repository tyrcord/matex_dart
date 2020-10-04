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
    MatexBaseCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialMatexPipValueState,
          validators: validators ?? matexPipValueValidators,
        );

  @override
  Future<double> value() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
    }

    return pip(initialState: state).value().toDouble();
  }
}

MatexPipValueCalculator matexPipValue({
  MatexConfig config,
  MatexBaseCoreState initialState,
  List<MatexStateValidator> validators,
}) {
  return MatexPipValueCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
