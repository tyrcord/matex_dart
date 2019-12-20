import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPositionSizeCalculator extends AbstractPipValueCalculator<
        MatexPositionSizeCalculator,
        MatexPositionSizeState,
        Future<PositionSizeResult>>
    with
        LotMixin<MatexPositionSizeCalculator, MatexPositionSizeState,
            Future<PositionSizeResult>>,
        PipValueMixin<MatexPositionSizeCalculator, MatexPositionSizeState,
            Future<PositionSizeResult>>,
        MatexPipValueMixin<MatexPositionSizeCalculator, MatexPositionSizeState,
            Future<PositionSizeResult>>,
        PositionSizeMarginMixin<MatexPositionSizeCalculator,
            MatexPositionSizeState, Future<PositionSizeResult>> {
  @override
  final MatexConfig config;

  MatexPositionSizeCalculator({
    @required this.config,
    MatexPositionSizeState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialMatexPositionSizeState,
          validators: validators ?? matexPositionSizeValidators,
        );

  @override
  Future<PositionSizeResult> value() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
    }

    return positionSize(initialState: state).value();
  }
}

MatexPositionSizeCalculator matexPositionSize({
  MatexConfig config,
  MatexPositionSizeState initialState,
  List<StateValidator> validators,
}) {
  return MatexPositionSizeCalculator(
    config: config,
    initialState: initialState,
    validators: validators,
  );
}
