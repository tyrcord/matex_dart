class LotDescriptor {
  final bool exists;
  final num multiplier;

  const LotDescriptor({
    this.exists = true,
    this.multiplier,
  });
}

class LotDescriptors {
  final LotDescriptor standard;
  final LotDescriptor micro;
  final LotDescriptor mini;
  final LotDescriptor nano;

  const LotDescriptors({
    this.standard,
    this.micro,
    this.mini,
    this.nano,
  });

  LotDescriptors copyWith({
    LotDescriptor standard,
    LotDescriptor micro,
    LotDescriptor mini,
    LotDescriptor nano,
  }) {
    return LotDescriptors(
      standard: standard ?? this.standard,
      micro: micro ?? this.micro,
      mini: mini ?? this.mini,
      nano: nano ?? this.nano,
    );
  }
}

const kDefaultLotDescriptors = LotDescriptors(
  standard: LotDescriptor(multiplier: 100000),
  mini: LotDescriptor(multiplier: 10000),
  micro: LotDescriptor(multiplier: 1000),
  nano: LotDescriptor(multiplier: 100),
);
