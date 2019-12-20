import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPipValueCalculator extends AbstractPipValueCalculator<
        MatexPipValueCalculator, MatexPipValueState, Future<double>>
    with
        LotMixin<MatexPipValueCalculator, MatexPipValueState, Future<double>>,
        PipValueMixin<MatexPipValueCalculator, MatexPipValueState,
            Future<double>>,
        MatexPipValueMixin<MatexPipValueCalculator, MatexPipValueState,
            Future<double>> {
  @override
  final MatexConfig config;

  MatexPipValueCalculator({
    @required this.config,
    MatexPipValueState initialState,
    List<StateValidator> validators,
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
  List<StateValidator> validators,
}) {
  return MatexPipValueCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
