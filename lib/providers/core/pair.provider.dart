import 'dart:async';
import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart';

import '../interfaces/interfaces.dart';
import '../models/models.dart';

const _kAssetPath = 'packages/matex_dart/assets/meta/pairs.json';

class PairMetadataProvider extends AbstractPairMetadataProvider {
  static final PairMetadataProvider _singleton = PairMetadataProvider._();

  factory PairMetadataProvider() => _singleton;

  PairMetadataProvider._();

  @override
  Future<Map<String, PairMetadata>> init() async {
    final json = await rootBundle.loadString(_kAssetPath);
    final pairs = jsonDecode(json) as Map<String, dynamic>;

    _removeExtraMetadata(pairs);

    return pairs.map<String, PairMetadata>((key, value) {
      return MapEntry(
        key,
        PairMetadata.fromJson(value as Map<String, dynamic>),
      );
    });
  }

  void _removeExtraMetadata(Map<String, dynamic> metadata) {
    metadata.removeWhere((String key, dynamic json) {
      final shouldRemoveExtraMetadata = key == 'pair_types';

      if (shouldRemoveExtraMetadata) {
        _extractExtraMetadata(key, json as Map<String, dynamic>);
      }

      return shouldRemoveExtraMetadata;
    });
  }

  void _extractExtraMetadata(String key, Map<String, dynamic> json) {
    if (key == 'pair_types') {
      json.forEach((String key, dynamic value) {
        PairTypeMetadata.addToCache(
          key,
          value as Map<String, dynamic>,
        );
      });
    }
  }
}
