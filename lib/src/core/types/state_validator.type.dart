import 'package:matex_dart/matex_dart.dart';

typedef StateValidator<S extends BaseState> = bool Function(S state);
