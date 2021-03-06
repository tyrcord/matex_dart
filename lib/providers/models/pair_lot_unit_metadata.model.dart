import 'package:equatable/equatable.dart';

const kMatexForexPairLotUnitMetadata = MatexPairLotUnitMetadata(
  key: 'forex',
  long: 'unit',
  short: 'unit',
);

class MatexPairLotUnitMetadata extends Equatable {
  static const Map<String, MatexPairLotUnitMetadata> _cacheMap = {
    'forex': kMatexForexPairLotUnitMetadata,
    'barrel': MatexPairLotUnitMetadata(
      key: 'barrel',
      long: 'barrel',
      short: 'bbl',
    ),
    'mmbtu': MatexPairLotUnitMetadata(
      key: 'mmbtu',
      long: 'metric million british Thermal unit',
      short: 'MMBtu',
    ),
    'ounce': MatexPairLotUnitMetadata(
      key: 'ounce',
      long: 'ounce',
      short: 'oz',
    ),
  };

  final String key;
  final String long;
  final String short;

  const MatexPairLotUnitMetadata({
    required this.key,
    required this.long,
    required this.short,
  });

  factory MatexPairLotUnitMetadata.fromJson(Map<String, dynamic> json) {
    return MatexPairLotUnitMetadata(
      key: json['key'] as String,
      long: json['long'] as String,
      short: json['short'] as String,
    );
  }

  factory MatexPairLotUnitMetadata.fromCache(String key) => _cacheMap[key]!;

  @override
  List<Object> get props => [key, long, short];
}
