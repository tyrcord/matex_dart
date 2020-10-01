import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MatexPairTypeMetadata extends Equatable {
  static final Map<String, MatexPairTypeMetadata> _cacheMap = {};
  final String key;
  final String main;
  final String subKey;
  final String sub;
  final double weight;

  const MatexPairTypeMetadata({
    @required this.key,
    @required this.main,
    this.subKey,
    this.sub,
    this.weight = 0,
  });

  factory MatexPairTypeMetadata.fromJson(Map<String, dynamic> json) {
    return MatexPairTypeMetadata(
      key: json['key'] as String,
      main: json['main'] as String,
      subKey: json['subKey'] as String,
      sub: json['sub'] as String,
      weight: double.parse(json['weight'].toString()),
    );
  }

  factory MatexPairTypeMetadata.addToCache(
    String key,
    Map<String, dynamic> json,
  ) {
    if (!_cacheMap.containsKey(key)) {
      _cacheMap[key] = MatexPairTypeMetadata.fromJson(json);
    }

    return _cacheMap[key];
  }

  factory MatexPairTypeMetadata.fromCache(String key) => _cacheMap[key];

  @override
  List<Object> get props => [key, main, subKey, sub, weight];
}
