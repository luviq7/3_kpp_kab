import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/section_card.dart';
import '../../core/widgets/sidebar_tile.dart';
import '../../core/widgets/user_avatar.dart';
import '../../data/mock_data.dart';
import '../auth/login_screen.dart';

/// Керування профілем і зміна пароля (Рис. 2, ФВ 2).
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onSavePassword() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Пароль успішно оновлено')));
    _currentController.clear();
    _newController.clear();
    _confirmController.clear();
  }

  void _onChangePhoto() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Coming soon')));
  }

  void _onLogout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(),
          const VerticalDivider(width: 1, color: AppColors.divider),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      color: AppColors.sidebar,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.medium,
        AppSpacing.titleBarHeight,
        AppSpacing.medium,
        AppSpacing.medium,
      ),
      child: Column(
        children: [
          SidebarTile(
            icon: Icons.arrow_back,
            label: 'До списку речей',
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: AppSpacing.medium),
          SidebarTile(
            icon: Icons.settings,
            label: 'Загальні',
            filledIcon: true,
            onTap: () {},
          ),
          SidebarTile(
            icon: Icons.person,
            label: 'Профіль та безпека',
            filledIcon: true,
            selected: true,
            onTap: () {},
          ),
          SidebarTile(
            icon: Icons.notifications,
            label: 'Сповіщення',
            filledIcon: true,
            onTap: () {},
          ),
          SidebarTile(
            icon: Icons.help,
            label: 'Підтримка',
            filledIcon: true,
            onTap: () {},
          ),
          const Spacer(),
          AppButton.secondary(
            label: 'Вийти',
            icon: Icons.logout,
            expand: true,
            onPressed: _onLogout,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final theme = Theme.of(context);
    final user = MockData.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.titleBarHeight,
        AppSpacing.xxl,
        AppSpacing.xxl,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Керування профілем', style: theme.textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                'Налаштування вашої персональної інформації та безпеки пароля.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.large),
              SectionCard(
                child: Row(
                  children: [
                    const UserAvatar(size: 64),
                    const SizedBox(width: AppSpacing.medium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(user.email, style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    AppButton.secondary(
                      label: 'Змінити фото',
                      compact: true,
                      onPressed: _onChangePhoto,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.large),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Зміна пароля', style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.medium),
                    AppTextField(
                      label: 'Поточний пароль',
                      controller: _currentController,
                      obscureText: true,
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    AppTextField(
                      label: 'Новий пароль',
                      hint: 'Створіть надійний пароль',
                      controller: _newController,
                      obscureText: true,
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    AppTextField(
                      label: 'Підтвердження нового пароля',
                      hint: 'Повторіть новий пароль',
                      controller: _confirmController,
                      obscureText: true,
                    ),
                    const SizedBox(height: AppSpacing.large),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppButton(
                        label: 'Зберегти новий пароль',
                        onPressed: _onSavePassword,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
