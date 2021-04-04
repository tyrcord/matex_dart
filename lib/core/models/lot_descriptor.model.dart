import 'package:equatable/equatable.dart';

const _kExists = true;
const _kMultiplier = 1;

class MatexLotDescriptor extends Equatable {
  final num multiplier;
  final bool exists;

  const MatexLotDescriptor({
    this.multiplier = _kMultiplier,
    this.exists = _kExists,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'exists': exists,
        'multiplier': multiplier,
      };

  factory MatexLotDescriptor.fromJson(dynamic json) {
    return MatexLotDescriptor(
      multiplier: json['multiplier'] as num? ?? _kMultiplier,
      exists: json['exists'] as bool? ?? _kExists,
    );
  }

  @override
  List<Object?> get props => [exists, multiplier];
}

class MatexLotDescriptors extends Equatable {
  final MatexLotDescriptor? standard;
  final MatexLotDescriptor? micro;
  final MatexLotDescriptor? mini;
  final MatexLotDescriptor? nano;

  const MatexLotDescriptors({
    this.standard,
    this.micro,
    this.mini,
    this.nano,
  });

  MatexLotDescriptors copyWith({
    MatexLotDescriptor? standard,
    MatexLotDescriptor? micro,
    MatexLotDescriptor? mini,
    MatexLotDescriptor? nano,
  }) {
    return MatexLotDescriptors(
      standard: standard ?? this.standard,
      micro: micro ?? this.micro,
      mini: mini ?? this.mini,
      nano: nano ?? this.nano,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'standard': standard?.toJson(),
      'micro': micro?.toJson(),
      'mini': mini?.toJson(),
      'nano': nano?.toJson(),
    };
  }

  factory MatexLotDescriptors.fromJson(dynamic json) {
    return MatexLotDescriptors(
      standard: MatexLotDescriptor.fromJson(json['standard']),
      micro: MatexLotDescriptor.fromJson(json['micro']),
      mini: MatexLotDescriptor.fromJson(json['mini']),
      nano: MatexLotDescriptor.fromJson(json['nano']),
    );
  }

  @override
  List<Object?> get props => [standard, micro, mini, nano];
}

const kDefaultLotDescriptors = MatexLotDescriptors(
  standard: MatexLotDescriptor(multiplier: 100000),
  mini: MatexLotDescriptor(multiplier: 10000),
  micro: MatexLotDescriptor(multiplier: 1000),
  nano: MatexLotDescriptor(multiplier: 100),
);
