import 'package:equatable/equatable.dart';

class PositionSizeResult extends Equatable {
  final double amountAtRisk;
  final double pipValue;
  final double positionSize;
  final double riskRatio;

  const PositionSizeResult({
    this.amountAtRisk,
    this.pipValue,
    this.positionSize,
    this.riskRatio,
  });

  @override
  List<Object> get props => [
        amountAtRisk,
        pipValue,
        positionSize,
        riskRatio,
      ];

  PositionSizeResult clone() {
    return PositionSizeResult(
      amountAtRisk: amountAtRisk,
      pipValue: pipValue,
      positionSize: positionSize,
      riskRatio: riskRatio,
    );
  }
}
