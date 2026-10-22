import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

enum AppButtonVariant {
  /// Синя кнопка основної дії («Увійти», «Зберегти зміни»).
  primary,

  /// Біла кнопка з рамкою («Створити акаунт», «Скасувати»).
  secondary,

  /// Біла кнопка з рамкою і синім текстом («Редагувати», «Надіслати посилання»).
  tinted,

  /// Червона кнопка небезпечної дії («Видалити»).
  destructive,
}

/// Стилізована кнопка застосунку.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool expand;
  final bool compact;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.expand = false,
    this.compact = false,
  });

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
    this.compact = false,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.tinted({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
    this.compact = false,
  }) : variant = AppButtonVariant.tinted;

  const AppButton.destructive({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
    this.compact = false,
  }) : variant = AppButtonVariant.destructive;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, borderColor) = switch (variant) {
      AppButtonVariant.primary => (AppColors.primary, Colors.white, null),
      AppButtonVariant.secondary => (
        Colors.white,
        AppColors.textPrimary,
        AppColors.border,
      ),
      AppButtonVariant.tinted => (
        Colors.white,
        AppColors.primary,
        AppColors.border,
      ),
      AppButtonVariant.destructive => (AppColors.danger, Colors.white, null),
    };

    final style = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(background),
      foregroundColor: WidgetStatePropertyAll(foreground),
      overlayColor: WidgetStatePropertyAll(foreground.withValues(alpha: 0.08)),
      elevation: const WidgetStatePropertyAll(0),
      minimumSize: WidgetStatePropertyAll(Size(0, compact ? 32 : 40)),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.small : AppSpacing.medium,
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: compact ? 13 : 14, fontWeight: FontWeight.w500),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          side: borderColor == null
              ? BorderSide.none
              : BorderSide(color: borderColor),
        ),
      ),
    );

    final button = icon == null
        ? TextButton(onPressed: onPressed, style: style, child: Text(label))
        : TextButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(icon, size: compact ? 16 : 18),
            label: Text(label),
          );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
