import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final double price;
  final String symbol;
  final int timestamp;

  const Quote({
    this.price,
    this.symbol,
    this.timestamp,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      price: json['price'] as double,
      symbol: json['symbol'] as String,
      timestamp: json['timestamp'] as int,
    );
  }

  @override
  List<Object> get props => [price, symbol, timestamp];
}
