import 'package:matex_dart/src/core/calculators/abstract/base.dart';
import 'package:matex_dart/src/core/enums/enums.dart';
import 'package:matex_dart/src/core/models/models.dart';
import 'package:decimal/decimal.dart';

mixin LotMixin<C, R> on BaseCalculator<R> {
  C lotDescriptors(LotDescriptors lotDescriptors) {
    return setValue(CalculatorKey.LotDescriptors, lotDescriptors) as C;
  }

  C lot(int lot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      getValueForKey<LotDescriptors>(CalculatorKey.LotDescriptors).lot,
      lot,
    );
    return setValue(CalculatorKey.PositionSize, positionSize) as C;
  }

  C microLot(int microLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      getValueForKey<LotDescriptors>(CalculatorKey.LotDescriptors).microLot,
      microLot,
    );
    return setValue(CalculatorKey.PositionSize, positionSize) as C;
  }

  C miniLot(int miniLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      getValueForKey<LotDescriptors>(CalculatorKey.LotDescriptors).miniLot,
      miniLot,
    );
    return setValue(CalculatorKey.PositionSize, positionSize) as C;
  }

  C nanoLot(int nanoLot) {
    final positionSize = getPositionSizeWithLotDescriptorAndValue(
      getValueForKey<LotDescriptors>(CalculatorKey.LotDescriptors).nanoLot,
      nanoLot,
    );
    return setValue(CalculatorKey.PositionSize, positionSize) as C;
    ;
  }

  double getPositionSizeWithLotDescriptorAndValue(
    LotDescriptor lotDescriptor,
    num value,
  ) {
    final exists = lotDescriptor.exists;
    final multiplier = lotDescriptor.multiplier;

    if (exists) {
      return (Decimal.parse(value.toString()) *
              Decimal.parse(multiplier.toString()))
          .toDouble();
    }

    return 0;
  }
}
