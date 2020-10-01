import 'package:equatable/equatable.dart';

class InstrumentPipMetadata extends Equatable {
  final int precision;
  final int pipette;
  final int round;

  const InstrumentPipMetadata({
    this.precision,
    this.pipette,
    this.round,
  });

  static InstrumentPipMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentPipMetadata(
      precision: json['precision'] as int,
      pipette: json['pipette'] as int,
      round: json['round'] as int,
    );
  }

  @override
  List<Object> get props => [precision, pipette, round];
}
