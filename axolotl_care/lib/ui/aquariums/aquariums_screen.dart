import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/app_repository.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';

class AquariumsScreen extends StatelessWidget {
  const AquariumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AppRepository>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Aquarien',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            FilledButton.icon(
              onPressed: () => _upsert(context, repo),
              icon: const Icon(Icons.add),
              label: const Text('Neu'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Mehrere Becken möglich – Wasserwerte und Pflege greifen immer auf das aktive Aquarium zu.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.reed),
        ),
        const SizedBox(height: 18),
        if (repo.aquariums.isEmpty)
          Text(
            'Noch keine Aquarien angelegt.',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else
          for (final aquarium in repo.aquariums) ...[
            Material(
              color: Colors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(18),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(
                    color: aquarium.id == repo.selectedAquariumId
                        ? AppColors.lagoon
                        : AppColors.lagoon.withValues(alpha: 0.14),
                  ),
                ),
                title: Text(aquarium.name),
                subtitle: Text(
                  [
                    '${aquarium.volumeLiters.toStringAsFixed(0)} Liter',
                    if (aquarium.notes.isNotEmpty) aquarium.notes,
                    if (aquarium.id == repo.selectedAquariumId) 'Aktiv',
                  ].join(' · '),
                ),
                onTap: () => repo.selectAquarium(aquarium.id),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      await _upsert(context, repo, existing: aquarium);
                    } else if (value == 'delete') {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Aquarium löschen?'),
                          content: const Text(
                            'Alle zugehörigen Messungen und Pflegeeinträge werden entfernt.',
                          ),
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
                        await repo.deleteAquarium(aquarium.id);
                      }
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Bearbeiten')),
                    PopupMenuItem(value: 'delete', child: Text('Löschen')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
      ],
    );
  }

  Future<void> _upsert(
    BuildContext context,
    AppRepository repo, {
    Aquarium? existing,
  }) async {
    final nameController = TextEditingController(text: existing?.name ?? '');
    final volumeController = TextEditingController(
      text: existing == null ? '' : existing.volumeLiters.toStringAsFixed(0),
    );
    final notesController = TextEditingController(text: existing?.notes ?? '');

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existing == null ? 'Aquarium anlegen' : 'Aquarium bearbeiten'),
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
            const SizedBox(height: 12),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notiz'),
              maxLines: 2,
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
            child: const Text('Speichern'),
          ),
        ],
      ),
    );

    if (saved != true) return;
    final volume = double.tryParse(volumeController.text.replaceAll(',', '.'));
    if (nameController.text.trim().isEmpty || volume == null || volume <= 0) {
      return;
    }

    if (existing == null) {
      await repo.addAquarium(
        name: nameController.text,
        volumeLiters: volume,
        notes: notesController.text,
      );
    } else {
      existing.name = nameController.text.trim();
      existing.volumeLiters = volume;
      existing.notes = notesController.text.trim();
      await repo.updateAquarium(existing);
    }
  }
}
