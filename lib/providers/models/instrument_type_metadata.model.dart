import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MatexInstrumentTypeMetadata extends Equatable {
  static final Map<String, MatexInstrumentTypeMetadata> _cacheMap = {};
  final String key;
  final String main;
  final String subKey;
  final String sub;
  final double weight;

  const MatexInstrumentTypeMetadata({
    @required this.key,
    @required this.main,
    this.subKey,
    this.sub,
    double weight = 0,
  })  : assert(key != null),
        assert(main != null),
        weight = weight ?? 0,
        super();

  factory MatexInstrumentTypeMetadata.fromJson(Map<String, dynamic> json) {
    return MatexInstrumentTypeMetadata(
      key: json['key'] as String,
      main: json['main'] as String,
      subKey: json['subKey'] as String,
      sub: json['sub'] as String,
      weight: double.parse(json['weight'].toString()),
    );
  }

  factory MatexInstrumentTypeMetadata.addToCache(
    String key,
    Map<String, dynamic> json,
  ) {
    if (!_cacheMap.containsKey(key)) {
      _cacheMap[key] = MatexInstrumentTypeMetadata.fromJson(json);
    }

    return _cacheMap[key];
  }

  factory MatexInstrumentTypeMetadata.fromCache(String key) => _cacheMap[key];

  @override
  List<Object> get props => [key, main, subKey, sub, weight];
}
