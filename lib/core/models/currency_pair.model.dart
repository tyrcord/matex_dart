import 'package:equatable/equatable.dart';

class MatexCurrencyPairModel extends Equatable {
  final String counterCode;
  final String baseCode;

  MatexCurrencyPairModel({required this.counterCode, required this.baseCode});

  @override
  List<Object> get props => [baseCode, counterCode];
}
