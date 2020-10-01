import 'package:meta/meta.dart';

import 'package:matex_dart/matex_dart.dart' hide positionSize;
import 'package:tstore_dart/tstore_dart.dart';

class MatexPipValueState extends PipValueState implements Model {
  @override
  final String accountCode;
  @override
  final String baseCode;
  @override
  final String counterCode;

  const MatexPipValueState({
    double baseExchangeRate,
    double tradingPairExchangeRate,
    double positionSize,
    int pipPrecision,
    LotDescriptors lotDescriptors,
    bool baseListedSecond,
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
        );

  @override
  MatexPipValueState copyWithState(BaseState state) {
    return MatexPipValueState(
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
    );
  }

  @override
  MatexPipValueState clone() {
    return MatexPipValueState(
      accountCode: accountCode,
      baseCode: baseCode,
      counterCode: counterCode,
      baseExchangeRate: baseExchangeRate,
      tradingPairExchangeRate: tradingPairExchangeRate,
      positionSize: positionSize,
      pipPrecision: pipPrecision,
      lotDescriptors: lotDescriptors,
      baseListedSecond: baseListedSecond,
    );
  }

  @override
  MatexPipValueState copyWith({
    double baseExchangeRate,
    double tradingPairExchangeRate,
    double positionSize,
    int pipPrecision,
    LotDescriptors lotDescriptors,
    bool baseListedSecond,
    String accountCode,
    String baseCode,
    String counterCode,
  }) {
    return copyWithState(
      MatexPipValueState(
        accountCode: accountCode,
        baseCode: baseCode,
        counterCode: counterCode,
        baseExchangeRate: baseExchangeRate,
        tradingPairExchangeRate: tradingPairExchangeRate,
        positionSize: positionSize,
        pipPrecision: pipPrecision,
        lotDescriptors: lotDescriptors,
        baseListedSecond: baseListedSecond,
      ),
    );
  }

  @override
  MatexPipValueState merge({@required MatexPipValueState state}) {
    return copyWithState(state);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accountCode': accountCode,
      'baseCode': baseCode,
      'counterCode': counterCode,
      'baseExchangeRate': baseExchangeRate,
      'tradingPairExchangeRate': tradingPairExchangeRate,
      'positionSize': positionSize,
      'lotDescriptors': lotDescriptors.toJson(),
      'baseListedSecond': baseListedSecond,
    };
  }

  factory MatexPipValueState.fromJson(dynamic json) {
    return MatexPipValueState(
      accountCode: json['accountCode'] as String,
      baseCode: json['baseCode'] as String,
      counterCode: json['counterCode'] as String,
      baseExchangeRate: json['baseExchangeRate'] as double,
      tradingPairExchangeRate: json['tradingPairExchangeRate'] as double,
      positionSize: json['positionSize'] as double,
      pipPrecision: json['pipPrecision'] as int,
      lotDescriptors: json['lotDescriptors'] as LotDescriptors,
      baseListedSecond: json['baseListedSecond'] as bool,
    );
  }
}

const MatexPipValueState kInitialMatexPipValueState = MatexPipValueState(
  accountCode: null,
  baseCode: null,
  counterCode: null,
  baseExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 0.0,
  tradingPairExchangeRate: 0.0,
);
