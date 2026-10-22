import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/dashed_drop_zone.dart';
import '../../core/widgets/user_avatar.dart';
import '../../data/mock_data.dart';

/// Фотофіксація стану речі (Рис. 6, ФВ 6). Лише інтерфейс: замість вибору файлу
/// показується фото-приклад із assets.
class PhotoCaptureScreen extends StatefulWidget {
  const PhotoCaptureScreen({super.key});

  @override
  State<PhotoCaptureScreen> createState() => _PhotoCaptureScreenState();
}

class _PhotoCaptureScreenState extends State<PhotoCaptureScreen> {
  static const String _samplePhoto = 'assets/images/sample_item_photo.jpg';
  static const String _sampleSize = '2.4 МБ';

  bool _hasPhoto = true;

  void _attach() => setState(() => _hasPhoto = true);

  void _remove() {
    setState(() => _hasPhoto = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Фото видалено')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundMuted,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.large,
            AppSpacing.titleBarHeight,
            AppSpacing.large,
            AppSpacing.large,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                border: Border.all(color: AppColors.divider),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(theme),
                  const SizedBox(height: AppSpacing.medium),
                  _buildPhotoRow(),
                  const SizedBox(height: AppSpacing.medium),
                  DashedDropZone(
                    label: 'Перетягніть фото сюди або оберіть файл',
                    onTap: _attach,
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  _buildActions(theme),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.medium),
                    child: Divider(height: 1),
                  ),
                  _buildAuthor(theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Фотофіксація стану речі', style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Додайте або оновіть фотографію для фіксації стану переданої речі.',
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.medium),
        AppButton.secondary(
          label: 'Повернутися до редагування',
          icon: Icons.arrow_back,
          compact: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildPhotoRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 755 / 313,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radius),
              child: _hasPhoto
                  ? Image.asset(_samplePhoto, fit: BoxFit.cover)
                  : const ColoredBox(
                      color: AppColors.backgroundMuted,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 48,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.small),
        Tooltip(
          message: 'Видалити фото',
          child: IconButton(
            onPressed: _hasPhoto ? _remove : null,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radius),
              ),
            ),
            icon: const Icon(
              Icons.delete_outline,
              size: 18,
              color: AppColors.danger,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(ThemeData theme) {
    return Row(
      children: [
        if (_hasPhoto)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.small,
              vertical: AppSpacing.xxs + 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundMuted,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            child: Text(
              'Розмір: $_sampleSize',
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
          ),
        const Spacer(),
        AppButton(
          label: 'Прикріпити фото',
          icon: Icons.image_outlined,
          onPressed: _attach,
        ),
      ],
    );
  }

  Widget _buildAuthor(ThemeData theme) {
    return Row(
      children: [
        const UserAvatar(size: 28),
        const SizedBox(width: AppSpacing.xs),
        Text(
          'Додав: ${MockData.currentUser.fullName}',
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
