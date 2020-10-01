import 'package:equatable/equatable.dart';

import 'package:matex_dart/matex_dart.dart';

class InstrumentMetadata extends Equatable {
  final String code;
  final String icon;
  final InstrumentFormatMetadata format;
  final InstrumentLotsMetadata lots;
  final InstrumentNameMetadata name;
  final InstrumentPipMetadata pip;
  final InstrumentSymbolMetadata symbol;
  final InstrumentTypeMetadata type;

  const InstrumentMetadata({
    this.code,
    this.icon,
    this.format,
    this.lots,
    this.name,
    this.pip,
    this.symbol,
    this.type,
  });

  factory InstrumentMetadata.fromJson(Map<String, dynamic> json) {
    final lots = json['lots'] as Map<String, dynamic>;

    return InstrumentMetadata(
      code: json['code'] as String,
      icon: json['icon'] as String,
      format: InstrumentFormatMetadata.fromJson(
        json['format'] as Map<String, dynamic>,
      ),
      lots: lots != null ? InstrumentLotsMetadata.fromJson(lots) : null,
      name: InstrumentNameMetadata.fromJson(
        json['name'] as Map<String, dynamic>,
      ),
      pip: InstrumentPipMetadata.fromJson(
        json['pip'] as Map<String, dynamic>,
      ),
      symbol: InstrumentSymbolMetadata.fromJson(
        json['symbol'] as Map<String, dynamic>,
      ),
      type: InstrumentTypeMetadata.fromCache(json['type'] as String),
    );
  }

  @override
  List<Object> get props => [
        code,
        icon,
        format,
        lots,
        name,
        pip,
        symbol,
        type,
      ];
}
