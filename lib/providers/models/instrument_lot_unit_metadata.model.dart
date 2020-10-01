import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class InstrumentLotUnitMetadata extends Equatable {
  static final Map<String, InstrumentLotUnitMetadata> _cacheMap = {};
  final String key;
  final String long;
  final String short;

  InstrumentLotUnitMetadata({
    @required this.key,
    @required this.long,
    @required this.short,
  });

  factory InstrumentLotUnitMetadata.fromJson(Map<String, dynamic> json) {
    return InstrumentLotUnitMetadata(
      key: json['key'] as String,
      long: json['long'] as String,
      short: json['short'] as String,
    );
  }

  factory InstrumentLotUnitMetadata.addToCache(
    String key,
    Map<String, dynamic> json,
  ) {
    if (!_cacheMap.containsKey(key)) {
      _cacheMap[key] = InstrumentLotUnitMetadata.fromJson(json);
    }

    return _cacheMap[key];
  }

  factory InstrumentLotUnitMetadata.fromCache(String key) => _cacheMap[key];

  @override
  List<Object> get props => [key, long, short];
}
