class LotDescriptor {
  final bool exists;
  final num multiplier;

  const LotDescriptor({
    this.exists = true,
    this.multiplier,
  });
}

class LotDescriptors {
  final LotDescriptor lot;
  final LotDescriptor microLot;
  final LotDescriptor miniLot;
  final LotDescriptor nanoLot;

  const LotDescriptors({
    this.lot,
    this.microLot,
    this.miniLot,
    this.nanoLot,
  });

  LotDescriptors copyWith({
    LotDescriptor lot,
    LotDescriptor microLot,
    LotDescriptor miniLot,
    LotDescriptor nanoLot,
  }) {
    return LotDescriptors(
      lot: lot ?? this.lot,
      microLot: microLot ?? this.microLot,
      miniLot: miniLot ?? this.miniLot,
      nanoLot: nanoLot ?? this.nanoLot,
    );
  }
}
