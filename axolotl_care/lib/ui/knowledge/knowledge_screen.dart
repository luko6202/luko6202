import 'package:flutter/material.dart';

import '../../data/content/knowledge_articles.dart';
import '../../theme/app_theme.dart';
import 'article_detail_screen.dart';
import 'morphs_screen.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      children: [
        Text('Wissen', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text(
          'Quellenbasierte Grundlagen zu Aquarium, Kauf, Haltung, Fütterung, Gesundheit, '
          'Reinigung, Wasserwerten und Farbschlägen.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.reed,
                height: 1.35,
              ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MorphsScreen()),
            );
          },
          icon: const Icon(Icons.palette_outlined),
          label: const Text('Farbschlag-Katalog öffnen'),
        ),
        const SizedBox(height: 18),
        for (final article in knowledgeArticles) ...[
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              if (article.id == 'farbschlaege') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MorphsScreen()),
                );
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ArticleDetailScreen(article: article),
                ),
              );
            },
            child: Ink(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.lagoon.withValues(alpha: 0.14),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.category.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.lagoon,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.summary,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.reed,
                          height: 1.35,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
