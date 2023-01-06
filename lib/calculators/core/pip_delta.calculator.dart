import 'package:matex_dart/matex_dart.dart';

class MatexPipDeltaCalculator
    extends MatexBaseCalculator<MatexPipDeltaCalculator, Future<double>>
    with MatexPipDeltaCoreMixin<MatexPipDeltaCalculator, Future<double>> {
  final MatexConfig config;

  MatexPipDeltaCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? matexPipDeltaValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState => kInitialMatexPipDeltaState;

  MatexPipDeltaCalculator currencyPairCode(
    String? baseCode,
    String? counterCode,
  ) {
    if (baseCode != null && counterCode != null) {
      return patchState(MatexBaseCoreState(
        pipPrecision: intMaxValue,
        counterCode: counterCode,
        baseCode: baseCode,
      ));
    }

    return resetStateProperties([
      MatexCoreStateProperty.counterCode,
      MatexCoreStateProperty.baseCode,
    ]);
  }

  @override
  Future<double> value() async {
    final pairProvider = config.pairProvider;

    if (isValid && pairProvider != null) {
      final pipPrecision = state.pipPrecision;

      // FIXME: workaround,
      // we can't properly set null values on the calculator state.
      if (pipPrecision == null || pipPrecision == intMaxValue) {
        var pairMetadata = await pairProvider.metadata(
          '${state.baseCode}${state.counterCode}',
        );

        if (pairMetadata != null) {
          patchState(
            MatexBaseCoreState(pipPrecision: pairMetadata.pip.precision),
          );
        } else {
          patchState(MatexBaseCoreState(
            pipPrecision: MatexPairPipMetadata.defaultMetatada().precision,
          ));
        }
      }

      return pipDelta(defaultState: state).value().toDouble();
    }

    return 0;
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.baseCode,
        MatexCoreStateProperty.counterCode,
        MatexCoreStateProperty.priceA,
        MatexCoreStateProperty.priceB,
      ];
}

MatexPipDeltaCalculator matexPipDelta({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexPipDeltaCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
