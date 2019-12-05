import 'package:matex_dart/src/providers/models/instument_metadata.model.dart';

abstract class AbstractInstrumentProvider {
  Future<InstrumentMetadata> metadata(String code);
}
