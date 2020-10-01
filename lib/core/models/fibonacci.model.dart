import 'package:equatable/equatable.dart';

class MatexFibonacciLevel extends Equatable {
  final String level;
  final double value;

  const MatexFibonacciLevel({
    this.level,
    this.value,
  });

  @override
  List<Object> get props => [level, value];
}

class FibonacciLevelsResult extends Equatable {
  final List<MatexFibonacciLevel> retracementLevels;
  final List<MatexFibonacciLevel> extensionLevels;

  const FibonacciLevelsResult({
    this.retracementLevels,
    this.extensionLevels,
  });

  @override
  List<Object> get props => [retracementLevels, extensionLevels];
}
