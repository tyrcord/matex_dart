import 'package:equatable/equatable.dart';

class InstrumentFormatMetadata extends Equatable {
  final int round;

  const InstrumentFormatMetadata({this.round});

  static InstrumentFormatMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentFormatMetadata(round: json['round'] as int);
  }

  @override
  List<Object> get props => [round];
}
