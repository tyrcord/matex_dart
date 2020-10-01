import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PairTypeMetadata extends Equatable {
  static final Map<String, PairTypeMetadata> _cacheMap = {};
  final String key;
  final String main;
  final String subKey;
  final String sub;
  final double weight;

  const PairTypeMetadata({
    @required this.key,
    @required this.main,
    this.subKey,
    this.sub,
    this.weight = 0,
  });

  factory PairTypeMetadata.fromJson(Map<String, dynamic> json) {
    return PairTypeMetadata(
      key: json['key'] as String,
      main: json['main'] as String,
      subKey: json['subKey'] as String,
      sub: json['sub'] as String,
      weight: double.parse(json['weight'].toString()),
    );
  }

  factory PairTypeMetadata.addToCache(
    String key,
    Map<String, dynamic> json,
  ) {
    if (!_cacheMap.containsKey(key)) {
      _cacheMap[key] = PairTypeMetadata.fromJson(json);
    }

    return _cacheMap[key];
  }

  factory PairTypeMetadata.fromCache(String key) => _cacheMap[key];

  @override
  List<Object> get props => [key, main, subKey, sub, weight];
}
