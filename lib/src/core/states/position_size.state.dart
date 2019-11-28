// import 'package:equatable/equatable.dart';
// import 'package:matex_dart/matex_dart.dart';

// class PositionSizeState
//     with EquatableMixin
//     implements BaseState<PositionSizeState> {
//   final double baseExchangeRate;
//   final double tradingPairExchangeRate;
//   final double positionSize;
//   final int pipPrecision;
//   final LotDescriptors lotDescriptors;
//   final bool baseListedSecond;
//   final double accountSize;
//   final double amountAtRisk;
//   final double entryPrice;
//   final double riskRatio;
//   final double stopLossPips;
//   final double stopLossPrice;

//   PositionSizeState({
//     this.baseExchangeRate,
//     this.tradingPairExchangeRate,
//     this.positionSize,
//     this.pipPrecision,
//     this.lotDescriptors,
//     this.baseListedSecond,
//     this.accountSize,
//     this.amountAtRisk,
//     this.entryPrice,
//     this.riskRatio,
//     this.stopLossPips,
//     this.stopLossPrice,
//   }) : super();

//   @override
//   List<Object> get props => [
//         baseExchangeRate,
//         tradingPairExchangeRate,
//         positionSize,
//         pipPrecision,
//         lotDescriptors,
//         baseListedSecond,
//         accountSize,
//         amountAtRisk,
//         entryPrice,
//         riskRatio,
//         stopLossPips,
//         stopLossPrice,
//       ];

//   @override
//   PositionSizeState copyWith({
//     double baseExchangeRate,
//     double tradingPairExchangeRate,
//     double positionSize,
//     int pipPrecision,
//     LotDescriptors lotDescriptors,
//     bool baseListedSecond,
//     double accountSize,
//     double amountAtRisk,
//     double entryPrice,
//     double riskRatio,
//     double stopLossPips,
//     double stopLossPrice,
//   }) {
//     return PositionSizeState(
//       baseExchangeRate: baseExchangeRate ?? this.baseExchangeRate,
//       tradingPairExchangeRate:
//           tradingPairExchangeRate ?? this.tradingPairExchangeRate,
//       positionSize: positionSize ?? this.positionSize,
//       pipPrecision: pipPrecision ?? this.pipPrecision,
//       lotDescriptors: lotDescriptors ?? this.lotDescriptors,
//       baseListedSecond: baseListedSecond ?? this.baseListedSecond,
//       accountSize: accountSize ?? this.accountSize,
//       amountAtRisk: amountAtRisk ?? this.amountAtRisk,
//       entryPrice: entryPrice ?? this.entryPrice,
//       riskRatio: riskRatio ?? this.riskRatio,
//       stopLossPips: stopLossPips ?? this.stopLossPips,
//       stopLossPrice: stopLossPrice ?? this.stopLossPrice,
//     );
//   }

//   @override
//   PositionSizeState copyWithState(PositionSizeState state) {
//     return copyWith(
//       baseExchangeRate: state.baseExchangeRate,
//       tradingPairExchangeRate: state.tradingPairExchangeRate,
//       positionSize: state.positionSize,
//       pipPrecision: state.pipPrecision,
//       lotDescriptors: state.lotDescriptors,
//       baseListedSecond: state.baseListedSecond,
//       accountSize: state.accountSize,
//       amountAtRisk: state.amountAtRisk,
//       entryPrice: state.entryPrice,
//       riskRatio: state.riskRatio,
//       stopLossPips: state.stopLossPips,
//       stopLossPrice: state.stopLossPrice,
//     );
//   }
// }

// final PositionSizeState initialPipValueState = PositionSizeState(
//   baseExchangeRate: 0.0,
//   baseListedSecond: false,
//   lotDescriptors: kDefaultLotDescriptors,
//   pipPrecision: 4,
//   positionSize: 1.0,
//   tradingPairExchangeRate: 0.0,
//   accountSize: 0.0,
//   amountAtRisk: 0.0,
//   entryPrice: 0.0,
//   riskRatio: 0.0,
//   stopLossPips: 0.0,
//   stopLossPrice: 0.0,
// );
