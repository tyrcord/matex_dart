import 'dart:async';
import 'dart:convert' show jsonDecode;
import 'dart:io' show File;

import 'interfaces/interfaces.dart';

const _kInstrumentsPath = './meta/instruments.json';

class InstrumentProvider implements AbstractInstrumentProvider {
  bool _isInitialized = false;
  Map _instrumentsMetadata;

  static final InstrumentProvider _singleton = InstrumentProvider._();

  factory InstrumentProvider() {
    return _singleton;
  }

  InstrumentProvider._();

  Stream<dynamic> metadata(String code) async* {
    if (!_isInitialized) {
      await _init();
    }

    yield _instrumentsMetadata[code];
  }

  Future<bool> _init() async {
    _instrumentsMetadata = jsonDecode(
      await File(_kInstrumentsPath).readAsString(),
    ) as Map;

    return (_isInitialized = true);
  }
}
