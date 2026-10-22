import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/date_format.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/segmented_tabs.dart';
import '../../data/models/borrowed_item.dart';
import 'delete_item_dialog.dart';
import 'photo_capture_screen.dart';

/// Модальне вікно додавання / редагування запису про річ (Рис. 4, ФВ 4).
/// Лише інтерфейс: дані нікуди не зберігаються.
class ItemFormDialog extends StatefulWidget {
  /// `null` — створення нового запису.
  final BorrowedItem? item;

  const ItemFormDialog({super.key, this.item});

  @override
  State<ItemFormDialog> createState() => _ItemFormDialogState();
}

class _ItemFormDialogState extends State<ItemFormDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _contactController;
  late LoanDirection _direction;
  late DateTime _handedOverAt;
  late DateTime _returnDueAt;
  late bool _returned;

  bool get _isEditing => widget.item != null;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    final today = DateUtils.dateOnly(DateTime.now());
    _titleController = TextEditingController(text: item?.title);
    _contactController = TextEditingController(text: item?.contactName);
    _direction = item?.direction ?? LoanDirection.lent;
    _handedOverAt = item?.handedOverAt ?? today;
    _returnDueAt = item?.returnDueAt ?? today.add(const Duration(days: 14));
    _returned = item?.status == LoanStatus.returned;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDate(DateTime initial) {
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
  }

  void _close({String? message}) {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    if (message != null) {
      messenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _onDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteItemDialog(),
    );
    if (confirmed == true && mounted) {
      _close(message: 'Запис видалено');
    }
  }

  void _onPhotoPressed() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const PhotoCaptureScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const Divider(height: 1),
            Flexible(child: SingleChildScrollView(child: _buildForm())),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.large,
        AppSpacing.medium,
        AppSpacing.medium,
        AppSpacing.medium,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _isEditing ? 'Редагування запису про річ' : 'Новий запис про річ',
              style: const TextStyle(fontSize: 20, color: AppColors.textPrimary),
            ),
          ),
          IconButton(
            tooltip: 'Закрити',
            onPressed: _close,
            style: IconButton.styleFrom(
              backgroundColor: AppColors.backgroundMuted,
            ),
            icon: const Icon(Icons.close, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SegmentedTabs(
            labels: const ['Я позичив', 'Мені позичили'],
            selectedIndex: _direction.index,
            onChanged: (index) =>
                setState(() => _direction = LoanDirection.values[index]),
          ),
          const SizedBox(height: AppSpacing.large),
          AppTextField(
            label: 'Назва предмета',
            hint: 'Наприклад, Фотоапарат Fujifilm X100V',
            controller: _titleController,
          ),
          const SizedBox(height: AppSpacing.medium),
          AppTextField(
            label: "Контактна особа (ім'я)",
            hint: "Ім'я та прізвище",
            controller: _contactController,
          ),
          const SizedBox(height: AppSpacing.medium),
          Row(
            children: [
              Expanded(
                child: _DateField(
                  label: 'Дата передачі',
                  value: _handedOverAt,
                  onTap: () async {
                    final date = await _pickDate(_handedOverAt);
                    if (date != null) setState(() => _handedOverAt = date);
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.medium),
              Expanded(
                child: _DateField(
                  label: 'Планована дата повернення',
                  value: _returnDueAt,
                  onTap: () async {
                    final date = await _pickDate(_returnDueAt);
                    if (date != null) setState(() => _returnDueAt = date);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          CheckboxListTile(
            value: _returned,
            onChanged: (value) => setState(() => _returned = value ?? false),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: const Text('Позначити як повернене'),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppButton.secondary(
            label: 'Фотофіксація стану речі',
            icon: Icons.photo_camera_outlined,
            onPressed: _onPhotoPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: AppColors.backgroundMuted,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.medium,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: AppSpacing.xs,
        children: [
          if (_isEditing)
            TextButton(
              onPressed: _onDelete,
              style: TextButton.styleFrom(foregroundColor: AppColors.danger),
              child: const Text('Видалити запис'),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton.secondary(label: 'Скасувати', onPressed: _close),
              const SizedBox(width: AppSpacing.small),
              AppButton(
                label: _isEditing ? 'Зберегти зміни' : 'Додати',
                onPressed: () => _close(
                  message: _isEditing ? 'Зміни збережено' : 'Запис додано',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime value;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      // Ключ із датою, щоб поле перебудувалось із новим значенням.
      key: ValueKey(value),
      label: label,
      controller: TextEditingController(text: AppDateFormat.short(value)),
      readOnly: true,
      suffixIcon: Icons.calendar_today_outlined,
      onTap: onTap,
    );
  }
}
