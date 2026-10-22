import 'package:flutter/material.dart';

/// Палітра застосунку за макетами з лабораторної №2 (Apple HIG, системний синій).
abstract final class AppColors {
  static const Color primary = Color(0xFF007AFF);
  static const Color primarySoft = Color(0xFFE8F2FF);
  static const Color danger = Color(0xFFFF3B30);
  static const Color dangerSoft = Color(0xFFFFE9E7);

  static const Color textPrimary = Color(0xFF1D1D1F);
  static const Color textSecondary = Color(0xFF86868B);

  static const Color background = Colors.white;
  static const Color backgroundMuted = Color(0xFFF5F5F7);
  static const Color sidebar = Color(0xFFF5F5F7);
  static const Color sidebarSelected = Color(0xFFE5E5EA);
  static const Color cardHover = Color(0xFFF2F2F7);

  static const Color border = Color(0xFFD2D2D7);
  static const Color divider = Color(0xFFE5E5EA);
}
