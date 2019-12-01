import 'package:equatable/equatable.dart';
import 'package:matex_dart/src/core/models/models.dart';
import 'package:matex_dart/src/core/states/states.dart';
import 'package:matex_dart/src/core/enums/enums.dart';
import 'package:matex_dart/src/core/descriptors/descriptors.dart';

class TakeProfitState extends BaseState with EquatableMixin {
  TakeProfitState({
    double baseExchangeRate,
    double tradingPairExchangeRate,
    double positionSize,
    int pipPrecision,
    LotDescriptors lotDescriptors,
    bool baseListedSecond,
    double takeProfitPips,
    double takeProfitPrice,
    double takeProfitAmount,
    double entryPrice,
    Position position,
  }) : super(
          baseExchangeRate: baseExchangeRate,
          tradingPairExchangeRate: tradingPairExchangeRate,
          positionSize: positionSize,
          pipPrecision: pipPrecision,
          lotDescriptors: lotDescriptors,
          baseListedSecond: baseListedSecond,
          takeProfitPips: takeProfitPips,
          takeProfitPrice: takeProfitPrice,
          takeProfitAmount: takeProfitAmount,
          entryPrice: entryPrice,
          position: position,
        );

  @override
  List<Object> get props => [
        baseExchangeRate,
        tradingPairExchangeRate,
        positionSize,
        pipPrecision,
        lotDescriptors,
        baseListedSecond,
        takeProfitPips,
        takeProfitPrice,
        takeProfitAmount,
        entryPrice,
        position,
      ];

  TakeProfitState copyWithState(BaseState state) {
    return TakeProfitState(
      baseExchangeRate: state.baseExchangeRate ?? baseExchangeRate,
      tradingPairExchangeRate:
          state.tradingPairExchangeRate ?? tradingPairExchangeRate,
      positionSize: state.positionSize ?? positionSize,
      pipPrecision: state.pipPrecision ?? pipPrecision,
      lotDescriptors: state.lotDescriptors ?? lotDescriptors,
      baseListedSecond: state.baseListedSecond ?? baseListedSecond,
      entryPrice: state.entryPrice ?? entryPrice,
      position: state.position ?? position,
      takeProfitPips: state.takeProfitPips ?? takeProfitPips,
      takeProfitPrice: state.takeProfitPrice ?? takeProfitPrice,
      takeProfitAmount: state.takeProfitAmount ?? takeProfitAmount,
    );
  }

  TakeProfitState clone() {
    return TakeProfitState(
      baseExchangeRate: baseExchangeRate,
      tradingPairExchangeRate: tradingPairExchangeRate,
      positionSize: positionSize,
      pipPrecision: pipPrecision,
      lotDescriptors: lotDescriptors,
      baseListedSecond: baseListedSecond,
      takeProfitPips: takeProfitPips,
      takeProfitPrice: takeProfitPrice,
      takeProfitAmount: takeProfitAmount,
      entryPrice: entryPrice,
      position: position,
    );
  }
}

final initialTakeProfitState = TakeProfitState(
  baseExchangeRate: 0.0,
  baseListedSecond: false,
  lotDescriptors: kDefaultLotDescriptors,
  pipPrecision: 4,
  positionSize: 0.0,
  tradingPairExchangeRate: 0.0,
  entryPrice: 0.0,
  position: Position.Long,
  takeProfitAmount: 0.0,
  takeProfitPips: 0.0,
  takeProfitPrice: 0.0,
);
