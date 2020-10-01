import 'package:equatable/equatable.dart';

class MatexInstrumentFormatMetadata extends Equatable {
  final int round;

  const MatexInstrumentFormatMetadata({this.round});

  static MatexInstrumentFormatMetadata fromJson(Map<String, dynamic> json) {
    return MatexInstrumentFormatMetadata(round: json['round'] as int);
  }

  @override
  List<Object> get props => [round];
}
