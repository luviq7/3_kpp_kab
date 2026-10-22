import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../home_filter.dart';

/// Верхній тулбар вікна: назва, пошук, сортування і «+ Додати річ».
class HomeToolbar extends StatelessWidget {
  final HomeSort sort;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<HomeSort> onSortChanged;
  final VoidCallback onAddPressed;

  /// Ширина зони під системні кнопки вікна macOS.
  static const double _trafficLightsInset = 84;

  const HomeToolbar({
    super.key,
    required this.sort,
    required this.onSearchChanged,
    required this.onSortChanged,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.titleBarHeight + 2,
      padding: const EdgeInsets.only(
        left: _trafficLightsInset,
        right: AppSpacing.medium,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Text(
            'Менеджер речей',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 15,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 280,
            height: 32,
            child: TextField(
              onChanged: onSearchChanged,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                hintText: 'Пошук речей...',
                hintStyle: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                prefixIcon: Icon(Icons.search, size: 18),
                prefixIconConstraints: BoxConstraints(minWidth: 32),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.small),
          _SortMenu(sort: sort, onChanged: onSortChanged),
          const Spacer(),
          AppButton(
            label: 'Додати річ',
            icon: Icons.add,
            compact: true,
            onPressed: onAddPressed,
          ),
        ],
      ),
    );
  }
}

class _SortMenu extends StatelessWidget {
  final HomeSort sort;
  final ValueChanged<HomeSort> onChanged;

  const _SortMenu({required this.sort, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<HomeSort>(
      tooltip: 'Сортування',
      initialValue: sort,
      onSelected: onChanged,
      position: PopupMenuPosition.under,
      color: Colors.white,
      itemBuilder: (_) => [
        for (final option in HomeSort.values)
          PopupMenuItem(
            value: option,
            height: 36,
            child: Text(option.label, style: const TextStyle(fontSize: 13)),
          ),
      ],
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppSpacing.radius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(sort.label, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: AppSpacing.xs),
            const Icon(
              Icons.unfold_more,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
