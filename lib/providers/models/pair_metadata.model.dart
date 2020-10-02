import 'package:equatable/equatable.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexPairMetadata extends Equatable {
  final String baseCode;
  final String counterCode;
  final MatexPairTypeMetadata type;
  final MatexInstrumentMetadata baseInstrumentMetadata;
  final MatexInstrumentMetadata counterInstrumentMetadata;
  final MatexPairPipMetadata pip;

  const MatexPairMetadata({
    this.baseCode,
    this.counterCode,
    this.type,
    this.pip,
    this.baseInstrumentMetadata,
    this.counterInstrumentMetadata,
  });

  factory MatexPairMetadata.fromJson(Map<String, dynamic> json) {
    var pipMetadata = json['pip'] as Map<String, dynamic>;

    return MatexPairMetadata(
      baseCode: json['base'] as String,
      counterCode: json['counter'] as String,
      type: MatexPairTypeMetadata.fromCache(json['type'] as String),
      pip: pipMetadata != null
          ? MatexPairPipMetadata.fromJson(pipMetadata)
          : MatexPairPipMetadata.defaultMetatda(),
    );
  }

  MatexPairMetadata copyWith({
    String baseCode,
    String counterCode,
    MatexPairPipMetadata pip,
    MatexPairTypeMetadata type,
    MatexInstrumentMetadata baseInstrumentMetadata,
    MatexInstrumentMetadata counterInstrumentMetadata,
  }) {
    return MatexPairMetadata(
      baseCode: baseCode ?? this.baseCode,
      counterCode: counterCode ?? this.counterCode,
      type: type ?? this.type,
      pip: pip ?? this.pip,
      baseInstrumentMetadata:
          baseInstrumentMetadata ?? this.baseInstrumentMetadata,
      counterInstrumentMetadata:
          counterInstrumentMetadata ?? this.counterInstrumentMetadata,
    );
  }

  @override
  List<Object> get props => [baseCode, counterCode, type, pip];
}
