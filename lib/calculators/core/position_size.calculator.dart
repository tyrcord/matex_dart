import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

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
    @required this.config,
    MatexBaseCoreState initialState,
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
  MatexBaseCoreState initialState,
  List<MatexStateValidator> validators,
}) {
  return MatexPositionSizeCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
