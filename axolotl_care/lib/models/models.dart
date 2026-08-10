enum WaterStatus { good, warn, critical }

enum CareActionType {
  waterChange,
  filterClean,
  substrateClean,
  temperatureCheck,
  observation,
  other,
}

class SourceRef {
  const SourceRef({
    required this.title,
    required this.url,
    this.note,
  });

  final String title;
  final String url;
  final String? note;
}

class KnowledgeArticle {
  const KnowledgeArticle({
    required this.id,
    required this.category,
    required this.title,
    required this.summary,
    required this.sections,
    required this.sources,
  });

  final String id;
  final String category;
  final String title;
  final String summary;
  final List<ArticleSection> sections;
  final List<SourceRef> sources;
}

class ArticleSection {
  const ArticleSection({
    required this.heading,
    required this.body,
  });

  final String heading;
  final String body;
}

class Aquarium {
  Aquarium({
    required this.id,
    required this.name,
    required this.volumeLiters,
    this.notes = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String id;
  String name;
  double volumeLiters;
  String notes;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'volumeLiters': volumeLiters,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Aquarium.fromJson(Map<String, dynamic> json) => Aquarium(
        id: json['id'] as String,
        name: json['name'] as String,
        volumeLiters: (json['volumeLiters'] as num).toDouble(),
        notes: json['notes'] as String? ?? '',
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}

class WaterReading {
  WaterReading({
    required this.id,
    required this.aquariumId,
    required this.recordedAt,
    this.temperatureC,
    this.ph,
    this.ammoniaMgL,
    this.nitriteMgL,
    this.nitrateMgL,
    this.ghDgh,
    this.khDkh,
    this.note = '',
    this.overallStatus = WaterStatus.good,
  });

  final String id;
  final String aquariumId;
  final DateTime recordedAt;
  final double? temperatureC;
  final double? ph;
  final double? ammoniaMgL;
  final double? nitriteMgL;
  final double? nitrateMgL;
  final double? ghDgh;
  final double? khDkh;
  final String note;
  final WaterStatus overallStatus;

  Map<String, dynamic> toJson() => {
        'id': id,
        'aquariumId': aquariumId,
        'recordedAt': recordedAt.toIso8601String(),
        'temperatureC': temperatureC,
        'ph': ph,
        'ammoniaMgL': ammoniaMgL,
        'nitriteMgL': nitriteMgL,
        'nitrateMgL': nitrateMgL,
        'ghDgh': ghDgh,
        'khDkh': khDkh,
        'note': note,
        'overallStatus': overallStatus.name,
      };

  factory WaterReading.fromJson(Map<String, dynamic> json) => WaterReading(
        id: json['id'] as String,
        aquariumId: json['aquariumId'] as String,
        recordedAt: DateTime.parse(json['recordedAt'] as String),
        temperatureC: (json['temperatureC'] as num?)?.toDouble(),
        ph: (json['ph'] as num?)?.toDouble(),
        ammoniaMgL: (json['ammoniaMgL'] as num?)?.toDouble(),
        nitriteMgL: (json['nitriteMgL'] as num?)?.toDouble(),
        nitrateMgL: (json['nitrateMgL'] as num?)?.toDouble(),
        ghDgh: (json['ghDgh'] as num?)?.toDouble(),
        khDkh: (json['khDkh'] as num?)?.toDouble(),
        note: json['note'] as String? ?? '',
        overallStatus: WaterStatus.values.firstWhere(
          (e) => e.name == json['overallStatus'],
          orElse: () => WaterStatus.good,
        ),
      );
}

class CareLogEntry {
  CareLogEntry({
    required this.id,
    required this.aquariumId,
    required this.type,
    required this.performedAt,
    this.note = '',
  });

  final String id;
  final String aquariumId;
  final CareActionType type;
  final DateTime performedAt;
  final String note;

  Map<String, dynamic> toJson() => {
        'id': id,
        'aquariumId': aquariumId,
        'type': type.name,
        'performedAt': performedAt.toIso8601String(),
        'note': note,
      };

  factory CareLogEntry.fromJson(Map<String, dynamic> json) => CareLogEntry(
        id: json['id'] as String,
        aquariumId: json['aquariumId'] as String,
        type: CareActionType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => CareActionType.other,
        ),
        performedAt: DateTime.parse(json['performedAt'] as String),
        note: json['note'] as String? ?? '',
      );
}

extension CareActionTypeLabel on CareActionType {
  String get labelDe => switch (this) {
        CareActionType.waterChange => 'Wasserwechsel',
        CareActionType.filterClean => 'Filterpflege',
        CareActionType.substrateClean => 'Bodengrund reinigen',
        CareActionType.temperatureCheck => 'Temperaturkontrolle',
        CareActionType.observation => 'Beobachtung',
        CareActionType.other => 'Sonstiges',
      };
}

extension WaterStatusLabel on WaterStatus {
  String get labelDe => switch (this) {
        WaterStatus.good => 'Gut',
        WaterStatus.warn => 'Beachten',
        WaterStatus.critical => 'Kritisch',
      };
}
