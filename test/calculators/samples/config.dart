import 'package:matex_dart/matex_dart.dart';

class ExchangeProvider extends AbstractExchangeProvider {
  const ExchangeProvider() : super();

  @override
  Future<Quote> rates(String base, String counter) async {
    var price = 0.0;

    if (base == 'EUR') {
      if (counter == 'USD' || counter == 'CAD') {
        price = 1.25;
      } else {
        price = 1;
      }
    } else if (base == 'USD') {
      if (counter == 'EUR') {
        price = 0.75;
      } else if (counter == 'AUD') {
        price = 1.6;
      } else {
        price = 1;
      }
    } else if (base == 'AUD') {
      if (counter == 'JPY') {
        price = 100;
      } else if (counter == 'USD') {
        price = 0.75;
      }
    }

    return Quote(
      price: price,
      symbol: '$base/$counter',
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

const testMatexConfig = MatexConfig(
  exchangeProvider: ExchangeProvider(),
);
