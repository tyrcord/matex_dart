import 'package:equatable/equatable.dart';

class MatexQuote extends Equatable {
  final double price;
  final String symbol;
  final int timestamp;

  const MatexQuote({
    required this.price,
    required this.symbol,
    required this.timestamp,
  });

  factory MatexQuote.fromJson(Map<String, dynamic> json) {
    return MatexQuote(
      price: json['price'] as double,
      symbol: json['symbol'] as String,
      timestamp: json['timestamp'] as int,
    );
  }

  @override
  List<Object> get props => [price, symbol, timestamp];
}
