import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/app_repository.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';

class CareScreen extends StatelessWidget {
  const CareScreen({super.key});

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

    final logs = repo.careFor(aquarium.id);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      children: [
        Text('Pflege', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text(
          'Protokolliere Wasserwechsel, Filterpflege und Beobachtungen für ${aquarium.name}.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.reed),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final type in CareActionType.values)
              ActionChip(
                label: Text(type.labelDe),
                onPressed: () => _quickAdd(context, repo, aquarium.id, type),
              ),
          ],
        ),
        const SizedBox(height: 22),
        Text('Protokoll', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        if (logs.isEmpty)
          Text(
            'Noch keine Einträge. Tipp: Nach jedem Teilwasserwechsel kurz hier abhaken.',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else
          for (final entry in logs) ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(entry.type.labelDe),
              subtitle: Text(
                [
                  DateFormat('dd.MM.yyyy HH:mm').format(entry.performedAt),
                  if (entry.note.isNotEmpty) entry.note,
                ].join(' · '),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => repo.deleteCareLog(entry.id),
              ),
            ),
            const Divider(height: 1),
          ],
      ],
    );
  }

  Future<void> _quickAdd(
    BuildContext context,
    AppRepository repo,
    String aquariumId,
    CareActionType type,
  ) async {
    final noteController = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(type.labelDe),
        content: TextField(
          controller: noteController,
          decoration: const InputDecoration(
            labelText: 'Notiz (optional)',
            hintText: 'z. B. 30 % Wasserwechsel',
          ),
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

    if (ok == true) {
      await repo.addCareLog(
        aquariumId: aquariumId,
        type: type,
        note: noteController.text,
      );
    }
  }
}
