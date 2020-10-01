import 'package:equatable/equatable.dart';

class MatexInstrumentNameMetadata extends Equatable {
  final String key;
  final String localized;

  const MatexInstrumentNameMetadata({this.key, this.localized});

  static MatexInstrumentNameMetadata fromJson(Map<String, dynamic> json) {
    return MatexInstrumentNameMetadata(
      key: json['key'] as String,
      localized: json['localized'] as String,
    );
  }

  @override
  List<Object> get props => [key, localized];
}
