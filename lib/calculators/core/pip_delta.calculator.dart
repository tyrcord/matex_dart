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
        counterCode: counterCode,
        baseCode: baseCode,
      ));
    }

    return resetStateProperties([
      MatexCoreStateProperty.pipPrecision,
      MatexCoreStateProperty.counterCode,
      MatexCoreStateProperty.baseCode,
    ]);
  }

  @override
  Future<double> value() async {
    final pairProvider = config.pairProvider;

    if (isValid && pairProvider != null) {
      var metadata = await pairProvider.metadata(
        '${state.baseCode}${state.counterCode}',
      );

      if (metadata != null) {
        pipPrecision(metadata.pip.precision);
      }

      return pipDelta(defaultState: state).value().toDouble();
    }

    return 0;
  }

  @override
  Iterable<String> get propertiesUseForDifference => [
        MatexCoreStateProperty.pipPrecision,
        MatexCoreStateProperty.counterCode,
        MatexCoreStateProperty.baseCode,
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
