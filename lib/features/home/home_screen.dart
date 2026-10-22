import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/item_card.dart';
import '../../data/mock_data.dart';
import '../../data/models/borrowed_item.dart';
import '../items/item_form_dialog.dart';
import '../profile/profile_screen.dart';
import 'home_filter.dart';
import 'widgets/home_sidebar.dart';
import 'widgets/home_toolbar.dart';

/// Головне вікно: тулбар, бічна панель з категоріями та список речей (Рис. 3, ФВ 3).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final List<BorrowedItem> _items = MockData.items;

  HomeFilter _filter = HomeFilter.all;
  HomeSort _sort = HomeSort.returnDate;
  String _query = '';

  List<BorrowedItem> get _visibleItems {
    final query = _query.toLowerCase();
    final result = _items
        .where(_filter.matches)
        .where(
          (item) =>
              query.isEmpty ||
              item.title.toLowerCase().contains(query) ||
              item.contactName.toLowerCase().contains(query),
        )
        .toList();
    result.sort(_sort.compare);
    return result;
  }

  void _openItemForm([BorrowedItem? item]) {
    showDialog<void>(
      context: context,
      builder: (_) => ItemFormDialog(item: item),
    );
  }

  void _openProfile() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = _visibleItems;

    return Scaffold(
      body: Column(
        children: [
          HomeToolbar(
            sort: _sort,
            onSearchChanged: (value) => setState(() => _query = value.trim()),
            onSortChanged: (value) => setState(() => _sort = value),
            onAddPressed: _openItemForm,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeSidebar(
                  selected: _filter,
                  counts: {
                    for (final filter in HomeFilter.values)
                      filter: _items.where(filter.matches).length,
                  },
                  user: MockData.currentUser,
                  onSelected: (value) => setState(() => _filter = value),
                  onProfileTap: _openProfile,
                ),
                const VerticalDivider(width: 1, color: AppColors.divider),
                Expanded(child: _buildContent(visibleItems)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<BorrowedItem> visibleItems) {
    final theme = Theme.of(context);
    final activeCount = visibleItems
        .where((item) => item.status != LoanStatus.returned)
        .length;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.large),
      children: [
        Text(_filter.title, style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Відстежується $activeCount ${_pluralThings(activeCount)} '
          'в активному статусі',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.large),
        if (visibleItems.isEmpty)
          _buildEmptyState(theme)
        else
          for (final item in visibleItems)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.small),
              child: ItemCard(item: item, onEdit: () => _openItemForm(item)),
            ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl * 2),
      child: Column(
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 48,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.small),
          Text('Нічого не знайдено', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Змініть пошуковий запит або оберіть іншу категорію',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  static String _pluralThings(int count) {
    final mod10 = count % 10;
    final mod100 = count % 100;
    if (mod10 == 1 && mod100 != 11) return 'річ';
    if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) return 'речі';
    return 'речей';
  }
}
