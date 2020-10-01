import 'package:equatable/equatable.dart';

class MatexInstrumentSymbolMetadata extends Equatable {
  final String ticker;
  final String long;
  final String short;

  const MatexInstrumentSymbolMetadata({
    this.ticker,
    this.long,
    this.short,
  });

  static MatexInstrumentSymbolMetadata fromJson(Map<String, dynamic> json) {
    return MatexInstrumentSymbolMetadata(
      ticker: json['ticker'] as String,
      long: json['long'] as String,
      short: json['short'] as String,
    );
  }

  @override
  List<Object> get props => [ticker, long, short];
}
