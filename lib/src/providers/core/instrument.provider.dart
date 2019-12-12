import 'dart:async';
import 'dart:convert' show jsonDecode;
import 'dart:io' show File;

import '../interfaces/interfaces.dart';
import '../models/models.dart';

const _kInstrumentsPath = 'lib/src/providers/meta/instruments.json';

class InstrumentProvider implements AbstractInstrumentProvider {
  Map<String, InstrumentMetadata> _instrumentsMetadata;
  Future<bool> _initializingFuture;
  bool _isInitialized = false;

  static final InstrumentProvider _singleton = InstrumentProvider._();

  factory InstrumentProvider() {
    return _singleton;
  }

  InstrumentProvider._();

  @override
  Future<InstrumentMetadata> metadata(String code) async {
    if (!_isInitialized) {
      await _init();
    }

    return _instrumentsMetadata[code];
  }

  Future<bool> _init() {
    _initializingFuture ??=
        File(_kInstrumentsPath).readAsString().then((String json) {
      final instrumentsMetadata = jsonDecode(json) as Map<String, dynamic>;

      instrumentsMetadata.removeWhere((key, value) {
        return key == 'lot_units';
      });

      _instrumentsMetadata =
          instrumentsMetadata.map<String, InstrumentMetadata>((key, value) {
        return MapEntry(
          key,
          InstrumentMetadata.fromJson(value as Map<String, dynamic>),
        );
      });

      return (_isInitialized = true);
    });

    return _initializingFuture;
  }
}
