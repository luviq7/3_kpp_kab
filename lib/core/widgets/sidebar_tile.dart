import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Пункт бічної панелі з іконкою, підписом і необов'язковим лічильником.
class SidebarTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final int? count;
  final VoidCallback onTap;

  /// Іконка у квадратній кольоровій плашці (як у налаштуваннях профілю).
  final bool filledIcon;

  const SidebarTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.count,
    this.filledIcon = false,
  });

  @override
  State<SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<SidebarTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final background = widget.selected
        ? AppColors.sidebarSelected
        : _hovered
        ? AppColors.sidebarSelected.withValues(alpha: 0.5)
        : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(AppSpacing.radius),
            ),
            child: Row(
              children: [
                _buildIcon(),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontWeight: widget.selected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
                if (widget.count != null) _buildCounter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (!widget.filledIcon) {
      return Icon(
        widget.icon,
        size: 18,
        color: widget.selected ? AppColors.primary : AppColors.textSecondary,
      );
    }
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: widget.selected ? AppColors.primary : AppColors.textSecondary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(widget.icon, size: 14, color: Colors.white),
    );
  }

  Widget _buildCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '${widget.count}',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
