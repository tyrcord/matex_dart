import 'package:equatable/equatable.dart';

const _kDefault = MatexPairPipMetadata(
  pipette: 5,
  precision: 4,
  round: 5,
);

class MatexPairPipMetadata extends Equatable {
  final int precision;
  final int pipette;
  final int round;

  const MatexPairPipMetadata({
    this.precision,
    this.pipette,
    this.round,
  });

  factory MatexPairPipMetadata.fromJson(Map<String, dynamic> json) {
    return MatexPairPipMetadata(
      precision: json['precision'] as int,
      pipette: json['pipette'] as int,
      round: json['round'] as int,
    );
  }

  factory MatexPairPipMetadata.defaultMetatda() => _kDefault;

  @override
  List<Object> get props => [precision, pipette, round];
}
