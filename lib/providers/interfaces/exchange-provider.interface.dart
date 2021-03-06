import '../models/quote.model.dart';

abstract class MatexAbstractExchangeProvider {
  const MatexAbstractExchangeProvider();

  Future<MatexQuote> rates(String? base, String? counter);
}
