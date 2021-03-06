import 'package:equatable/equatable.dart';

class MatexLotDescriptor extends Equatable {
  final bool exists;
  final num multiplier;

  const MatexLotDescriptor({
    this.exists = true,
    this.multiplier = 1,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'exists': exists,
        'multiplier': multiplier,
      };

  factory MatexLotDescriptor.fromJson(dynamic json) {
    return MatexLotDescriptor(
      exists: json['standard'] as bool,
      multiplier: json['multiplier'] as num,
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
