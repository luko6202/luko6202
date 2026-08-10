import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../theme/app_theme.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final WaterStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, bg) = switch (status) {
      WaterStatus.good => (AppColors.good, const Color(0xFFDCEFE4)),
      WaterStatus.warn => (AppColors.warn, const Color(0xFFF6E7D4)),
      WaterStatus.critical => (AppColors.critical, const Color(0xFFF3D6D6)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.labelDe,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
