import 'package:equatable/equatable.dart';

import 'package:matex_dart/matex_dart.dart';

class InstrumentLotsMetadata extends Equatable {
  final int micro;
  final int mini;
  final int nano;
  final bool normalized;
  final int standard;
  final InstrumentLotUnitMetadata unit;

  const InstrumentLotsMetadata({
    this.micro,
    this.mini,
    this.nano,
    this.normalized,
    this.standard,
    this.unit,
  });

  static InstrumentLotsMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentLotsMetadata(
      micro: json['micro'] as int,
      mini: json['mini'] as int,
      nano: json['nano'] as int,
      normalized: json['normalized'] as bool,
      standard: json['standard'] as int,
      unit: InstrumentLotUnitMetadata.fromCache(json['unit'] as String),
    );
  }

  @override
  List<Object> get props => [
        micro,
        mini,
        nano,
        normalized,
        standard,
        unit,
      ];
}
