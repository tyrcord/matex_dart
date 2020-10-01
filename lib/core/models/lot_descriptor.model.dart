class LotDescriptor {
  final bool exists;
  final num multiplier;

  const LotDescriptor({
    this.exists = true,
    this.multiplier = 1,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'exists': exists,
        'multiplier': multiplier,
      };

  factory LotDescriptor.fromJson(dynamic json) {
    return LotDescriptor(
      exists: json['standard'] as bool,
      multiplier: json['multiplier'] as num,
    );
  }
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'standard': standard.toJson(),
      'micro': micro.toJson(),
      'mini': mini.toJson(),
      'nano': nano.toJson(),
    };
  }

  factory LotDescriptors.fromJson(dynamic json) {
    return LotDescriptors(
      standard: LotDescriptor.fromJson(json['standard']),
      micro: LotDescriptor.fromJson(json['micro']),
      mini: LotDescriptor.fromJson(json['mini']),
      nano: LotDescriptor.fromJson(json['nano']),
    );
  }
}

const kDefaultLotDescriptors = LotDescriptors(
  standard: LotDescriptor(multiplier: 100000),
  mini: LotDescriptor(multiplier: 10000),
  micro: LotDescriptor(multiplier: 1000),
  nano: LotDescriptor(multiplier: 100),
);
