import 'package:equatable/equatable.dart';

import 'package:matex_dart/matex_dart.dart';

class MatexInstrumentMetadata extends Equatable {
  final String code;
  final String icon;
  final MatexInstrumentFormatMetadata format;
  final MatexInstrumentLotsMetadata lots;
  final MatexInstrumentNameMetadata name;
  final MatexInstrumentSymbolMetadata symbol;
  final MatexInstrumentTypeMetadata type;

  const MatexInstrumentMetadata({
    this.code,
    this.icon,
    this.format,
    this.lots,
    this.name,
    this.symbol,
    this.type,
  });

  factory MatexInstrumentMetadata.fromJson(Map<String, dynamic> json) {
    final lots = json['lots'] as Map<String, dynamic>;

    return MatexInstrumentMetadata(
      code: json['code'] as String,
      icon: json['icon'] as String,
      format: MatexInstrumentFormatMetadata.fromJson(
        json['format'] as Map<String, dynamic>,
      ),
      lots: lots != null ? MatexInstrumentLotsMetadata.fromJson(lots) : null,
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
  List<Object> get props => [
        code,
        icon,
        format,
        lots,
        name,
        symbol,
        type,
      ];
}
