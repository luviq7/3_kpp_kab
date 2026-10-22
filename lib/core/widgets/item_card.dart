import 'package:flutter/material.dart';

import '../../data/models/borrowed_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../utils/date_format.dart';
import 'app_button.dart';
import 'status_badge.dart';

/// Картка запису про річ у списку на головному екрані.
class ItemCard extends StatefulWidget {
  final BorrowedItem item;
  final VoidCallback onEdit;

  const ItemCard({super.key, required this.item, required this.onEdit});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _hovered = false;

  bool get _isOverdue => widget.item.status == LoanStatus.overdue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = widget.item;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: AppSpacing.small + 2,
        ),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.cardHover : Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            _buildLeadingIcon(),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Row(
                    children: [
                      Icon(
                        item.direction == LoanDirection.lent
                            ? Icons.person_outline
                            : Icons.person_pin_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                      Text(item.contactName, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            _buildReturnDate(theme),
            const SizedBox(width: AppSpacing.large),
            SizedBox(
              width: 128,
              child: Align(
                alignment: Alignment.center,
                child: StatusBadge(status: item.status),
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            AppButton.tinted(
              label: 'Редагувати',
              icon: Icons.edit_outlined,
              compact: true,
              onPressed: widget.onEdit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    final color = _isOverdue ? AppColors.danger : AppColors.primary;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _isOverdue ? AppColors.dangerSoft : AppColors.primarySoft,
      ),
      child: Icon(
        _isOverdue ? Icons.alarm_outlined : Icons.inventory_2_outlined,
        size: 20,
        color: color,
      ),
    );
  }

  Widget _buildReturnDate(ThemeData theme) {
    final item = widget.item;
    final text = switch (item.status) {
      LoanStatus.overdue =>
        'Протерміновано (${AppDateFormat.dayMonth(item.returnDueAt)})',
      LoanStatus.returned => 'Повернено',
      LoanStatus.active => 'До ${AppDateFormat.long(item.returnDueAt)}',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('ДАТА ПОВЕРНЕННЯ', style: theme.textTheme.labelSmall),
        const SizedBox(height: 2),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: _isOverdue ? AppColors.danger : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
