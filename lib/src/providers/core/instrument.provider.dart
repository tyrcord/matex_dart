import 'dart:async';
import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart';

import '../interfaces/interfaces.dart';
import '../models/models.dart';

const _kInstrumentsPath = 'packages/matex_dart/assets/meta/instruments.json';

class InstrumentProvider implements AbstractInstrumentProvider {
  Map<String, InstrumentMetadata> _instrumentsMetadata;
  Future<Map<String, InstrumentMetadata>> instrumentsMetadataFuture;
  bool _isInitialized = false;

  static final InstrumentProvider _singleton = InstrumentProvider._();

  factory InstrumentProvider() => _singleton;

  InstrumentProvider._();

  Future<Map<String, InstrumentMetadata>> initIfNeeded() async {
    if (!_isInitialized) {
      await _init();
    }

    return instrumentsMetadataFuture;
  }

  @override
  Future<InstrumentMetadata> metadata(String code) async {
    await initIfNeeded();
    return _instrumentsMetadata[code];
  }

  Future<Map<String, InstrumentMetadata>> _init() async {
    instrumentsMetadataFuture ??=
        rootBundle.loadString(_kInstrumentsPath).then((String json) {
      final instruments = jsonDecode(json) as Map<String, dynamic>;

      instruments.removeWhere((String key, dynamic value) {
        return key == 'lot_units';
      });

      _instrumentsMetadata =
          instruments.map<String, InstrumentMetadata>((key, value) {
        return MapEntry(
          key,
          InstrumentMetadata.fromJson(value as Map<String, dynamic>),
        );
      });

      _isInitialized = true;

      return _instrumentsMetadata;
    });

    return instrumentsMetadataFuture;
  }
}
