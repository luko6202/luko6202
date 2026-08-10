import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AtmosphereBackground extends StatelessWidget {
  const AtmosphereBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFD9ECEB),
            AppColors.foam,
            Color(0xFFE8F0E8),
          ],
          stops: [0, 0.45, 1],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -40,
            child: _Blob(
              size: 220,
              color: AppColors.lagoon.withValues(alpha: 0.10),
            ),
          ),
          Positioned(
            bottom: 120,
            left: -60,
            child: _Blob(
              size: 180,
              color: AppColors.reed.withValues(alpha: 0.10),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
