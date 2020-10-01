import 'package:equatable/equatable.dart';
import 'package:matex_dart/matex_dart.dart';

class PairMetadata extends Equatable {
  final String baseCode;
  final String counterCode;
  final PairTypeMetadata type;
  final InstrumentMetadata baseInstrumentMetadata;
  final InstrumentMetadata counterInstrumentMetadata;

  const PairMetadata({
    this.baseCode,
    this.counterCode,
    this.type,
    this.baseInstrumentMetadata,
    this.counterInstrumentMetadata,
  });

  factory PairMetadata.fromJson(Map<String, dynamic> json) {
    return PairMetadata(
      baseCode: json['base'] as String,
      counterCode: json['counter'] as String,
      type: PairTypeMetadata.fromCache(json['type'] as String),
    );
  }

  PairMetadata copyWith({
    String baseCode,
    String counterCode,
    PairTypeMetadata type,
    InstrumentMetadata baseInstrumentMetadata,
    InstrumentMetadata counterInstrumentMetadata,
  }) {
    return PairMetadata(
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
