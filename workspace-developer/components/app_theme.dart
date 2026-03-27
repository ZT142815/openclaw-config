import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// Flutter 通用主题配置
/// 整合 Material Design 3 和 Apple HIG 设计规范
/// 支持深色/浅色模式自动切换
///
/// 【使用示例】
/// ```dart
/// // 在 MaterialApp 中使用
/// MaterialApp(
///   theme: AppTheme.lightTheme,
///   darkTheme: AppTheme.darkTheme,
///   themeMode: ThemeMode.system,
/// )
///
/// // 在 CupertinoApp 中使用
/// CupertinoApp(
///   theme: AppTheme.cupertinoLightTheme,
///   darkTheme: AppTheme.cupertinoDarkTheme,
/// )
///
/// // 获取当前主题颜色
/// final color = Theme.of(context).colorScheme.primary;
/// ```
class AppTheme {
  AppTheme._();

  // ============================================================
  // Material ThemeData
  // ============================================================

  /// 浅色主题
  static ThemeData get lightTheme => _buildLightTheme();

  /// 深色主题
  static ThemeData get darkTheme => _buildDarkTheme();

  /// 构建浅色主题
  static ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: _lightColorScheme,
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: _lightAppBarTheme,
      cardTheme: _lightCardTheme,
      elevatedButtonTheme: _lightElevatedButtonTheme,
      outlinedButtonTheme: _lightOutlinedButtonTheme,
      textButtonTheme: _lightTextButtonTheme,
      inputDecorationTheme: _lightInputDecorationTheme,
      dividerTheme: _lightDividerTheme,
      bottomNavigationBarTheme: _lightBottomNavTheme,
      cupertinoOverrideTheme: _cupertinoLightOverrideTheme,
    );
  }

  /// 构建深色主题
  static ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: _darkColorScheme,
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: _darkAppBarTheme,
      cardTheme: _darkCardTheme,
      elevatedButtonTheme: _darkElevatedButtonTheme,
      outlinedButtonTheme: _darkOutlinedButtonTheme,
      textButtonTheme: _darkTextButtonTheme,
      inputDecorationTheme: _darkInputDecorationTheme,
      dividerTheme: _darkDividerTheme,
      bottomNavigationBarTheme: _darkBottomNavTheme,
      cupertinoOverrideTheme: _cupertinoDarkOverrideTheme,
    );
  }

  // ============================================================
  // Cupertino ThemeData
  // ============================================================

  /// Cupertino 浅色主题
  static CupertinoThemeData get cupertinoLightTheme =>
      _buildCupertinoLightTheme();

  /// Cupertino 深色主题
  static CupertinoThemeData get cupertinoDarkTheme =>
      _buildCupertinoDarkTheme();

  static CupertinoThemeData _buildCupertinoLightTheme() {
    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      barBackgroundColor: AppColors.lightSurface,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.primary,
        textStyle: TextStyle(
          fontSize: 17,
          color: AppColors.lightTextPrimary,
        ),
        navTitleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        navLargeTitleTextStyle: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextPrimary,
        ),
      ),
    );
  }

  static CupertinoThemeData _buildCupertinoDarkTheme() {
    return const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      barBackgroundColor: AppColors.darkSurface,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.primary,
        textStyle: TextStyle(
          fontSize: 17,
          color: AppColors.darkTextPrimary,
        ),
        navTitleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        navLargeTitleTextStyle: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
      ),
    );
  }

  // ============================================================
  // ColorScheme
  // ============================================================

  static ColorScheme get _lightColorScheme => const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primary10,
        onPrimaryContainer: AppColors.primary,
        secondary: AppColors.info,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextPrimary,
        surfaceContainerHighest: AppColors.lightSurfaceTertiary,
      );

  static ColorScheme get _darkColorScheme => const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primary10,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.info,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
        surfaceContainerHighest: AppColors.darkSurfaceTertiary,
      );

  // ============================================================
  // TextTheme
  // ============================================================

  static TextTheme _buildTextTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return TextTheme(
      // 大标题 - 34px Bold
      displayLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        height: 41 / 34,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        height: 34 / 28,
      ),
      displaySmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        height: 28 / 22,
      ),
      // 标题 - 20px Semibold
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 25 / 20,
      ),
      // 列表项标题 - 17px Semibold
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 22 / 17,
      ),
      // 主要内容 - 17px Regular
      bodyLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.normal,
        color: primaryTextColor,
        height: 22 / 17,
      ),
      // 次要内容 - 16px Regular
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: primaryTextColor,
        height: 21 / 16,
      ),
      // 副标题 - 15px Regular
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: secondaryTextColor,
        height: 20 / 15,
      ),
      // 脚注说明 - 13px Regular
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: secondaryTextColor,
        height: 18 / 13,
      ),
      // 辅助说明 - 12px Regular
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: secondaryTextColor,
        height: 16 / 12,
      ),
    );
  }

  // ============================================================
  // AppBar Theme
  // ============================================================

  static AppBarTheme get _lightAppBarTheme => const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
      );

  static AppBarTheme get _darkAppBarTheme => const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
      );

  // ============================================================
  // Card Theme
  // ============================================================

  static CardTheme get _lightCardTheme => CardTheme(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        margin: EdgeInsets.zero,
      );

  static CardTheme get _darkCardTheme => CardTheme(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        margin: EdgeInsets.zero,
      );

  // ============================================================
  // Button Themes
  // ============================================================

  static ElevatedButtonThemeData get _lightElevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, AppSpacing.buttonHeightPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonPrimary),
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static ElevatedButtonThemeData get _darkElevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, AppSpacing.buttonHeightPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonPrimary),
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static OutlinedButtonThemeData get _lightOutlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(0, AppSpacing.buttonHeightPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonSecondary),
          ),
          side: const BorderSide(color: AppColors.primary, width: 1),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static OutlinedButtonThemeData get _darkOutlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(0, AppSpacing.buttonHeightPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonSecondary),
          ),
          side: const BorderSide(color: AppColors.primary, width: 1),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static TextButtonThemeData get _lightTextButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static TextButtonThemeData get _darkTextButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  // ============================================================
  // Input Decoration Theme
  // ============================================================

  static InputDecorationTheme get _lightInputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        hintStyle: TextStyle(
          fontSize: 17,
          color: AppColors.lightTextSecondary,
        ),
      );

  static InputDecorationTheme get _darkInputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        hintStyle: TextStyle(
          fontSize: 17,
          color: AppColors.darkTextSecondary,
        ),
      );

  // ============================================================
  // Divider Theme
  // ============================================================

  static DividerThemeData get _lightDividerTheme => const DividerThemeData(
        color: AppColors.lightSeparator,
        thickness: 0.5,
        space: 0,
      );

  static DividerThemeData get _darkDividerTheme => const DividerThemeData(
        color: AppColors.darkSeparator,
        thickness: 0.5,
        space: 0,
      );

  // ============================================================
  // Bottom Navigation Bar Theme
  // ============================================================

  static BottomNavigationBarThemeData get _lightBottomNavTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.normal,
        ),
      );

  static BottomNavigationBarThemeData get _darkBottomNavTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.normal,
        ),
      );

  // ============================================================
  // Cupertino Override Theme
  // ============================================================

  static CupertinoThemeData get _cupertinoLightOverrideTheme =>
      const CupertinoThemeData(
        primaryColor: AppColors.primary,
        brightness: Brightness.light,
      );

  static CupertinoThemeData get _cupertinoDarkOverrideTheme =>
      const CupertinoThemeData(
        primaryColor: AppColors.primary,
        brightness: Brightness.dark,
      );
}
