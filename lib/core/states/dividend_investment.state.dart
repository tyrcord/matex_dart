import 'package:matex_dart/matex_dart.dart';

const kDefaultDividendReinvestmentState = MatexBaseCoreState(
  dividendPaymentFrequency: MatexFrequency.annually,
  yearsToGrow: 25,
  drip: true,
);
