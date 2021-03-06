import 'dart:async';
import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart';

import '../interfaces/interfaces.dart';
import '../models/models.dart';

const _kAssetPath = 'packages/matex_dart/assets/meta/instruments.json';

const _kInstrumentKeyMetadata = {
  'instrument_types': 'instrument_types',
};

class MatexInstrumentProvider extends MatexAbstractInstrumentMetadataProvider {
  static final MatexInstrumentProvider _singleton = MatexInstrumentProvider._();

  factory MatexInstrumentProvider() => _singleton;

  MatexInstrumentProvider._();

  @override
  Future<Map<String, MatexInstrumentMetadata>> init() async {
    final json = await rootBundle.loadString(_kAssetPath);
    final instruments = jsonDecode(json) as Map<String, dynamic>;

    _removeExtraMetadata(instruments);

    return instruments.map<String, MatexInstrumentMetadata>((key, json) {
      return MapEntry(
        key,
        MatexInstrumentMetadata.fromJson(json as Map<String, dynamic>),
      );
    });
  }

  void _removeExtraMetadata(Map<String, dynamic> metadata) {
    metadata.removeWhere((String key, dynamic json) {
      final shouldRemoveExtraMetadata = _shouldRemoveExtraMetadata(key);

      if (shouldRemoveExtraMetadata) {
        _extractExtraMetadata(key, json as Map<String, dynamic>);
      }

      return shouldRemoveExtraMetadata;
    });
  }

  bool _shouldRemoveExtraMetadata(String key) {
    return _kInstrumentKeyMetadata.containsKey(key);
  }

  void _extractExtraMetadata(String key, Map<String, dynamic> json) {
    if (key == 'instrument_types') {
      json.forEach((String key, dynamic value) {
        MatexInstrumentTypeMetadata.addToCache(
          key,
          value as Map<String, dynamic>,
        );
      });
    }
  }
}
