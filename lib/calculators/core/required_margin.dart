import 'package:matex_dart/matex_dart.dart';
import 'package:meta/meta.dart';

class MatexRequiredMarginCalculator extends MatexAbstractPipValueCalculatorCore<
        MatexRequiredMarginCalculator, Future<double>>
    with
        MatexLotCoreMixin<MatexRequiredMarginCalculator, Future<double>>,
        MatexPipValueCoreMixin<MatexRequiredMarginCalculator, Future<double>>,
        MatexPipValueMixin<MatexRequiredMarginCalculator, Future<double>>,
        MatexRequiredMarginCoreMixin<MatexRequiredMarginCalculator,
            Future<double>> {
  @override
  final MatexConfig config;

  MatexRequiredMarginCalculator({
    @required this.config,
    MatexBaseCoreState defaultState,
    List<MatexStateValidator> validators,
  })  : assert(config != null),
        super(
          validators: validators ?? matexPipValueValidators,
          defaultState: defaultState,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kInitialMatexRequiredMarginState;

  @override
  Future<double> value() async {
    final exchangeProvider = config?.exchangeProvider;

    if (isValid && exchangeProvider != null) {
      // TODO: Workaround before using counterAccountPairExchangeRate
      var skipAccountBaseQuote = state.accountCode == state.baseCode;

      await setExchangeRates(
        skipAccountBaseQuote: state.accountCode == state.baseCode,
      );

      if (skipAccountBaseQuote) {
        tradingPairExchangeRate(1.0);
      }

      return requiredMargin(defaultState: state).value();
    }

    return 0.0;
  }
}

MatexRequiredMarginCalculator matexRequiredMargin({
  @required MatexConfig config,
  MatexBaseCoreState defaultState,
  List<MatexStateValidator> validators,
}) {
  assert(config != null);

  return MatexRequiredMarginCalculator(
    config: config,
    defaultState: defaultState,
    validators: validators,
  );
}
