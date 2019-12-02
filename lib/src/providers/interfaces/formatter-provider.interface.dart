abstract class AbstractFormatterProvider {
  Stream<String> formatInstrument({
    double value,
    String code,
    String locale,
    int minimumFractionDigits,
    int maximumFractionDigits,
  });

  Stream<String> formatQuote({
    double value,
    String code,
    String locale,
    int minimumFractionDigits,
    int maximumFractionDigits,
  });
}
