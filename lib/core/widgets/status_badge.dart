import 'package:flutter/material.dart';

import '../../data/models/borrowed_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Бейдж статусу: синій «Активно», червоний «Протерміновано», сірий «Повернено».
class StatusBadge extends StatelessWidget {
  final LoanStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, foreground, background) = switch (status) {
      LoanStatus.active => ('Активно', AppColors.primary, AppColors.primarySoft),
      LoanStatus.overdue => (
        'Протерміновано',
        AppColors.danger,
        AppColors.dangerSoft,
      ),
      LoanStatus.returned => (
        'Повернено',
        AppColors.textSecondary,
        AppColors.backgroundMuted,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.small,
        vertical: AppSpacing.xxs + 2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
