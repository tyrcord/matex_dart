import 'package:meta/meta.dart';

import '../models/models.dart';

abstract class AbstractReporterProvider {
  Stream<String> report({
    @required String locale,
    @required Map<String, ReportEntry> reportState,
  });
}
