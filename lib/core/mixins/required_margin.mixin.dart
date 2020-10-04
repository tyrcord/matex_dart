import 'package:matex_dart/matex_dart.dart';

mixin MatexRequiredMarginCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C leverage(double leverage) {
    final sanitizedValue = sanitizeDouble(leverage);
    return patchState(MatexBaseCoreState(leverage: sanitizedValue));
  }
}
