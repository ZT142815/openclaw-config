import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 页面脚手架组件
/// 提供统一的安全区处理、导航栏配置
///
/// 【使用示例】
/// ```dart
/// AppScaffold(
///   navigationBar: AppNavBar(
///     title: '标题',
///     leading: AppBackButton(),
///     trailing: IconButton(
///       icon: Icon(CupertinoIcons.add),
///       onPressed: () => _add(),
///     ),
///   ),
///   body: ListView(
///     children: [...],
///   ),
/// )
///
/// // 全屏页面（无导航栏）
/// AppScaffold(
///   body: SafeArea(
///     child: Content(),
///   ),
/// )
/// ```
class AppScaffold extends StatelessWidget {
  /// 页面内容
  final Widget body;

  /// 导航栏
  final AppNavBar? navigationBar;

  /// 底部导航栏
  final Widget? bottomNavigationBar;

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否自动处理安全区
  final bool safeArea;

  /// 安全区配置
  final bool? safeAreaTop;
  final bool? safeAreaBottom;
  final bool? safeAreaLeft;
  final bool? safeAreaRight;

  /// 页面内边距
  final EdgeInsetsGeometry? padding;

  const AppScaffold({
    super.key,
    required this.body,
    this.navigationBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.safeArea = true,
    this.safeAreaTop,
    this.safeAreaBottom,
    this.safeAreaLeft,
    this.safeAreaRight,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBgColor = backgroundColor ??
        (isDark ? AppColors.darkBackground : AppColors.lightBackground);

    Widget content = Column(
      children: [
        if (navigationBar != null) navigationBar!,
        Expanded(
          child: padding != null
              ? Padding(padding: padding!, child: body)
              : body,
        ),
        if (bottomNavigationBar != null) bottomNavigationBar!,
      ],
    );

    if (safeArea) {
      content = SafeArea(
        top: safeAreaTop ?? (navigationBar == null),
        bottom: safeAreaBottom ?? (bottomNavigationBar == null),
        left: safeAreaLeft ?? true,
        right: safeAreaRight ?? true,
        child: content,
      );
    }

    return Scaffold(
      backgroundColor: effectiveBgColor,
      body: content,
    );
  }
}

/// App 导航栏组件
class AppNavBar extends StatelessWidget {
  /// 标题
  final String? title;

  /// 标题 Widget（优先级高于 title）
  final Widget? titleWidget;

  /// 副标题
  final String? subtitle;

  /// 左侧 Widget
  final Widget? leading;

  /// 右侧 Widget
  final Widget? trailing;

  /// 标题对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  /// 高度
  final double height;

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否透明
  final bool transparent;

  /// 边框颜色
  final Color? borderColor;

  /// 是否显示底部边框
  final bool showBorder;

  const AppNavBar({
    super.key,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.leading,
    this.trailing,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.height = 44,
    this.backgroundColor,
    this.transparent = false,
    this.borderColor,
    this.showBorder = true,
  });

  /// 大标题导航栏
  const AppNavBar.largeTitle({
    super.key,
    required String title,
    this.leading,
    this.trailing,
    this.height = 96,
    this.backgroundColor,
    this.transparent = false,
    this.borderColor,
    this.showBorder = false,
  })  : titleWidget = null,
        subtitle = null,
        crossAxisAlignment = CrossAxisAlignment.start,
        title = title;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBgColor = backgroundColor ??
        (isDark ? AppColors.darkSurface : AppColors.lightSurface);
    final effectiveBorderColor = borderColor ??
        (isDark ? AppColors.darkSeparator : AppColors.lightSeparator);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: transparent ? Colors.transparent : effectiveBgColor,
        border: showBorder
            ? Border(
                bottom: BorderSide(
                  color: effectiveBorderColor,
                  width: 0.5,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          // 左侧
          if (leading != null)
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.xs),
              child: leading,
            )
          else
            const SizedBox(width: AppSpacing.xs),

          // 标题
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (titleWidget != null)
                  titleWidget!
                else if (title != null)
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                    textAlign:
                        crossAxisAlignment == CrossAxisAlignment.center
                            ? TextAlign.center
                            : TextAlign.start,
                  ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
              ],
            ),
          ),

          // 右侧
          if (trailing != null)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: trailing,
            )
          else
            const SizedBox(width: AppSpacing.xs),
        ],
      ),
    );
  }
}

/// App 大标题导航栏
class AppLargeTitleNavBar extends StatelessWidget {
  /// 标题
  final String title;

  /// 左侧 Widget
  final Widget? leading;

  /// 右侧 Widget
  final Widget? trailing;

  /// 背景颜色
  final Color? backgroundColor;

  /// 底部内边距（用于滚动时）
  final EdgeInsetsGeometry? bottomPadding;

  const AppLargeTitleNavBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBgColor = backgroundColor ??
        (isDark ? AppColors.darkBackground : AppColors.lightBackground);

    return Container(
      color: effectiveBgColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: AppSpacing.md,
        right: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 顶部导航行
          SizedBox(
            height: 44,
            child: Row(
              children: [
                if (leading != null) leading!,
                const Spacer(),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          // 大标题
          Padding(
            padding: bottomPadding ?? EdgeInsets.zero,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// App Cupertino 风格导航栏包装
class AppCupertinoNavBar extends StatelessWidget {
  /// Cupertino 导航栏
  final CupertinoNavigationBar cupertinoNavBar;

  /// 内容
  final Widget body;

  const AppCupertinoNavBar({
    super.key,
    required this.cupertinoNavBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: cupertinoNavBar,
      child: SafeArea(child: body),
    );
  }
}
