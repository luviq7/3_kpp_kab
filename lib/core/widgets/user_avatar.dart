import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Кругла заглушка аватара (фото профілю з'явиться разом із роботою з медіа).
class UserAvatar extends StatelessWidget {
  final double size;

  const UserAvatar({super.key, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.sidebarSelected,
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(
        Icons.person_outline,
        size: size * 0.5,
        color: AppColors.textSecondary,
      ),
    );
  }
}
