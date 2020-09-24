import 'package:flutter_test/flutter_test.dart';
import 'package:matex_dart/matex_dart.dart';

import '../samples/config.dart';

void main() {
  group('PipValueCalculator', () {
    Matex matex;

    setUp(() {
      matex = Matex(config: testMatexConfig);
    });

    group('#pipValue()', () {
      MatexPipValueCalculator pipValue;

      setUp(() {
        pipValue = matex.pipValue();
      });

      test('should return a MatexPipValueCalcultor instance', () {
        expect(pipValue is MatexPipValueCalculator, equals(true));
      });
    });
  });
}
