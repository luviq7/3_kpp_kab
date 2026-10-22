import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../home/home_screen.dart';
import 'widgets/auth_card.dart';

/// Створення акаунта (ФВ 1). Окремого макета немає, тому екран у стилі вікна входу.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onRegister() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundMuted,
      body: AuthCard(
        leading: TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, size: 16),
          label: const Text('До входу'),
          style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
        ),
        children: [
          Text(
            'Створення акаунта',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Зареєструйтеся, щоб вести облік позичених речей',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppSpacing.large),
          AppTextField(
            label: "Ім'я та прізвище",
            hint: 'Тарас Кабачок',
            controller: _nameController,
          ),
          const SizedBox(height: AppSpacing.medium),
          AppTextField(
            label: 'Електронна пошта (email)',
            hint: 'name@example.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.medium),
          AppTextField(
            label: 'Пароль',
            hint: 'Створіть надійний пароль',
            controller: _passwordController,
            obscureText: true,
          ),
          const SizedBox(height: AppSpacing.medium),
          AppTextField(
            label: 'Підтвердження пароля',
            hint: 'Повторіть пароль',
            controller: _confirmController,
            obscureText: true,
          ),
          const SizedBox(height: AppSpacing.large),
          AppButton(
            label: 'Створити акаунт',
            expand: true,
            onPressed: _onRegister,
          ),
        ],
      ),
    );
  }
}
