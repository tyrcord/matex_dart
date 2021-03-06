import 'package:equatable/equatable.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexPairMetadata extends Equatable {
  final MatexInstrumentMetadata? counterInstrumentMetadata;
  final MatexInstrumentMetadata? baseInstrumentMetadata;
  final MatexPairTypeMetadata type;
  final MatexPairLotsMetadata lots;
  final MatexPairPipMetadata pip;
  final String counterCode;
  final String baseCode;

  const MatexPairMetadata({
    required this.counterCode,
    required this.baseCode,
    required this.type,
    required this.lots,
    required this.pip,
    this.counterInstrumentMetadata,
    this.baseInstrumentMetadata,
  });

  factory MatexPairMetadata.fromJson(Map<String, dynamic> json) {
    var pipMetadata = json['pip'] as Map<String, dynamic>?;
    final lots = json['lots'] as Map<String, dynamic>?;

    return MatexPairMetadata(
      type: MatexPairTypeMetadata.fromCache(json['type'] as String),
      counterCode: json['counter'] as String,
      baseCode: json['base'] as String,
      lots: lots != null
          ? MatexPairLotsMetadata.fromJson(lots)
          : MatexPairLotsMetadata.defaultMetatada(),
      pip: pipMetadata != null
          ? MatexPairPipMetadata.fromJson(pipMetadata)
          : MatexPairPipMetadata.defaultMetatada(),
    );
  }

  // ignore: code-metrics
  MatexPairMetadata copyWith({
    String? baseCode,
    String? counterCode,
    MatexPairPipMetadata? pip,
    MatexPairTypeMetadata? type,
    MatexPairLotsMetadata? lots,
    MatexInstrumentMetadata? baseInstrumentMetadata,
    MatexInstrumentMetadata? counterInstrumentMetadata,
  }) {
    return MatexPairMetadata(
      baseCode: baseCode ?? this.baseCode,
      counterCode: counterCode ?? this.counterCode,
      type: type ?? this.type,
      lots: lots ?? this.lots,
      pip: pip ?? this.pip,
      baseInstrumentMetadata:
          baseInstrumentMetadata ?? this.baseInstrumentMetadata,
      counterInstrumentMetadata:
          counterInstrumentMetadata ?? this.counterInstrumentMetadata,
    );
  }

  @override
  List<Object?> get props => [
        baseCode,
        counterCode,
        type,
        pip,
        lots,
      ];
}
