import 'package:equatable/equatable.dart';

class FibonacciLevel extends Equatable {
  final String level;
  final double value;

  const FibonacciLevel({
    this.level,
    this.value,
  });

  @override
  List<Object> get props => [
        level,
        value,
      ];
}

class FibonacciLevelsResult extends Equatable {
  final List<FibonacciLevel> retracementLevels;
  final List<FibonacciLevel> extensionLevels;

  const FibonacciLevelsResult({
    this.retracementLevels,
    this.extensionLevels,
  });

  @override
  List<Object> get props => [
        retracementLevels,
        extensionLevels,
      ];
}
