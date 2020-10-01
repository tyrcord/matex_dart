import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MatexInstrumentLotUnitMetadata extends Equatable {
  static final Map<String, MatexInstrumentLotUnitMetadata> _cacheMap = {};
  final String key;
  final String long;
  final String short;

  MatexInstrumentLotUnitMetadata({
    @required this.key,
    @required this.long,
    @required this.short,
  });

  factory MatexInstrumentLotUnitMetadata.fromJson(Map<String, dynamic> json) {
    return MatexInstrumentLotUnitMetadata(
      key: json['key'] as String,
      long: json['long'] as String,
      short: json['short'] as String,
    );
  }

  factory MatexInstrumentLotUnitMetadata.addToCache(
    String key,
    Map<String, dynamic> json,
  ) {
    if (!_cacheMap.containsKey(key)) {
      _cacheMap[key] = MatexInstrumentLotUnitMetadata.fromJson(json);
    }

    return _cacheMap[key];
  }

  factory MatexInstrumentLotUnitMetadata.fromCache(String key) =>
      _cacheMap[key];

  @override
  List<Object> get props => [key, long, short];
}
