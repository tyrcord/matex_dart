import 'package:matex_dart/matex_dart.dart';

mixin RequiredMarginMixin<C extends BaseCalculator<C, S, R>,
    S extends BaseState, R> on BaseCalculator<C, S, R> {
  C leverage(double leverage) {
    final sanitizedValue = sanitizeDouble(leverage);
    return patchState(BaseState(leverage: sanitizedValue));
  }
}
