import 'package:equatable/equatable.dart';

class MatexPositionSizeResult extends Equatable {
  final double amountAtRisk;
  final double pipValue;
  final double positionSize;
  final double riskRatio;
  final double stopLossPips;

  const MatexPositionSizeResult({
    this.amountAtRisk,
    this.pipValue,
    this.positionSize,
    this.riskRatio,
    this.stopLossPips,
  });

  @override
  List<Object> get props => [
        amountAtRisk,
        pipValue,
        positionSize,
        riskRatio,
        stopLossPips,
      ];

  MatexPositionSizeResult clone() {
    return MatexPositionSizeResult(
      amountAtRisk: amountAtRisk,
      pipValue: pipValue,
      positionSize: positionSize,
      riskRatio: riskRatio,
      stopLossPips: stopLossPips,
    );
  }
}
