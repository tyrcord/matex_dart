import 'package:matex_dart/matex_dart.dart';

class MatexPivotPointsCoreState extends MatexBaseCoreState {
  const MatexPivotPointsCoreState({
    double closePrice,
    double highPrice,
    double lowPrice,
    double openPrice,
    MatexPivotPointsMethods method,
  }) : super(
          closePrice: closePrice,
          highPrice: highPrice,
          lowPrice: lowPrice,
          openPrice: openPrice,
          method: method,
        );

  @override
  MatexPivotPointsCoreState copyWithState(MatexBaseCoreState state) {
    return MatexPivotPointsCoreState(
      closePrice: state.closePrice ?? closePrice,
      highPrice: state.highPrice ?? highPrice,
      lowPrice: state.lowPrice ?? lowPrice,
      openPrice: state.openPrice ?? openPrice,
      method: state.method ?? method,
    );
  }

  @override
  MatexPivotPointsCoreState clone() {
    return MatexPivotPointsCoreState(
      closePrice: closePrice,
      highPrice: highPrice,
      lowPrice: lowPrice,
      openPrice: openPrice,
      method: method,
    );
  }
}

const kInitialPivotPointsState = MatexPivotPointsCoreState(
  closePrice: 0,
  highPrice: 0,
  lowPrice: 0,
  method: MatexPivotPointsMethods.Standard,
  openPrice: 0,
);
