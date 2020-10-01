import '../models/quote.model.dart';

abstract class AbstractExchangeProvider {
  const AbstractExchangeProvider();

  Future<Quote> rates(
    String base,
    String counter,
  );
}
