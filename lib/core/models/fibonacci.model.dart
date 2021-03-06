import 'package:equatable/equatable.dart';

class MatexFibonacciLevel extends Equatable {
  final String level;
  final double value;

  const MatexFibonacciLevel({
    required this.level,
    required this.value,
  });

  @override
  List<Object> get props => [level, value];
}

class FibonacciLevelsResult extends Equatable {
  final List<MatexFibonacciLevel> retracementLevels;
  final List<MatexFibonacciLevel> extensionLevels;

  const FibonacciLevelsResult({
    required this.retracementLevels,
    required this.extensionLevels,
  });

  @override
  List<Object> get props => [retracementLevels, extensionLevels];
}
