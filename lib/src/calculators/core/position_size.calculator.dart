import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexPositionSizeCalculator extends PositionSizeCalculator
    with MatexPipValueMixin<PositionSizeState, PositionSizeResult> {
  final MatexConfig config;

  MatexPositionSizeCalculator({
    @required this.config,
    MatexPositionSizeState initialState,
    List<StateValidator> validators,
  }) : super(
          initialState: initialState ?? kInitialMatexPositionSizeState,
          validators: validators ?? matexPositionSizeValidators,
        );

  Future<PositionSizeResult> asyncValue() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      await setExchangeRates();
      return super.value();
    }

    return super.value();
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
