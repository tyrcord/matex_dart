import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../../core/shared/messages.dart';
import '../samples/config.dart';

void main() {
  group('PipValueCalculator', () {
    late MatexPipValueCalculator pipValue;
    late MatexApp matex;

    setUp(() {
      matex = MatexApp(config: testMatexConfig);
      pipValue = matex.pipValue();
    });

    group('#pipValue()', () {
      test(SHOULD_RETURN_REFERENCE_CALCULATOR, () {
        // ignore: unnecessary_type_check
        expect(pipValue is MatexPipValueCalculator, isTrue);
      });
    });
  });
}
