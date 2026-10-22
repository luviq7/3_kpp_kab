import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../home/home_screen.dart';
import 'register_screen.dart';
import 'widgets/auth_card.dart';

/// Вікно входу в систему з блоком відновлення пароля (макет Рис. 1, ФВ 1).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _resetEmailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _resetEmailController.dispose();
    super.dispose();
  }

  // Без бізнес-логіки: «Увійти» відкриває головний екран, як після успішного входу.
  void _onLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  void _onCreateAccount() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const RegisterScreen()),
    );
  }

  void _onSendResetLink() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Посилання для скидання пароля надіслано на вашу пошту'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundMuted,
      body: AuthCard(
        children: [
          Text(
            'Вхід у систему',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Менеджер позичених речей',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppSpacing.large),
          AppTextField(
            label: 'Електронна пошта (email)',
            hint: 'name@example.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.medium),
          AppTextField(
            label: 'Пароль',
            hint: '••••••••',
            controller: _passwordController,
            obscureText: true,
          ),
          const SizedBox(height: AppSpacing.large),
          AppButton(label: 'Увійти', expand: true, onPressed: _onLogin),
          const SizedBox(height: AppSpacing.small),
          AppButton.secondary(
            label: 'Створити акаунт',
            expand: true,
            onPressed: _onCreateAccount,
          ),
          const SizedBox(height: AppSpacing.large),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.large),
          Text('Відновлення пароля', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Введіть ваш email, щоб отримати посилання для безпечного '
            'скидання пароля.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.medium),
          AppTextField(
            label: 'Електронна пошта',
            hint: 'your-email@example.com',
            controller: _resetEmailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.medium),
          AppButton.tinted(
            label: 'Надіслати посилання для скидання',
            expand: true,
            onPressed: _onSendResetLink,
          ),
        ],
      ),
    );
  }
}
