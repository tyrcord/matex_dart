enum InstrumentLotsUnit {
  Forex,
  Barrel,
  Mmbtu,
}

enum InstrumentType {
  CommodityEnergy,
}

class InstrumentMetadata {
  String code;
  InstrumentLotsMetadata lots;
  InstrumentNameMetadata name;
  InstrumentPairMetadata pair;
  InstrumentPipMetadata pip;
  InstrumentFormatMetadata format;
  InstrumentSymbolMetadata symbol;
  InstrumentType type;
}

class InstrumentLotsMetadata {
  int micro;
  int mini;
  int nano;
  int standard;
  InstrumentLotsUnit unit;
}

class InstrumentNameMetadata {
  String key;
  String localized;
}

class InstrumentPairMetadata {
  bool base;
  bool counter;
}

class InstrumentPipMetadata {
  int precision;
  int pipette;
  int round;
}

class InstrumentFormatMetadata {
  int round;
}

class InstrumentSymbolMetadata {
  String ticker;
  String long;
  String short;
}
