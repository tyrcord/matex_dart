import 'quote.interface.dart';

abstract class ExchangeProvider {
  Stream<Quote> rates(
    String base,
    String counter,
  );
}
