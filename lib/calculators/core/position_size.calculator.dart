import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPositionSizeCalculator extends MatexAbstractPipValueCalculatorCore<
        MatexPositionSizeCalculator,
        MatexPositionSizeCoreState,
        Future<MatexPositionSizeResult>>
    with
        MatexLotCoreMixin<MatexPositionSizeCalculator,
            MatexPositionSizeCoreState, Future<MatexPositionSizeResult>>,
        MatexPipValueCoreMixin<MatexPositionSizeCalculator,
            MatexPositionSizeCoreState, Future<MatexPositionSizeResult>>,
        MatexPipValueMixin<MatexPositionSizeCalculator,
            MatexPositionSizeCoreState, Future<MatexPositionSizeResult>>,
        MatexPositionSizeMarginCoreMixin<MatexPositionSizeCalculator,
            MatexPositionSizeCoreState, Future<MatexPositionSizeResult>> {
  @override
  final MatexConfig config;

  MatexPositionSizeCalculator({
    @required this.config,
    MatexPositionSizeCoreState initialState,
    List<MatexStateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialMatexPositionSizeState,
          validators: validators ?? matexPositionSizeValidators,
        );

  @override
  Future<MatexPositionSizeResult> value() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
    }

    return positionSize(initialState: state).value();
  }
}

MatexPositionSizeCalculator matexPositionSize({
  MatexConfig config,
  MatexPositionSizeCoreState initialState,
  List<MatexStateValidator> validators,
}) {
  return MatexPositionSizeCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
