import 'package:equatable/equatable.dart';

import 'package:matex_dart/matex_dart.dart';

class MatexInstrumentMetadata extends Equatable {
  final MatexInstrumentFormatMetadata? format;
  final MatexInstrumentSymbolMetadata? symbol;
  final MatexInstrumentNameMetadata? name;
  final MatexInstrumentTypeMetadata type;
  final String? icon;
  final String? code;

  const MatexInstrumentMetadata({
    required this.type,
    this.format,
    this.symbol,
    this.code,
    this.icon,
    this.name,
  });

  factory MatexInstrumentMetadata.fromJson(Map<String, dynamic> json) {
    return MatexInstrumentMetadata(
      code: json['code'] as String?,
      icon: json['icon'] as String?,
      format: MatexInstrumentFormatMetadata.fromJson(
        json['format'] as Map<String, dynamic>,
      ),
      name: MatexInstrumentNameMetadata.fromJson(
        json['name'] as Map<String, dynamic>,
      ),
      symbol: MatexInstrumentSymbolMetadata.fromJson(
        json['symbol'] as Map<String, dynamic>,
      ),
      type: MatexInstrumentTypeMetadata.fromCache(json['type'] as String),
    );
  }

  @override
  List<Object?> get props => [
        code,
        icon,
        format,
        name,
        symbol,
        type,
      ];
}
