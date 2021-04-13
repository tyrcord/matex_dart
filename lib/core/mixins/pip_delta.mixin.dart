import 'package:matex_dart/matex_dart.dart';

mixin MatexPipDeltaCoreMixin<C extends MatexBaseCalculator<C, R>, R>
    on MatexBaseCalculator<C, R> {
  C priceA(double price) {
    return patchState(MatexBaseCoreState(priceA: sanitizeDouble(price)));
  }

  C priceB(double price) {
    return patchState(MatexBaseCoreState(priceB: sanitizeDouble(price)));
  }

  C pipPrecision(int pipPrecision) {
    return patchState(MatexBaseCoreState(pipPrecision: pipPrecision));
  }
}
