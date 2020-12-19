import 'package:matex_dart/matex_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';

mixin MatexLotCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C lotDescriptors(MatexLotDescriptors lotDescriptors) {
    return patchState(MatexBaseCoreState(lotDescriptors: lotDescriptors));
  }

  C lot(int lot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.standard,
      lot,
    );

    return patchState(MatexBaseCoreState(positionSize: positionSize));
  }

  C microLot(int microLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.micro,
      microLot,
    );

    return patchState(MatexBaseCoreState(positionSize: positionSize));
  }

  C miniLot(int miniLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.mini,
      miniLot,
    );

    return patchState(MatexBaseCoreState(positionSize: positionSize));
  }

  C nanoLot(int nanoLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      state.lotDescriptors.nano,
      nanoLot,
    );

    return patchState(MatexBaseCoreState(positionSize: positionSize));
  }

  @protected
  double getPositionSizeWithLotDescriptorAndValue(
    MatexLotDescriptor lotDescriptor,
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
