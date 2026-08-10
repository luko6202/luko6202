import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../widgets/atmosphere_background.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.article});

  final KnowledgeArticle article;

  @override
  Widget build(BuildContext context) {
    return AtmosphereBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(article.category),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(article.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text(
              article.summary,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.reed,
                    height: 1.4,
                  ),
            ),
            const SizedBox(height: 24),
            for (final section in article.sections) ...[
              Text(
                section.heading,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                section.body,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.45,
                      color: AppColors.ink.withValues(alpha: 0.9),
                    ),
              ),
              const SizedBox(height: 22),
            ],
            Text('Quellen', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Die Inhalte sind aus den genannten Quellen zusammengeführt und vereinfacht. '
              'Bitte Originalquellen und ggf. Fachleute konsultieren.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.reed,
                  ),
            ),
            const SizedBox(height: 12),
            for (final source in article.sources) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(source.title),
                subtitle: Text(
                  [
                    source.url,
                    if (source.note != null) source.note!,
                  ].join('\n'),
                ),
                trailing: const Icon(Icons.copy, size: 18),
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: source.url));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Quellen-URL kopiert')),
                    );
                  }
                },
              ),
              const Divider(height: 1),
            ],
          ],
        ),
      ),
    );
  }
}
