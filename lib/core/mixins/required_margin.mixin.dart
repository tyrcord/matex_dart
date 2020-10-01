import 'package:matex_dart/matex_dart.dart';

mixin MatexRequiredMarginCoreMixin<C extends MatexBaseCalculator<C, S, R>,
    S extends MatexBaseCoreState, R> on MatexBaseCalculator<C, S, R> {
  C leverage(double leverage) {
    final sanitizedValue = sanitizeDouble(leverage);
    return patchState(MatexBaseCoreState(leverage: sanitizedValue));
  }
}
