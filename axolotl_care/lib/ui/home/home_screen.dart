import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/content/knowledge_articles.dart';
import '../../data/repositories/app_repository.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../knowledge/article_detail_screen.dart';
import '../widgets/status_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AppRepository>();
    final aquarium = repo.selectedAquarium;
    final latest =
        aquarium == null ? null : repo.latestReading(aquarium.id);
    final tip = knowledgeArticles.first;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      children: [
        Text(
          'AxolotlCare',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Haltungswissen, Wasserwerte und Pflege – klar und quellenbasiert.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.reed,
                height: 1.35,
              ),
        ),
        const SizedBox(height: 28),
        if (aquarium == null)
          _EmptyAquariumPrompt(
            onCreate: () => _showCreateDialog(context, repo),
          )
        else ...[
          _StatusPanel(aquarium: aquarium, reading: latest),
          const SizedBox(height: 20),
          if (repo.aquariums.length > 1) ...[
            Text('Aktives Becken', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final item in repo.aquariums)
                  ChoiceChip(
                    label: Text(item.name),
                    selected: item.id == aquarium.id,
                    onSelected: (_) => repo.selectAquarium(item.id),
                  ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ],
        Text('Zum Nachlesen', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          tip.summary,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.reed,
              ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ArticleDetailScreen(article: tip),
                ),
              );
            },
            child: Text('Artikel „${tip.title}“ öffnen'),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Hinweis: AxolotlCare ersetzt keine tierärztliche Beratung.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.reed,
              ),
        ),
      ],
    );
  }

  Future<void> _showCreateDialog(BuildContext context, AppRepository repo) async {
    final nameController = TextEditingController(text: 'Becken 1');
    final volumeController = TextEditingController(text: '120');

    final created = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erstes Aquarium anlegen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: volumeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Volumen (Liter)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Anlegen'),
          ),
        ],
      ),
    );

    if (created == true) {
      final volume = double.tryParse(volumeController.text.replaceAll(',', '.'));
      if (volume == null || volume <= 0 || nameController.text.trim().isEmpty) {
        return;
      }
      await repo.addAquarium(
        name: nameController.text,
        volumeLiters: volume,
      );
    }
  }
}

class _EmptyAquariumPrompt extends StatelessWidget {
  const _EmptyAquariumPrompt({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lagoon.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Noch kein Aquarium',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Lege ein oder mehrere Becken an, um Wasserwerte und Pflegeaktionen zuzuordnen.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onCreate,
            child: const Text('Aquarium anlegen'),
          ),
        ],
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({required this.aquarium, required this.reading});

  final Aquarium aquarium;
  final WaterReading? reading;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.deepTeal.withValues(alpha: 0.92),
            AppColors.lagoon.withValues(alpha: 0.88),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            aquarium.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '${aquarium.volumeLiters.toStringAsFixed(0)} Liter',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
          ),
          const SizedBox(height: 18),
          if (reading == null)
            Text(
              'Noch keine Wasserwerte erfasst.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
            )
          else ...[
            Row(
              children: [
                StatusChip(status: reading!.overallStatus),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    dateFormat.format(reading!.recordedAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 14,
              runSpacing: 8,
              children: [
                if (reading!.temperatureC != null)
                  _Metric(
                    label: 'Temp',
                    value: '${reading!.temperatureC!.toStringAsFixed(1)} °C',
                  ),
                if (reading!.ph != null)
                  _Metric(
                    label: 'pH',
                    value: reading!.ph!.toStringAsFixed(1),
                  ),
                if (reading!.nitrateMgL != null)
                  _Metric(
                    label: 'NO₃',
                    value: '${reading!.nitrateMgL!.toStringAsFixed(0)} mg/l',
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white70,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
