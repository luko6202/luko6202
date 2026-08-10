import 'package:axolotl_care/domain/water_assessment.dart';
import 'package:axolotl_care/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WaterAssessment', () {
    test('marks ideal values as good', () {
      final result = WaterAssessment.assess(
        temperatureC: 16,
        phValue: 7.5,
        ammoniaMgL: 0,
        nitriteMgL: 0,
        nitrateMgL: 10,
      );
      expect(result.overall, WaterStatus.good);
    });

    test('marks ammonia above zero as critical', () {
      final result = WaterAssessment.assess(ammoniaMgL: 0.5);
      expect(result.overall, WaterStatus.critical);
      expect(result.parameters.single.status, WaterStatus.critical);
    });

    test('marks elevated nitrate as warn then critical', () {
      expect(
        WaterAssessment.assess(nitrateMgL: 30).overall,
        WaterStatus.warn,
      );
      expect(
        WaterAssessment.assess(nitrateMgL: 50).overall,
        WaterStatus.critical,
      );
    });

    test('marks hot temperature as critical', () {
      final result = WaterAssessment.assess(temperatureC: 24);
      expect(result.overall, WaterStatus.critical);
    });
  });
}
