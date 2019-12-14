import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPipValueCalculator extends PipValueCalculator
    with MatexPipValueMixin {
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

  Future<double> asyncValue() async {
    final exchangeProvider = config?.exchangeProvider;

    // TODO: instrument metadata precision.

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
      return super.value();
    }

    return 0.0;
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
