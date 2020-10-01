import 'package:equatable/equatable.dart';

class InstrumentNameMetadata extends Equatable {
  final String key;
  final String localized;

  const InstrumentNameMetadata({this.key, this.localized});

  static InstrumentNameMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentNameMetadata(
      key: json['key'] as String,
      localized: json['localized'] as String,
    );
  }

  @override
  List<Object> get props => [key, localized];
}
