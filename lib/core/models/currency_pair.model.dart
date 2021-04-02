import 'package:equatable/equatable.dart';

class MatexCurrencyPairModel extends Equatable {
  final String? counterCode;
  final String? baseCode;

  MatexCurrencyPairModel({this.counterCode, this.baseCode});

  @override
  List<Object?> get props => [baseCode, counterCode];
}
