import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPipValueCalculator extends MatexAbstractPipValueCalculatorCore<
        MatexPipValueCalculator, MatexPipValueState, Future<double>>
    with
        MatexLotCoreMixin<MatexPipValueCalculator, MatexPipValueState,
            Future<double>>,
        MatexPipValueCoreMixin<MatexPipValueCalculator, MatexPipValueState,
            Future<double>>,
        MatexPipValueMixin<MatexPipValueCalculator, MatexPipValueState,
            Future<double>> {
  @override
  final MatexConfig config;

  MatexPipValueCalculator({
    @required this.config,
    MatexPipValueState initialState,
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
  MatexPipValueState initialState,
  List<MatexStateValidator> validators,
}) {
  return MatexPipValueCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
