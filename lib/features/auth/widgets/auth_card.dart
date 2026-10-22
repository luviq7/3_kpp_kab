import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Біла картка по центру вікна для екранів входу та реєстрації.
class AuthCard extends StatelessWidget {
  final List<Widget> children;
  final Widget? leading;

  const AuthCard({super.key, required this.children, this.leading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.large,
          AppSpacing.titleBarHeight,
          AppSpacing.large,
          AppSpacing.large,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.xl,
            ),
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
                if (leading != null) ...[
                  Align(alignment: Alignment.centerLeft, child: leading),
                  const SizedBox(height: AppSpacing.xs),
                ],
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
