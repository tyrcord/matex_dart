import 'package:equatable/equatable.dart';
import 'package:matex_dart/matex_dart.dart';

const kFibonacciLevelsPrecision = 5;

const List<double> kFibonacciExtensionLevels = [
  23.6,
  38.2,
  50,
  61.8,
  100,
  138.2,
  161.8,
  200,
  261.8,
];

const List<double> kFibonacciRetracementLevels = [
  23.6,
  38.2,
  50,
  61.8,
  78.6,
];

class FibonacciLevelsState extends BaseState with EquatableMixin {
  FibonacciLevelsState({
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
  List<Object> get props => [
        customPrice,
        highPrice,
        lowPrice,
        precision,
        trend,
        extensionLevels,
        retracementLevels,
      ];

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

final initialFibonacciLevelsState = FibonacciLevelsState(
  customPrice: 0,
  highPrice: 0,
  lowPrice: 0,
  precision: kFibonacciLevelsPrecision,
  trend: Trend.Up,
  extensionLevels: kFibonacciExtensionLevels,
  retracementLevels: kFibonacciRetracementLevels,
);
