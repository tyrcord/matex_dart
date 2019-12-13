import 'package:matex_dart/matex_dart.dart';

class PivotPointsState extends BaseState {
  const PivotPointsState({
    double closePrice,
    double highPrice,
    double lowPrice,
    double openPrice,
    PivotPointsMethods method,
  }) : super(
          closePrice: closePrice,
          highPrice: highPrice,
          lowPrice: lowPrice,
          openPrice: openPrice,
          method: method,
        );

  @override
  PivotPointsState copyWithState(BaseState state) {
    return PivotPointsState(
      closePrice: state.closePrice ?? closePrice,
      highPrice: state.highPrice ?? highPrice,
      lowPrice: state.lowPrice ?? lowPrice,
      openPrice: state.openPrice ?? openPrice,
      method: state.method ?? method,
    );
  }

  @override
  PivotPointsState clone() {
    return PivotPointsState(
      closePrice: closePrice,
      highPrice: highPrice,
      lowPrice: lowPrice,
      openPrice: openPrice,
      method: method,
    );
  }
}

const kInitialPivotPointsState = PivotPointsState(
  closePrice: 0,
  highPrice: 0,
  lowPrice: 0,
  method: PivotPointsMethods.Standard,
  openPrice: 0,
);
