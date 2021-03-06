import 'package:flutter/material.dart';

abstract class MatexAbstractMetadataProvider<T> {
  @protected
  bool isInitialized = false;
  @protected
  late Map<String, T> metadataMap;

  Future<Map<String, T>>? _metadataFuture;

  Future<Map<String, T>>? list() => initIfNeeded();

  @protected
  Future<Map<String, T>>? initIfNeeded() async {
    if (!isInitialized) {
      _metadataFuture = init().then((Map<String, T> map) {
        metadataMap = map;
        isInitialized = true;

        return map;
      });
    }

    return _metadataFuture!;
  }

  @protected
  Future<Map<String, T>> init();

  Future<T?> metadata(String key) async {
    await initIfNeeded();

    return metadataMap[key];
  }
}
