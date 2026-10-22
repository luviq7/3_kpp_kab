import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/sidebar_tile.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../data/models/user_profile.dart';
import '../home_filter.dart';

class HomeSidebar extends StatelessWidget {
  final HomeFilter selected;
  final Map<HomeFilter, int> counts;
  final UserProfile user;
  final ValueChanged<HomeFilter> onSelected;
  final VoidCallback onProfileTap;

  const HomeSidebar({
    super.key,
    required this.selected,
    required this.counts,
    required this.user,
    required this.onSelected,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: AppColors.sidebar,
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        children: [
          for (final filter in HomeFilter.values)
            SidebarTile(
              icon: filter.icon,
              label: filter.title,
              count: counts[filter],
              selected: filter == selected,
              onTap: () => onSelected(filter),
            ),
          const Spacer(),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.small),
          _UserTile(user: user, onTap: onProfileTap),
        ],
      ),
    );
  }
}

/// Користувач унизу бічної панелі; натискання відкриває профіль.
class _UserTile extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onTap;

  const _UserTile({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: 'Профіль та безпека',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxs),
          child: Row(
            children: [
              const UserAvatar(),
              const SizedBox(width: AppSpacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.fullName, style: theme.textTheme.labelLarge),
                    Text(
                      'Власник акаунту',
                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
