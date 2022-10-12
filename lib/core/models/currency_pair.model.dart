import 'package:equatable/equatable.dart';

class MatexCurrencyPairModel extends Equatable {
  final String? counterCode;
  final String? baseCode;

  MatexCurrencyPairModel({this.counterCode, this.baseCode});

  bool isValid() {
    return counterCode != null &&
        baseCode != null &&
        counterCode!.isNotEmpty &&
        baseCode!.isNotEmpty;
  }

  @override
  List<Object?> get props => [baseCode, counterCode];
}
