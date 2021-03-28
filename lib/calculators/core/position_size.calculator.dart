import 'package:matex_dart/matex_dart.dart';

class MatexPositionSizeCalculator extends MatexAbstractPipValueCalculatorCore<
        MatexPositionSizeCalculator, Future<MatexPositionSizeResult>>
    with
        MatexLotCoreMixin<MatexPositionSizeCalculator,
            Future<MatexPositionSizeResult>>,
        MatexPipValueCoreMixin<MatexPositionSizeCalculator,
            Future<MatexPositionSizeResult>>,
        MatexPipValueMixin<MatexPositionSizeCalculator,
            Future<MatexPositionSizeResult>>,
        MatexPositionSizeMarginCoreMixin<MatexPositionSizeCalculator,
            Future<MatexPositionSizeResult>> {
  @override
  final MatexConfig config;

  MatexPositionSizeCalculator({
    required this.config,
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          validators: validators ?? matexPositionSizeValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kInitialMatexPositionSizeState;

  @override
  Future<MatexPositionSizeResult> value() async {
    final exchangeProvider = config.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
    }

    return positionSize(defaultState: state).value();
  }
}

MatexPositionSizeCalculator matexPositionSize({
  required MatexConfig config,
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) {
  return MatexPositionSizeCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
