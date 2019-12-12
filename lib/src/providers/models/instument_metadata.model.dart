enum InstrumentLotsUnit {
  Forex,
  Barrel,
  Ounce,
  Mmbtu,
  Unknown,
}

class InstrumentMetadata {
  final String code;
  final InstrumentFormatMetadata format;
  final InstrumentLotsMetadata lots;
  final InstrumentNameMetadata name;
  final InstrumentPairMetadata pair;
  final InstrumentPipMetadata pip;
  final InstrumentSymbolMetadata symbol;
  final InstrumentTypeMetadata type;

  const InstrumentMetadata({
    this.code,
    this.format,
    this.lots,
    this.name,
    this.pair,
    this.pip,
    this.symbol,
    this.type,
  });

  static InstrumentMetadata fromJson(Map<String, dynamic> json) {
    final lots = json['lots'] as Map<String, dynamic>;

    return InstrumentMetadata(
      code: json['code'] as String,
      format: InstrumentFormatMetadata.fromJson(
        json['format'] as Map<String, dynamic>,
      ),
      lots: lots != null ? InstrumentLotsMetadata.fromJson(lots) : null,
      name: InstrumentNameMetadata.fromJson(
        json['name'] as Map<String, dynamic>,
      ),
      pair: InstrumentPairMetadata.fromJson(
        json['pair'] as Map<String, dynamic>,
      ),
      pip: InstrumentPipMetadata.fromJson(
        json['pip'] as Map<String, dynamic>,
      ),
      symbol: InstrumentSymbolMetadata.fromJson(
        json['symbol'] as Map<String, dynamic>,
      ),
      type: InstrumentTypeMetadata.fromJson(
        json['type'] as Map<String, dynamic>,
      ),
    );
  }
}

class InstrumentLotsMetadata {
  final int micro;
  final int mini;
  final int nano;
  final bool normalized;
  final int standard;
  final InstrumentLotsUnit unit;

  const InstrumentLotsMetadata({
    this.micro,
    this.mini,
    this.nano,
    this.normalized,
    this.standard,
    this.unit,
  });

  static InstrumentLotsMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentLotsMetadata(
      micro: json['micro'] as int,
      mini: json['mini'] as int,
      nano: json['nano'] as int,
      normalized: json['normalized'] as bool,
      standard: json['standard'] as int,
      unit: getUnitFromRawData(json['unit'] as String),
    );
  }

  static InstrumentLotsUnit getUnitFromRawData(String data) {
    switch (data) {
      case 'forex':
        return InstrumentLotsUnit.Forex;
      case 'barrel':
        return InstrumentLotsUnit.Barrel;
      case 'ounce':
        return InstrumentLotsUnit.Ounce;
      case 'mmbtu':
        return InstrumentLotsUnit.Mmbtu;
      default:
        return InstrumentLotsUnit.Unknown;
    }
  }
}

class InstrumentNameMetadata {
  final String key;
  final String localized;

  const InstrumentNameMetadata({
    this.key,
    this.localized,
  });

  static InstrumentNameMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentNameMetadata(
      key: json['key'] as String,
      localized: json['localized'] as String,
    );
  }
}

class InstrumentPairMetadata {
  final bool base;
  final bool counter;

  const InstrumentPairMetadata({
    this.base,
    this.counter,
  });

  static InstrumentPairMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentPairMetadata(
      base: json['base'] as bool,
      counter: json['counter'] as bool,
    );
  }
}

class InstrumentPipMetadata {
  final int precision;
  final int pipette;
  final int round;

  const InstrumentPipMetadata({
    this.precision,
    this.pipette,
    this.round,
  });

  static InstrumentPipMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentPipMetadata(
      precision: json['precision'] as int,
      pipette: json['pipette'] as int,
      round: json['round'] as int,
    );
  }
}

class InstrumentFormatMetadata {
  final int round;

  const InstrumentFormatMetadata({
    this.round,
  });

  static InstrumentFormatMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentFormatMetadata(
      round: json['round'] as int,
    );
  }
}

class InstrumentSymbolMetadata {
  final String ticker;
  final String long;
  final String short;

  const InstrumentSymbolMetadata({
    this.ticker,
    this.long,
    this.short,
  });

  static InstrumentSymbolMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentSymbolMetadata(
      ticker: json['ticker'] as String,
      long: json['long'] as String,
      short: json['short'] as String,
    );
  }
}

class InstrumentTypeMetadata {
  final String main;
  final String sub;

  const InstrumentTypeMetadata({
    this.main,
    this.sub,
  });

  static InstrumentTypeMetadata fromJson(Map<String, dynamic> json) {
    return InstrumentTypeMetadata(
      main: json['main'] as String,
      sub: json['sub'] as String,
    );
  }
}
