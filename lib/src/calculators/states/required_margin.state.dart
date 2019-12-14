import 'package:matex_dart/matex_dart.dart' hide positionSize;

class MatexRequiredMarginState extends RequiredMarginState {
  @override
  final String accountCode;
  @override
  final String baseCode;
  @override
  final String counterCode;

  const MatexRequiredMarginState({
    double baseExchangeRate,
    double tradingPairExchangeRate,
    double positionSize,
    int pipPrecision,
    LotDescriptors lotDescriptors,
    bool baseListedSecond,
    double leverage,
    this.accountCode,
    this.baseCode,
    this.counterCode,
  }) : super(
          baseExchangeRate: baseExchangeRate,
          tradingPairExchangeRate: tradingPairExchangeRate,
          positionSize: positionSize,
          pipPrecision: pipPrecision,
          lotDescriptors: lotDescriptors,
          baseListedSecond: baseListedSecond,
          leverage: leverage,
        );

  @override
  MatexRequiredMarginState copyWithState(BaseState state) {
    return MatexRequiredMarginState(
      accountCode: state.accountCode ?? accountCode,
      baseCode: state.baseCode ?? baseCode,
      counterCode: state.counterCode ?? counterCode,
      baseExchangeRate: state.baseExchangeRate ?? baseExchangeRate,
      tradingPairExchangeRate:
          state.tradingPairExchangeRate ?? tradingPairExchangeRate,
      positionSize: state.positionSize ?? positionSize,
      pipPrecision: state.pipPrecision ?? pipPrecision,
      lotDescriptors: state.lotDescriptors ?? lotDescriptors,
      baseListedSecond: state.baseListedSecond ?? baseListedSecond,
      leverage: state.leverage ?? leverage,
    );
  }

  @override
  MatexRequiredMarginState clone() {
    return MatexRequiredMarginState(
      accountCode: accountCode,
      baseCode: baseCode,
      counterCode: counterCode,
      baseExchangeRate: baseExchangeRate,
      tradingPairExchangeRate: tradingPairExchangeRate,
      positionSize: positionSize,
      pipPrecision: pipPrecision,
      lotDescriptors: lotDescriptors,
      baseListedSecond: baseListedSecond,
      leverage: leverage,
    );
  }
}

const MatexRequiredMarginState kInitialMatexRequiredMarginState =
    MatexRequiredMarginState(
  accountCode: null,
  baseCode: null,
  counterCode: null,
  baseExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 0.0,
  tradingPairExchangeRate: 0.0,
  leverage: 1.0,
);
