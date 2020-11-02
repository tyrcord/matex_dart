import 'package:matex_dart/matex_dart.dart';

class ExchangeProvider extends MatexAbstractExchangeProvider {
  const ExchangeProvider() : super();

  @override
  Future<MatexQuote> rates(String base, String counter) async {
    var price = 0.0;

    if (base == 'EUR') {
      if (counter == 'USD' || counter == 'CAD') {
        price = 1.25;
      } else if (counter == 'XAU') {
        price = 0.001;
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
    } else if (base == 'JPY') {
      if (counter == 'EUR') {
        price = 0.05;
      } else if (counter == 'USD') {
        price = 0.05;
      }
    } else if (base == 'AUD') {
      if (counter == 'JPY') {
        price = 100;
      } else if (counter == 'USD') {
        price = 0.75;
      }
    } else if (base == 'XAU') {
      if (counter == 'JPY') {
        price = 200000;
      }
    }

    return MatexQuote(
      price: price,
      symbol: '$base/$counter',
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

const testMatexConfig = MatexConfig(
  exchangeProvider: ExchangeProvider(),
);
