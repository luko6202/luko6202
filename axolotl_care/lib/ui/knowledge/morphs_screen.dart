import 'package:flutter/material.dart';

import '../../data/content/color_morphs.dart';
import '../../data/content/knowledge_articles.dart';
import '../../theme/app_theme.dart';
import '../widgets/atmosphere_background.dart';
import 'article_detail_screen.dart';

class MorphsScreen extends StatelessWidget {
  const MorphsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final article = articleById('farbschlaege');

    return AtmosphereBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Farbschläge'),
          actions: [
            if (article != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticleDetailScreen(article: article),
                    ),
                  );
                },
                child: const Text('Artikel'),
              ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              'Morphen-Katalog',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Häufige Farbschläge zum Nachschlagen. Du kannst sie auch unter „Becken“ '
              'deinen Axolotln zuordnen.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.reed,
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: 18),
            for (final morph in colorMorphs) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.58),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.lagoon.withValues(alpha: 0.14),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      morph.nameEn.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.lagoon,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      morph.nameDe,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      morph.shortDescription,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.reed,
                            height: 1.35,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      morph.details,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.4,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final mark in morph.hallmarks)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.mist,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              mark,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColors.deepTeal,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
