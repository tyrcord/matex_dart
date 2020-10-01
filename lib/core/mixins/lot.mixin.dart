import 'package:matex_dart/matex_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';

mixin LotMixin<C extends BaseCalculator<C, S, R>, S extends BaseState, R>
    on BaseCalculator<C, S, R> {
  C lotDescriptors(LotDescriptors lotDescriptors) {
    return patchState(BaseState(lotDescriptors: lotDescriptors));
  }

  C lot(int lot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.standard,
      lot,
    );
    return patchState(BaseState(positionSize: positionSize));
  }

  C microLot(int microLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.micro,
      microLot,
    );
    return patchState(BaseState(positionSize: positionSize));
  }

  C miniLot(int miniLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.mini,
      miniLot,
    );
    return patchState(BaseState(positionSize: positionSize));
  }

  C nanoLot(int nanoLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.nano,
      nanoLot,
    );
    return patchState(BaseState(positionSize: positionSize));
  }

  @protected
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
