import 'package:matex_dart/src/core/models/models.dart';

const kDefaultLotDescriptors = LotDescriptors(
  lot: LotDescriptor(multiplier: 100000),
  miniLot: LotDescriptor(multiplier: 10000),
  microLot: LotDescriptor(multiplier: 1000),
  nanoLot: LotDescriptor(multiplier: 100),
);
