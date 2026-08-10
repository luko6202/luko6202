import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../domain/water_assessment.dart';
import '../../models/models.dart';

class AppRepository extends ChangeNotifier {
  AppRepository(this._prefs);

  final SharedPreferences _prefs;
  final _uuid = const Uuid();

  static const _aquariumsKey = 'aquariums';
  static const _readingsKey = 'readings';
  static const _careKey = 'care_logs';
  static const _axolotlsKey = 'axolotls';
  static const _selectedKey = 'selected_aquarium_id';

  List<Aquarium> aquariums = [];
  List<WaterReading> readings = [];
  List<CareLogEntry> careLogs = [];
  List<AxolotlProfile> axolotls = [];
  String? selectedAquariumId;

  static Future<AppRepository> create() async {
    final prefs = await SharedPreferences.getInstance();
    final repo = AppRepository(prefs);
    repo.load();
    return repo;
  }

  void load() {
    aquariums = _decodeList(_prefs.getString(_aquariumsKey), Aquarium.fromJson);
    readings =
        _decodeList(_prefs.getString(_readingsKey), WaterReading.fromJson);
    careLogs = _decodeList(_prefs.getString(_careKey), CareLogEntry.fromJson);
    axolotls =
        _decodeList(_prefs.getString(_axolotlsKey), AxolotlProfile.fromJson);
    selectedAquariumId = _prefs.getString(_selectedKey);

    if (aquariums.isNotEmpty &&
        (selectedAquariumId == null ||
            !aquariums.any((a) => a.id == selectedAquariumId))) {
      selectedAquariumId = aquariums.first.id;
    }
    notifyListeners();
  }

  Aquarium? get selectedAquarium {
    final id = selectedAquariumId;
    if (id == null) return null;
    for (final aquarium in aquariums) {
      if (aquarium.id == id) return aquarium;
    }
    return null;
  }

  List<WaterReading> readingsFor(String aquariumId) {
    final list = readings
        .where((r) => r.aquariumId == aquariumId)
        .toList(growable: false);
    return list.reversed.toList(growable: false);
  }

  List<CareLogEntry> careFor(String aquariumId) {
    final list = careLogs
        .where((c) => c.aquariumId == aquariumId)
        .toList(growable: false);
    return list.reversed.toList(growable: false);
  }

  List<AxolotlProfile> axolotlsFor(String aquariumId) {
    return axolotls
        .where((a) => a.aquariumId == aquariumId)
        .toList(growable: false);
  }

  WaterReading? latestReading(String aquariumId) {
    final list = readingsFor(aquariumId);
    return list.isEmpty ? null : list.first;
  }

  Future<void> selectAquarium(String id) async {
    selectedAquariumId = id;
    await _prefs.setString(_selectedKey, id);
    notifyListeners();
  }

  Future<Aquarium> addAquarium({
    required String name,
    required double volumeLiters,
    String notes = '',
  }) async {
    final aquarium = Aquarium(
      id: _uuid.v4(),
      name: name.trim(),
      volumeLiters: volumeLiters,
      notes: notes.trim(),
    );
    aquariums = [...aquariums, aquarium];
    selectedAquariumId ??= aquarium.id;
    await _persistAquariums();
    await _prefs.setString(_selectedKey, selectedAquariumId!);
    notifyListeners();
    return aquarium;
  }

  Future<void> updateAquarium(Aquarium aquarium) async {
    aquariums = [
      for (final item in aquariums)
        if (item.id == aquarium.id) aquarium else item,
    ];
    await _persistAquariums();
    notifyListeners();
  }

  Future<void> deleteAquarium(String id) async {
    aquariums = aquariums.where((a) => a.id != id).toList(growable: false);
    readings =
        readings.where((r) => r.aquariumId != id).toList(growable: false);
    careLogs =
        careLogs.where((c) => c.aquariumId != id).toList(growable: false);
    axolotls =
        axolotls.where((a) => a.aquariumId != id).toList(growable: false);
    if (selectedAquariumId == id) {
      selectedAquariumId = aquariums.isEmpty ? null : aquariums.first.id;
      if (selectedAquariumId == null) {
        await _prefs.remove(_selectedKey);
      } else {
        await _prefs.setString(_selectedKey, selectedAquariumId!);
      }
    }
    await _persistAll();
    notifyListeners();
  }

  Future<WaterReading> addReading({
    required String aquariumId,
    DateTime? recordedAt,
    double? temperatureC,
    double? ph,
    double? ammoniaMgL,
    double? nitriteMgL,
    double? nitrateMgL,
    double? ghDgh,
    double? khDkh,
    String note = '',
  }) async {
    final assessment = WaterAssessment.assess(
      temperatureC: temperatureC,
      phValue: ph,
      ammoniaMgL: ammoniaMgL,
      nitriteMgL: nitriteMgL,
      nitrateMgL: nitrateMgL,
      ghDgh: ghDgh,
      khDkh: khDkh,
    );

    final reading = WaterReading(
      id: _uuid.v4(),
      aquariumId: aquariumId,
      recordedAt: recordedAt ?? DateTime.now(),
      temperatureC: temperatureC,
      ph: ph,
      ammoniaMgL: ammoniaMgL,
      nitriteMgL: nitriteMgL,
      nitrateMgL: nitrateMgL,
      ghDgh: ghDgh,
      khDkh: khDkh,
      note: note.trim(),
      overallStatus: assessment.overall,
    );

    readings = [...readings, reading];
    await _persistReadings();
    notifyListeners();
    return reading;
  }

  Future<void> deleteReading(String id) async {
    readings = readings.where((r) => r.id != id).toList(growable: false);
    await _persistReadings();
    notifyListeners();
  }

  Future<CareLogEntry> addCareLog({
    required String aquariumId,
    required CareActionType type,
    DateTime? performedAt,
    String note = '',
  }) async {
    final entry = CareLogEntry(
      id: _uuid.v4(),
      aquariumId: aquariumId,
      type: type,
      performedAt: performedAt ?? DateTime.now(),
      note: note.trim(),
    );
    careLogs = [...careLogs, entry];
    await _persistCare();
    notifyListeners();
    return entry;
  }

  Future<void> deleteCareLog(String id) async {
    careLogs = careLogs.where((c) => c.id != id).toList(growable: false);
    await _persistCare();
    notifyListeners();
  }

  Future<AxolotlProfile> addAxolotl({
    required String aquariumId,
    required String name,
    required String morphId,
    bool hasGfp = false,
    String notes = '',
  }) async {
    final profile = AxolotlProfile(
      id: _uuid.v4(),
      aquariumId: aquariumId,
      name: name.trim(),
      morphId: morphId,
      hasGfp: hasGfp,
      notes: notes.trim(),
    );
    axolotls = [...axolotls, profile];
    await _persistAxolotls();
    notifyListeners();
    return profile;
  }

  Future<void> updateAxolotl(AxolotlProfile profile) async {
    axolotls = [
      for (final item in axolotls)
        if (item.id == profile.id) profile else item,
    ];
    await _persistAxolotls();
    notifyListeners();
  }

  Future<void> deleteAxolotl(String id) async {
    axolotls = axolotls.where((a) => a.id != id).toList(growable: false);
    await _persistAxolotls();
    notifyListeners();
  }

  Future<void> _persistAquariums() async {
    await _prefs.setString(
      _aquariumsKey,
      jsonEncode(aquariums.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> _persistReadings() async {
    await _prefs.setString(
      _readingsKey,
      jsonEncode(readings.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> _persistCare() async {
    await _prefs.setString(
      _careKey,
      jsonEncode(careLogs.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> _persistAxolotls() async {
    await _prefs.setString(
      _axolotlsKey,
      jsonEncode(axolotls.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> _persistAll() async {
    await Future.wait([
      _persistAquariums(),
      _persistReadings(),
      _persistCare(),
      _persistAxolotls(),
    ]);
  }

  List<T> _decodeList<T>(
    String? raw,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}
