import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/content/color_morphs.dart';
import '../../data/repositories/app_repository.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';

class AquariumsScreen extends StatelessWidget {
  const AquariumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AppRepository>();
    final selected = repo.selectedAquarium;
    final residents =
        selected == null ? const <AxolotlProfile>[] : repo.axolotlsFor(selected.id);

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
              onPressed: () => _upsertAquarium(context, repo),
              icon: const Icon(Icons.add),
              label: const Text('Neu'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Becken verwalten und Axolotl mit Farbschlag zuordnen.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.reed,
              ),
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
                    '${repo.axolotlsFor(aquarium.id).length} Tier(e)',
                    if (aquarium.id == repo.selectedAquariumId) 'Aktiv',
                  ].join(' · '),
                ),
                onTap: () => repo.selectAquarium(aquarium.id),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      await _upsertAquarium(context, repo, existing: aquarium);
                    } else if (value == 'delete') {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Aquarium löschen?'),
                          content: const Text(
                            'Alle zugehörigen Tiere, Messungen und Pflegeeinträge werden entfernt.',
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
        if (selected != null) ...[
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tiere in ${selected.name}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton.icon(
                onPressed: () => _upsertAxolotl(context, repo, selected.id),
                icon: const Icon(Icons.pets),
                label: const Text('Tier'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (residents.isEmpty)
            Text(
              'Noch keine Axolotl erfasst. Lege Name und Farbschlag an.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.reed,
                  ),
            )
          else
            for (final animal in residents) ...[
              _AxolotlTile(
                profile: animal,
                onEdit: () => _upsertAxolotl(
                  context,
                  repo,
                  selected.id,
                  existing: animal,
                ),
                onDelete: () => repo.deleteAxolotl(animal.id),
              ),
              const SizedBox(height: 8),
            ],
        ],
      ],
    );
  }

  Future<void> _upsertAquarium(
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

  Future<void> _upsertAxolotl(
    BuildContext context,
    AppRepository repo,
    String aquariumId, {
    AxolotlProfile? existing,
  }) async {
    final nameController = TextEditingController(text: existing?.name ?? '');
    final notesController = TextEditingController(text: existing?.notes ?? '');
    var morphId = existing?.morphId ?? colorMorphs.first.id;
    var hasGfp = existing?.hasGfp ?? false;

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return AlertDialog(
              title: Text(existing == null ? 'Axolotl anlegen' : 'Axolotl bearbeiten'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'z. B. Luna',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: morphId,
                      decoration: const InputDecoration(labelText: 'Farbschlag'),
                      items: [
                        for (final morph in colorMorphs)
                          DropdownMenuItem(
                            value: morph.id,
                            child: Text(morph.nameDe),
                          ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setLocalState(() => morphId = value);
                      },
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: hasGfp,
                      onChanged: (value) {
                        setLocalState(() => hasGfp = value ?? false);
                      },
                      title: const Text('GFP'),
                      subtitle: const Text('Fluoreszenz unter Blau-/UV-Licht'),
                    ),
                    TextField(
                      controller: notesController,
                      decoration: const InputDecoration(labelText: 'Notiz'),
                      maxLines: 2,
                    ),
                  ],
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
            );
          },
        );
      },
    );

    if (saved != true || nameController.text.trim().isEmpty) return;

    if (existing == null) {
      await repo.addAxolotl(
        aquariumId: aquariumId,
        name: nameController.text,
        morphId: morphId,
        hasGfp: hasGfp,
        notes: notesController.text,
      );
    } else {
      existing.name = nameController.text.trim();
      existing.morphId = morphId;
      existing.hasGfp = hasGfp;
      existing.notes = notesController.text.trim();
      await repo.updateAxolotl(existing);
    }
  }
}

class _AxolotlTile extends StatelessWidget {
  const _AxolotlTile({
    required this.profile,
    required this.onEdit,
    required this.onDelete,
  });

  final AxolotlProfile profile;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final morph = colorMorphById(profile.morphId);
    final morphLabel = morph?.nameDe ?? 'Unbekannt';

    return Material(
      color: Colors.white.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(16),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.lagoon.withValues(alpha: 0.14)),
        ),
        title: Text(profile.name),
        subtitle: Text(
          [
            morphLabel,
            if (profile.hasGfp) 'GFP',
            if (profile.notes.isNotEmpty) profile.notes,
          ].join(' · '),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') onEdit();
            if (value == 'delete') onDelete();
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text('Bearbeiten')),
            PopupMenuItem(value: 'delete', child: Text('Löschen')),
          ],
        ),
      ),
    );
  }
}
