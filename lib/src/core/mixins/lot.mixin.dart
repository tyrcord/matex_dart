import 'package:matex_dart/matex_dart.dart';
import 'package:matex_dart/src/core/models/models.dart';
import 'package:decimal/decimal.dart';

mixin LotMixin<C, S extends BaseState, R> on BaseCalculator<S, R> {
  C lotDescriptors(LotDescriptors lotDescriptors) {
    return patchState(BaseState(lotDescriptors: lotDescriptors)) as C;
  }

  C lot(int lot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.lot,
      lot,
    );
    return patchState(BaseState(positionSize: positionSize)) as C;
  }

  C microLot(int microLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.microLot,
      microLot,
    );
    return patchState(BaseState(positionSize: positionSize)) as C;
  }

  C miniLot(int miniLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.miniLot,
      miniLot,
    );
    return patchState(BaseState(positionSize: positionSize)) as C;
  }

  C nanoLot(int nanoLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.nanoLot,
      nanoLot,
    );
    return patchState(BaseState(positionSize: positionSize)) as C;
  }

  double getPositionSizeWithLotDescriptorAndValue(
    LotDescriptor lotDescriptor,
    num value,
  ) {
    if (lotDescriptor.exists) {
      final multiplier = lotDescriptor.multiplier;

      return (Decimal.parse(value.toString()) *
              Decimal.parse(multiplier.toString()))
          .toDouble();
    }

    return 0;
  }
}
