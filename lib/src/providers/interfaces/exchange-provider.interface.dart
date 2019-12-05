import '../models/quote.model.dart';

abstract class AbstractExchangeProvider {
  Future<Quote> rates(
    String base,
    String counter,
  );
}
