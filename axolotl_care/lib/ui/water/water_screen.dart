import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/app_repository.dart';
import '../../domain/water_assessment.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../widgets/status_chip.dart';
import 'add_reading_sheet.dart';

class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AppRepository>();
    final aquarium = repo.selectedAquarium;

    if (aquarium == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Lege zuerst unter „Becken“ ein Aquarium an.'),
        ),
      );
    }

    final readings = repo.readingsFor(aquarium.id);
    final latest = readings.isEmpty ? null : readings.first;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Wasserwerte',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            FilledButton.icon(
              onPressed: () => showAddReadingSheet(context, aquarium.id),
              icon: const Icon(Icons.add),
              label: const Text('Eintragen'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          aquarium.name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.reed,
              ),
        ),
        const SizedBox(height: 18),
        if (latest == null)
          Text(
            'Noch keine Messung. Trage Temperatur, pH und Stickstoffwerte ein – '
            'AxolotlCare ordnet sie anhand der Referenzbereiche ein.',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else ...[
          _LatestAssessment(reading: latest),
          const SizedBox(height: 22),
          Text('Verlauf', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          for (final reading in readings) ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                DateFormat('dd.MM.yyyy HH:mm').format(reading.recordedAt),
              ),
              subtitle: Text(_readingSubtitle(reading)),
              trailing: StatusChip(status: reading.overallStatus),
              onLongPress: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Messung löschen?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Abbrechen'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Löschen'),
                      ),
                    ],
                  ),
                );
                if (ok == true) {
                  await repo.deleteReading(reading.id);
                }
              },
            ),
            const Divider(height: 1),
          ],
        ],
        const SizedBox(height: 20),
        Text(
          'Referenz: Ammoniak/Nitrit 0 · Nitrat möglichst ≤20 mg/l · Temp. 14–18 °C · pH ideal 7,4–7,6. '
          'Details und Quellen im Wissensartikel „Wasserwerte“.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.reed),
        ),
      ],
    );
  }

  String _readingSubtitle(WaterReading reading) {
    final parts = <String>[];
    if (reading.temperatureC != null) {
      parts.add('${reading.temperatureC!.toStringAsFixed(1)} °C');
    }
    if (reading.ph != null) parts.add('pH ${reading.ph!.toStringAsFixed(1)}');
    if (reading.ammoniaMgL != null) {
      parts.add('NH₃ ${reading.ammoniaMgL!.toStringAsFixed(2)}');
    }
    if (reading.nitriteMgL != null) {
      parts.add('NO₂ ${reading.nitriteMgL!.toStringAsFixed(2)}');
    }
    if (reading.nitrateMgL != null) {
      parts.add('NO₃ ${reading.nitrateMgL!.toStringAsFixed(0)}');
    }
    return parts.isEmpty ? 'Keine Parameter' : parts.join(' · ');
  }
}

class _LatestAssessment extends StatelessWidget {
  const _LatestAssessment({required this.reading});

  final WaterReading reading;

  @override
  Widget build(BuildContext context) {
    final result = WaterAssessment.assess(
      temperatureC: reading.temperatureC,
      phValue: reading.ph,
      ammoniaMgL: reading.ammoniaMgL,
      nitriteMgL: reading.nitriteMgL,
      nitrateMgL: reading.nitrateMgL,
      ghDgh: reading.ghDgh,
      khDkh: reading.khDkh,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lagoon.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Aktuelle Einordnung', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              StatusChip(status: result.overall),
            ],
          ),
          const SizedBox(height: 8),
          Text(result.summaryDe),
          const SizedBox(height: 14),
          for (final param in result.parameters) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 140,
                  child: Text(
                    param.labelDe,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${param.value} ${param.unit}'.trim(),
                  ),
                ),
                StatusChip(status: param.status),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 10),
              child: Text(
                param.guidanceDe,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.reed,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
