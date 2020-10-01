import 'package:equatable/equatable.dart';

class InstrumentSymbolMetadata extends Equatable {
  final String ticker;
  final String long;
  final String short;

  const InstrumentSymbolMetadata({
    this.ticker,
    this.long,
    this.short,
  });

  static InstrumentSymbolMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentSymbolMetadata(
      ticker: json['ticker'] as String,
      long: json['long'] as String,
      short: json['short'] as String,
    );
  }

  @override
  List<Object> get props => [ticker, long, short];
}
