import 'package:matex_dart/matex_dart.dart';
import 'package:matex_dart/src/core/models/models.dart';
import 'package:decimal/decimal.dart';

mixin LotMixin<C extends BaseCalculator<S, R>, S extends BaseState, R>
    on BaseCalculator<S, R> {
  C lotDescriptors(LotDescriptors lotDescriptors) {
    return patchState<C>(BaseState(lotDescriptors: lotDescriptors));
  }

  C lot(int lot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.standard,
      lot,
    );
    return patchState<C>(BaseState(positionSize: positionSize));
  }

  C microLot(int microLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.micro,
      microLot,
    );
    return patchState<C>(BaseState(positionSize: positionSize));
  }

  C miniLot(int miniLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.mini,
      miniLot,
    );
    return patchState<C>(BaseState(positionSize: positionSize));
  }

  C nanoLot(int nanoLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.nano,
      nanoLot,
    );
    return patchState<C>(BaseState(positionSize: positionSize));
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
