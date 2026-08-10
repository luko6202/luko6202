import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/app_repository.dart';
import 'theme/app_theme.dart';
import 'ui/shell/app_shell.dart';

class AxolotlCareApp extends StatelessWidget {
  const AxolotlCareApp({super.key, required this.repository});

  final AppRepository repository;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: repository,
      child: MaterialApp(
        title: 'AxolotlCare',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const AppShell(),
      ),
    );
  }
}
