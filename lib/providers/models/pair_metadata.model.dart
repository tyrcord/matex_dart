import 'package:equatable/equatable.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexPairMetadata extends Equatable {
  final String baseCode;
  final String counterCode;
  final MatexPairTypeMetadata type;
  final MatexInstrumentMetadata baseInstrumentMetadata;
  final MatexInstrumentMetadata counterInstrumentMetadata;

  const MatexPairMetadata({
    this.baseCode,
    this.counterCode,
    this.type,
    this.baseInstrumentMetadata,
    this.counterInstrumentMetadata,
  });

  factory MatexPairMetadata.fromJson(Map<String, dynamic> json) {
    return MatexPairMetadata(
      baseCode: json['base'] as String,
      counterCode: json['counter'] as String,
      type: MatexPairTypeMetadata.fromCache(json['type'] as String),
    );
  }

  MatexPairMetadata copyWith({
    String baseCode,
    String counterCode,
    MatexPairTypeMetadata type,
    MatexInstrumentMetadata baseInstrumentMetadata,
    MatexInstrumentMetadata counterInstrumentMetadata,
  }) {
    return MatexPairMetadata(
      baseCode: baseCode ?? this.baseCode,
      counterCode: counterCode ?? this.counterCode,
      type: type ?? this.type,
      baseInstrumentMetadata:
          baseInstrumentMetadata ?? this.baseInstrumentMetadata,
      counterInstrumentMetadata:
          counterInstrumentMetadata ?? this.counterInstrumentMetadata,
    );
  }

  @override
  List<Object> get props => [baseCode, counterCode, type];
}
