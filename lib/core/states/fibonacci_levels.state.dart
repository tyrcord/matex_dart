import 'package:matex_dart/matex_dart.dart';

class MatexFibonacciLevelsCoreState extends MatexBaseCoreState {
  const MatexFibonacciLevelsCoreState({
    double customPrice,
    double highPrice,
    double lowPrice,
    int precision,
    MatexTrend trend,
    List<double> extensionLevels,
    List<double> retracementLevels,
  }) : super(
          customPrice: customPrice,
          highPrice: highPrice,
          lowPrice: lowPrice,
          precision: precision,
          trend: trend,
          extensionLevels: extensionLevels,
          retracementLevels: retracementLevels,
        );

  @override
  MatexFibonacciLevelsCoreState copyWithState(MatexBaseCoreState state) {
    return MatexFibonacciLevelsCoreState(
      customPrice: state.customPrice ?? customPrice,
      highPrice: state.highPrice ?? highPrice,
      lowPrice: state.lowPrice ?? lowPrice,
      precision: state.precision ?? precision,
      trend: state.trend ?? trend,
      extensionLevels: state.extensionLevels ?? extensionLevels,
      retracementLevels: state.retracementLevels ?? retracementLevels,
    );
  }

  @override
  MatexFibonacciLevelsCoreState clone() {
    return MatexFibonacciLevelsCoreState(
      customPrice: customPrice,
      highPrice: highPrice,
      lowPrice: lowPrice,
      precision: precision,
      trend: trend,
      extensionLevels: extensionLevels,
      retracementLevels: retracementLevels,
    );
  }
}

const kInitialFibonacciLevelsState = MatexFibonacciLevelsCoreState(
  customPrice: 0.0,
  highPrice: 0.0,
  lowPrice: 0.0,
  precision: 5,
  trend: MatexTrend.Up,
  extensionLevels: kMatexFibonacciExtensionLevels,
  retracementLevels: kMatexFibonacciRetracementLevels,
);
