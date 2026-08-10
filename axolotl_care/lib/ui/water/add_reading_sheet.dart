import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/app_repository.dart';
import '../../domain/water_assessment.dart';
import '../../theme/app_theme.dart';
import '../widgets/status_chip.dart';

Future<void> showAddReadingSheet(BuildContext context, String aquariumId) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: AddReadingSheet(aquariumId: aquariumId),
    ),
  );
}

class AddReadingSheet extends StatefulWidget {
  const AddReadingSheet({super.key, required this.aquariumId});

  final String aquariumId;

  @override
  State<AddReadingSheet> createState() => _AddReadingSheetState();
}

class _AddReadingSheetState extends State<AddReadingSheet> {
  final _temp = TextEditingController();
  final _ph = TextEditingController();
  final _ammonia = TextEditingController();
  final _nitrite = TextEditingController();
  final _nitrate = TextEditingController();
  final _gh = TextEditingController();
  final _kh = TextEditingController();
  final _note = TextEditingController();

  double? _parse(TextEditingController c) {
    final raw = c.text.trim().replaceAll(',', '.');
    if (raw.isEmpty) return null;
    return double.tryParse(raw);
  }

  @override
  void dispose() {
    _temp.dispose();
    _ph.dispose();
    _ammonia.dispose();
    _nitrite.dispose();
    _nitrate.dispose();
    _gh.dispose();
    _kh.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preview = WaterAssessment.assess(
      temperatureC: _parse(_temp),
      phValue: _parse(_ph),
      ammoniaMgL: _parse(_ammonia),
      nitriteMgL: _parse(_nitrite),
      nitrateMgL: _parse(_nitrate),
      ghDgh: _parse(_gh),
      khDkh: _parse(_kh),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Neue Messung', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(
            'Leere Felder werden ignoriert. Mindestens einen Wert eintragen.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.reed,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _numField(_temp, 'Temperatur °C', onChanged: (_) => setState(() {})),
              _numField(_ph, 'pH', onChanged: (_) => setState(() {})),
              _numField(_ammonia, 'Ammoniak mg/l', onChanged: (_) => setState(() {})),
              _numField(_nitrite, 'Nitrit mg/l', onChanged: (_) => setState(() {})),
              _numField(_nitrate, 'Nitrat mg/l', onChanged: (_) => setState(() {})),
              _numField(_gh, 'GH °dH', onChanged: (_) => setState(() {})),
              _numField(_kh, 'KH °dH', onChanged: (_) => setState(() {})),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _note,
            decoration: const InputDecoration(labelText: 'Notiz (optional)'),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Live-Einordnung', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(width: 10),
              if (preview.parameters.isNotEmpty) StatusChip(status: preview.overall),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            preview.parameters.isEmpty
                ? 'Noch keine Werte zur Bewertung.'
                : preview.summaryDe,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.reed,
                ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                final values = [
                  _parse(_temp),
                  _parse(_ph),
                  _parse(_ammonia),
                  _parse(_nitrite),
                  _parse(_nitrate),
                  _parse(_gh),
                  _parse(_kh),
                ];
                if (values.every((v) => v == null)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Bitte mindestens einen Wert eintragen.')),
                  );
                  return;
                }
                if (values.any((v) => v != null) &&
                    [
                      _temp,
                      _ph,
                      _ammonia,
                      _nitrite,
                      _nitrate,
                      _gh,
                      _kh,
                    ].any((c) => c.text.trim().isNotEmpty && _parse(c) == null)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ungültige Zahl erkannt.')),
                  );
                  return;
                }

                await context.read<AppRepository>().addReading(
                      aquariumId: widget.aquariumId,
                      temperatureC: _parse(_temp),
                      ph: _parse(_ph),
                      ammoniaMgL: _parse(_ammonia),
                      nitriteMgL: _parse(_nitrite),
                      nitrateMgL: _parse(_nitrate),
                      ghDgh: _parse(_gh),
                      khDkh: _parse(_kh),
                      note: _note.text,
                    );
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _numField(
    TextEditingController controller,
    String label, {
    required ValueChanged<String> onChanged,
  }) {
    return SizedBox(
      width: 160,
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label),
        onChanged: onChanged,
      ),
    );
  }
}
