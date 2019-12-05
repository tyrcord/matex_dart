abstract class AbstractFormatterProvider {
  Future<String> formatInstrument({
    double value,
    String code,
    String locale,
    int minimumFractionDigits,
    int maximumFractionDigits,
  });

  Future<String> formatQuote({
    double value,
    String code,
    String locale,
    int minimumFractionDigits,
    int maximumFractionDigits,
  });
}
