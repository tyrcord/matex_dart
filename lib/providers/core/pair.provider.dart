import 'dart:async';
import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart';

import '../interfaces/interfaces.dart';
import '../models/models.dart';

const _kAssetPath = 'packages/matex_dart/assets/meta/pairs.json';

const _kPairKeyMetadata = {
  'default_pip': 'default_pip',
  'pair_types': 'pair_types',
  'default_forex_lots': 'default_forex_lots',
  'lot_units': 'lot_units',
};

class MatexPairMetadataProvider extends MatexAbstractPairMetadataProvider {
  static final MatexPairMetadataProvider _singleton =
      MatexPairMetadataProvider._();

  factory MatexPairMetadataProvider() => _singleton;

  MatexPairMetadataProvider._();

  @override
  Future<Map<String, MatexPairMetadata>> init() async {
    final json = await rootBundle.loadString(_kAssetPath);
    final pairs = jsonDecode(json) as Map<String, dynamic>;

    _removeExtraMetadata(pairs);

    return pairs.map<String, MatexPairMetadata>((key, value) {
      return MapEntry(
        key,
        MatexPairMetadata.fromJson(value as Map<String, dynamic>),
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
    return _kPairKeyMetadata.containsKey(key);
  }

  void _extractExtraMetadata(String key, Map<String, dynamic> json) {
    if (key == _kPairKeyMetadata['pair_types']) {
      json.forEach((String key, dynamic value) {
        MatexPairTypeMetadata.addToCache(
          key,
          value as Map<String, dynamic>,
        );
      });
    }
  }
}
