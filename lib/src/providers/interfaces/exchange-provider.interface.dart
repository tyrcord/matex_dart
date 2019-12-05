import '../models/quote.model.dart';

abstract class AbstractExchangeProvider {
  Stream<Quote> rates(
    String base,
    String counter,
  );
}
