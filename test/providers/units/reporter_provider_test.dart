import 'package:flutter_test/flutter_test.dart';

import 'package:matex_dart/matex_dart.dart';

void main() {
  group('ReporterProvider', () {
    MatexReporterProvider reporter;

    setUp(() {
      reporter = MatexReporterProvider();
    });

    group('report()', () {
      test('should report a reportState to a string', () {
        expect(
          reporter.report(entries: [
            MatexReportEntry(
              label: 'Pip Value:',
              value: 1.45252,
              minimumFractionDigits: 5,
            ),
            MatexReportEntry(
              label: 'Position Size:',
              value: 100000,
              minimumFractionDigits: 0,
              maximumFractionDigits: 2,
            ),
          ]),
          completion(equals(('Pip Value: 1.45252\nPosition Size: 100,000'))),
        );

        expect(
          reporter.report(
            entries: [
              MatexReportEntry(
                label: 'Pip Value:',
                value: 1.45252,
                minimumFractionDigits: 5,
              ),
            ],
          ),
          completion(equals(('Pip Value: 1.45252'))),
        );
      });
    });
  });
}
