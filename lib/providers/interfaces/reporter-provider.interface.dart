import 'package:meta/meta.dart';

import '../models/models.dart';

abstract class MatexAbstractReporterProvider {
  Future<String> report({
    @required String locale,
    @required Map<String, MatexReportEntry> reportState,
  });
}
