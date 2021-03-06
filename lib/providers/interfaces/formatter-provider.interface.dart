abstract class MatexAbstractFormatterProvider {
  Future<String> formatInstrument({
    required double value,
    required String code,
    required String locale,
    int? minimumFractionDigits,
    int? maximumFractionDigits,
  });

  Future<String> formatQuote({
    required double value,
    required String pair,
    required String locale,
    int? minimumFractionDigits,
    int? maximumFractionDigits,
  });
}
