import 'package:equatable/equatable.dart';

import 'package:matex_dart/matex_dart.dart';

const _kDefaultPairLotsMetadata = MatexPairLotsMetadata(
  micro: 1000,
  mini: 10000,
  nano: 100,
  normalized: true,
  standard: 100000,
  unit: kMatexForexPairLotUnitMetadata,
);

class MatexPairLotsMetadata extends Equatable {
  final int? micro;
  final int? mini;
  final int? nano;
  final bool? normalized;
  final int? standard;
  final MatexPairLotUnitMetadata unit;

  const MatexPairLotsMetadata({
    this.micro,
    this.mini,
    this.nano,
    this.normalized,
    this.standard,
    required this.unit,
  });

  static MatexPairLotsMetadata fromJson(Map<String, dynamic> json) {
    return MatexPairLotsMetadata(
      micro: json['micro'] as int?,
      mini: json['mini'] as int?,
      nano: json['nano'] as int?,
      normalized: json['normalized'] as bool?,
      standard: json['standard'] as int?,
      unit: MatexPairLotUnitMetadata.fromCache(json['unit'] as String),
    );
  }

  static MatexPairLotsMetadata defaultMetatada() => _kDefaultPairLotsMetadata;

  @override
  List<Object?> get props => [
        micro,
        mini,
        nano,
        normalized,
        standard,
        unit,
      ];
}
