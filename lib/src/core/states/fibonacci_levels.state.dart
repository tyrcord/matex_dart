import 'package:matex_dart/matex_dart.dart';

class FibonacciLevelsState extends BaseState {
  const FibonacciLevelsState({
    double customPrice,
    double highPrice,
    double lowPrice,
    int precision,
    Trend trend,
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
  FibonacciLevelsState copyWithState(BaseState state) {
    return FibonacciLevelsState(
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
  FibonacciLevelsState clone() {
    return FibonacciLevelsState(
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

const kInitialFibonacciLevelsState = FibonacciLevelsState(
  customPrice: 0.0,
  highPrice: 0.0,
  lowPrice: 0.0,
  precision: 5,
  trend: Trend.Up,
  extensionLevels: kFibonacciExtensionLevels,
  retracementLevels: kFibonacciRetracementLevels,
);
