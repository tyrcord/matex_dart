import 'package:equatable/equatable.dart';

class MatexInstrumentPipMetadata extends Equatable {
  final int precision;
  final int pipette;
  final int round;

  const MatexInstrumentPipMetadata({
    this.precision,
    this.pipette,
    this.round,
  });

  static MatexInstrumentPipMetadata fromJson(Map<String, dynamic> json) {
    return MatexInstrumentPipMetadata(
      precision: json['precision'] as int,
      pipette: json['pipette'] as int,
      round: json['round'] as int,
    );
  }

  @override
  List<Object> get props => [precision, pipette, round];
}
