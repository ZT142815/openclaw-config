import 'package:flutter/material.dart';

/// Flutter 通用颜色系统
/// 遵循 Apple HIG + Material Design 3 设计规范
/// 支持深色/浅色模式自动切换
///
/// 【使用示例】
/// ```dart
/// // 在 StatelessWidget 中使用
/// color: AppColors.primary
///
/// // 在 StatefulWidget 中根据主题获取颜色
/// final isDark = Theme.of(context).brightness == Brightness.dark;
/// final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
/// ```
class AppColors {
  AppColors._();

  // ============================================================
  // 主色调 (Primary Colors)
  // ============================================================
  /// 主色 - iOS 系统蓝
  static const Color primary = Color(0xFF007AFF);

  /// 浅色主题主色
  static const Color primaryLight = Color(0xFF0A84FF);

  /// 深色主题主色
  static const Color primaryDark = Color(0xFF0055D4);

  /// 主色 10% 透明度（用于背景高亮）
  static const Color primary10 = Color(0x1A007AFF);

  /// 主色 15% 透明度（用于 Chip 背景）
  static const Color primary15 = Color(0x26007AFF);

  // ============================================================
  // 辅助色系统 (Semantic Colors)
  // ============================================================
  /// 成功色 - 绿色
  static const Color success = Color(0xFF34C759);

  /// 警告色 - 橙色
  static const Color warning = Color(0xFFFF9500);

  /// 错误色 - 红色
  static const Color error = Color(0xFFFF3B30);

  /// 信息色 - 浅蓝色
  static const Color info = Color(0xFF5AC8FA);

  // ============================================================
  // 深色模式颜色 (Dark Mode)
  // ============================================================
  /// 深色背景色 - 纯黑（节省 OLED 屏幕电量）
  static const Color darkBackground = Color(0xFF000000);

  /// 深色卡片表面色
  static const Color darkSurface = Color(0xFF1C1C1E);

  /// 深色浮层背景色（弹窗、底部弹窗）
  static const Color darkSurfaceElevated = Color(0xFF2C2C2E);

  /// 深色分组背景色
  static const Color darkSurfaceTertiary = Color(0xFF3A3A3C);

  /// 深色主文字色 - 纯白
  static const Color darkTextPrimary = Color(0xFFFFFFFF);

  /// 深色次要文字色
  static const Color darkTextSecondary = Color(0xFF8E8E93);

  /// 深色辅助文字色（占位符）
  static const Color darkTextTertiary = Color(0xFF636366);

  /// 深色禁用状态文字色
  static const Color darkTextDisabled = Color(0xFF48484A);

  /// 深色分隔线色 - 12% 白色
  static const Color darkSeparator = Color(0x1FFFFFFF);

  /// 深色不透明分隔线色
  static const Color darkSeparatorOpaque = Color(0xFF38383A);

  // ============================================================
  // 浅色模式颜色 (Light Mode)
  // ============================================================
  /// 浅色背景色 - 系统灰
  static const Color lightBackground = Color(0xFFF2F2F7);

  /// 浅色卡片表面色 - 纯白
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// 浅色浮层背景色 - 纯白
  static const Color lightSurfaceElevated = Color(0xFFFFFFFF);

  /// 浅色分组背景色
  static const Color lightSurfaceTertiary = Color(0xFFF2F2F7);

  /// 浅色主文字色 - 纯黑
  static const Color lightTextPrimary = Color(0xFF000000);

  /// 浅色次要文字色 - 60% 黑色
  static const Color lightTextSecondary = Color(0x993C3C43);

  /// 浅色辅助文字色 - 30% 黑色
  static const Color lightTextTertiary = Color(0x4D3C3C43);

  /// 浅色禁用状态文字色 - 18% 黑色
  static const Color lightTextDisabled = Color(0x2D3C3C43);

  /// 浅色分隔线色 - 12% 黑色
  static const Color lightSeparator = Color(0x1F3C3C43);

  /// 浅色不透明分隔线色
  static const Color lightSeparatorOpaque = Color(0xFFC6C6C8);

  // ============================================================
  // 渐变色 (Gradients)
  // ============================================================
  /// 主色渐变（从左到右）
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0A84FF), Color(0xFF007AFF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// 主色渐变（从上到下）
  static const LinearGradient primaryGradientVertical = LinearGradient(
    colors: [Color(0xFF0A84FF), Color(0xFF007AFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// 成功色渐变
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF34C759), Color(0xFF30D158)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// 错误色渐变
  static const LinearGradient errorGradient = LinearGradient(
    colors: [Color(0xFFFF3B30), Color(0xFFFF6961)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ============================================================
  // 便捷方法
  // ============================================================

  /// 根据主题获取背景色
  static Color backgroundColor(Brightness brightness) {
    return brightness == Brightness.dark ? darkBackground : lightBackground;
  }

  /// 根据主题获取卡片表面色
  static Color surfaceColor(Brightness brightness) {
    return brightness == Brightness.dark ? darkSurface : lightSurface;
  }

  /// 根据主题获取主文字色
  static Color textPrimaryColor(Brightness brightness) {
    return brightness == Brightness.dark ? darkTextPrimary : lightTextPrimary;
  }

  /// 根据主题获取次要文字色
  static Color textSecondaryColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkTextSecondary
        : lightTextSecondary;
  }

  /// 根据主题获取分隔线色
  static Color separatorColor(Brightness brightness) {
    return brightness == Brightness.dark ? darkSeparator : lightSeparator;
  }
}
