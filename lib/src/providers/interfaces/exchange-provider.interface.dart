import 'quote.interface.dart';

abstract class AbstractExchangeProvider {
  Stream<Quote> rates(
    String base,
    String counter,
  );
}
