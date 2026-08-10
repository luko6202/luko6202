import '../models/models.dart';

/// Reference ranges compiled for Ambystoma mexicanum husbandry.
/// See knowledge article "wasserwerte" for cited sources.
class WaterParameterRange {
  const WaterParameterRange({
    required this.id,
    required this.labelDe,
    required this.unit,
    required this.optimalMin,
    required this.optimalMax,
    required this.warnMin,
    required this.warnMax,
    this.zeroIsIdeal = false,
    this.higherIsWorse = false,
  });

  final String id;
  final String labelDe;
  final String unit;
  final double optimalMin;
  final double optimalMax;
  final double warnMin;
  final double warnMax;
  final bool zeroIsIdeal;
  final bool higherIsWorse;
}

class ParameterAssessment {
  const ParameterAssessment({
    required this.parameterId,
    required this.labelDe,
    required this.value,
    required this.unit,
    required this.status,
    required this.guidanceDe,
  });

  final String parameterId;
  final String labelDe;
  final double value;
  final String unit;
  final WaterStatus status;
  final String guidanceDe;
}

class WaterAssessmentResult {
  const WaterAssessmentResult({
    required this.overall,
    required this.parameters,
    required this.summaryDe,
  });

  final WaterStatus overall;
  final List<ParameterAssessment> parameters;
  final String summaryDe;
}

class WaterAssessment {
  static const temperature = WaterParameterRange(
    id: 'temperature',
    labelDe: 'Temperatur',
    unit: '°C',
    optimalMin: 14,
    optimalMax: 18,
    warnMin: 12,
    warnMax: 20,
  );

  static const ph = WaterParameterRange(
    id: 'ph',
    labelDe: 'pH',
    unit: '',
    optimalMin: 7.4,
    optimalMax: 7.6,
    warnMin: 6.5,
    warnMax: 8.0,
  );

  static const ammonia = WaterParameterRange(
    id: 'ammonia',
    labelDe: 'Ammoniak / Ammonium',
    unit: 'mg/l',
    optimalMin: 0,
    optimalMax: 0,
    warnMin: 0,
    warnMax: 0.25,
    zeroIsIdeal: true,
    higherIsWorse: true,
  );

  static const nitrite = WaterParameterRange(
    id: 'nitrite',
    labelDe: 'Nitrit (NO₂⁻)',
    unit: 'mg/l',
    optimalMin: 0,
    optimalMax: 0,
    warnMin: 0,
    warnMax: 0.1,
    zeroIsIdeal: true,
    higherIsWorse: true,
  );

  static const nitrate = WaterParameterRange(
    id: 'nitrate',
    labelDe: 'Nitrat (NO₃⁻)',
    unit: 'mg/l',
    optimalMin: 0,
    optimalMax: 20,
    warnMin: 0,
    warnMax: 40,
    higherIsWorse: true,
  );

  static const gh = WaterParameterRange(
    id: 'gh',
    labelDe: 'Gesamthärte (GH)',
    unit: '°dGH',
    optimalMin: 7,
    optimalMax: 14,
    warnMin: 4,
    warnMax: 18,
  );

  static const kh = WaterParameterRange(
    id: 'kh',
    labelDe: 'Karbonathärte (KH)',
    unit: '°dKH',
    optimalMin: 3,
    optimalMax: 8,
    warnMin: 2,
    warnMax: 12,
  );

  static const ranges = <WaterParameterRange>[
    temperature,
    ph,
    ammonia,
    nitrite,
    nitrate,
    gh,
    kh,
  ];

  static WaterStatus statusFor(WaterParameterRange range, double value) {
    if (range.zeroIsIdeal || range.higherIsWorse) {
      if (value <= range.optimalMax) return WaterStatus.good;
      if (value <= range.warnMax) return WaterStatus.warn;
      return WaterStatus.critical;
    }

    if (value >= range.optimalMin && value <= range.optimalMax) {
      return WaterStatus.good;
    }
    if (value >= range.warnMin && value <= range.warnMax) {
      return WaterStatus.warn;
    }
    return WaterStatus.critical;
  }

  static String guidanceFor(WaterParameterRange range, WaterStatus status) {
    if (status == WaterStatus.good) {
      return 'Im Zielbereich.';
    }

    return switch (range.id) {
      'temperature' when status == WaterStatus.warn =>
        'Temperatur beobachten. Ziel: 14–18 °C. Standort kühler wählen oder kurzfristig vorsichtig kühlen.',
      'temperature' =>
        'Kritische Temperatur. Über 24 °C starker Hitzestress. Sofort kühlen; bei Unterkühlung langsam anheben.',
      'ph' when status == WaterStatus.warn =>
        'pH außerhalb des Idealbereichs (7,4–7,6). Langsam korrigieren, nie abrupt.',
      'ph' =>
        'pH kritisch. Extreme Werte belasten Haut und Kiemen; Ammoniaktoxizität steigt mit höherem pH.',
      'ammonia' =>
        'Ammoniak muss 0 mg/l sein. Sofort Teilwasserwechsel mit aufbereitetem Wasser; Filterzyklus prüfen.',
      'nitrite' =>
        'Nitrit muss 0 mg/l sein. Wasserwechsel und Biofilter prüfen; Becken ggf. nicht voll besetzt lassen.',
      'nitrate' when status == WaterStatus.warn =>
        'Nitrat erhöht. Häufigere oder größere Teilwasserwechsel; Fütterung und Bestand prüfen.',
      'nitrate' =>
        'Nitrat kritisch. Größerer Wasserwechsel und Ursachen (Überbesatz, Überfütterung) beheben.',
      'gh' =>
        'Härte außerhalb des empfohlenen Bereichs. Extrem weiches Wasser kann Probleme begünstigen.',
      'kh' =>
        'KH außerhalb des empfohlenen Bereichs. Zu niedrige KH erhöht Risiko für pH-Schwankungen.',
      _ => 'Wert prüfen und Haltung entsprechend anpassen.',
    };
  }

  static WaterAssessmentResult assess({
    double? temperatureC,
    double? phValue,
    double? ammoniaMgL,
    double? nitriteMgL,
    double? nitrateMgL,
    double? ghDgh,
    double? khDkh,
  }) {
    final values = <WaterParameterRange, double?>{
      temperature: temperatureC,
      ph: phValue,
      ammonia: ammoniaMgL,
      nitrite: nitriteMgL,
      nitrate: nitrateMgL,
      gh: ghDgh,
      kh: khDkh,
    };

    final assessments = <ParameterAssessment>[];
    for (final entry in values.entries) {
      final value = entry.value;
      if (value == null) continue;
      final status = statusFor(entry.key, value);
      assessments.add(
        ParameterAssessment(
          parameterId: entry.key.id,
          labelDe: entry.key.labelDe,
          value: value,
          unit: entry.key.unit,
          status: status,
          guidanceDe: guidanceFor(entry.key, status),
        ),
      );
    }

    final overall = assessments.isEmpty
        ? WaterStatus.good
        : assessments.map((a) => a.status).reduce(_worse);

    final summary = switch (overall) {
      WaterStatus.good =>
        'Die erfassten Werte liegen im akzeptablen bis optimalen Bereich.',
      WaterStatus.warn =>
        'Mindestens ein Wert verdient Aufmerksamkeit. Ursache prüfen und nachmessen.',
      WaterStatus.critical =>
        'Mindestens ein kritischer Wert. Handeln (meist Teilwasserwechsel) und Ursachen beheben.',
    };

    return WaterAssessmentResult(
      overall: overall,
      parameters: assessments,
      summaryDe: summary,
    );
  }

  static WaterStatus _worse(WaterStatus a, WaterStatus b) {
    const order = {
      WaterStatus.good: 0,
      WaterStatus.warn: 1,
      WaterStatus.critical: 2,
    };
    return order[a]! >= order[b]! ? a : b;
  }
}
