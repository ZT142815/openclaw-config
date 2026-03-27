import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// App 分组标题组件
/// 用于列表/页面中的区块分隔
///
/// 【使用示例】
/// ```dart
/// // 基础分组标题
/// AppSectionHeader(title: '基本信息')
///
/// // 带操作按钮
/// AppSectionHeader(
///   title: '设置',
///   trailing: TextButton(
///     text: '编辑',
///     onPressed: () => _edit(),
///   ),
/// )
///
/// // 大标题样式
/// AppSectionHeader.large(title: '发现')
/// ```
class AppSectionHeader extends StatelessWidget {
  /// 标题文字
  final String? title;

  /// 标题 Widget（优先级高于 title）
  final Widget? titleWidget;

  /// 右侧 Widget
  final Widget? trailing;

  /// 左侧 Widget
  final Widget? leading;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 标题样式
  final SectionHeaderStyle style;

  /// 是否显示下边框
  final bool showDivider;

  /// 分隔线颜色
  final Color? dividerColor;

  /// 大写显示
  final bool uppercase;

  /// 标题颜色
  final Color? titleColor;

  const AppSectionHeader({
    super.key,
    this.title,
    this.titleWidget,
    this.trailing,
    this.leading,
    this.padding,
    this.style = SectionHeaderStyle.defaultStyle,
    this.showDivider = true,
    this.dividerColor,
    this.uppercase = false,
    this.titleColor,
  });

  /// 大标题样式
  const AppSectionHeader.largeTitle({
    super.key,
    required String title,
    this.trailing,
    this.leading,
    this.padding,
    this.showDivider = false,
    this.dividerColor,
  })  : titleWidget = null,
        title = title,
        style = SectionHeaderStyle.largeTitle,
        uppercase = false,
        titleColor = null;

  /// 副标题样式
  const AppSectionHeader.subtitle({
    super.key,
    required String title,
    this.trailing,
    this.leading,
    this.padding,
    this.showDivider = false,
    this.dividerColor,
  })  : titleWidget = null,
        title = title,
        style = SectionHeaderStyle.subtitle,
        uppercase = false,
        titleColor = null;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectivePadding = padding ?? const EdgeInsets.fromLTRB(
      AppSpacing.md,
      AppSpacing.lg,
      AppSpacing.md,
      AppSpacing.xs,
    );

    // 根据样式计算文本样式
    TextStyle textStyle;
    switch (style) {
      case SectionHeaderStyle.defaultStyle:
        textStyle = TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: titleColor ??
              (isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary),
          letterSpacing: uppercase ? 0.5 : null,
        );
        break;
      case SectionHeaderStyle.largeTitle:
        textStyle = TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: titleColor ??
              (isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary),
        );
        break;
      case SectionHeaderStyle.title1:
        textStyle = TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: titleColor ??
              (isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary),
        );
        break;
      case SectionHeaderStyle.title2:
        textStyle = TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: titleColor ??
              (isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary),
        );
        break;
      case SectionHeaderStyle.title3:
        textStyle = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: titleColor ??
              (isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary),
        );
        break;
      case SectionHeaderStyle.headline:
        textStyle = TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: titleColor ??
              (isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary),
        );
        break;
      case SectionHeaderStyle.subhead:
        textStyle = TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: titleColor ??
              (isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary),
        );
        break;
      case SectionHeaderStyle.subtitle:
        textStyle = TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: titleColor ??
              (isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary),
        );
        break;
    }

    final displayTitle = uppercase && title != null ? title!.toUpperCase() : title;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: effectivePadding,
          child: Row(
            children: [
              // 左侧 Widget
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AppSpacing.xs),
              ],

              // 标题
              Expanded(
                child: titleWidget ??
                    Text(
                      displayTitle ?? '',
                      style: textStyle,
                    ),
              ),

              // 右侧 Widget
              if (trailing != null) ...[
                const SizedBox(width: AppSpacing.xs),
                trailing!,
              ],
            ],
          ),
        ),

        // 分隔线
        if (showDivider)
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.xs),
            height: 0.5,
            color: dividerColor ??
                (isDark ? AppColors.darkSeparator : AppColors.lightSeparator),
          ),
      ],
    );
  }
}

/// 分组标题样式枚举
enum SectionHeaderStyle {
  /// 默认样式 - 13px 大写灰色
  defaultStyle,

  /// 大标题 - 34px Bold
  largeTitle,

  /// 标题1 - 28px Bold
  title1,

  /// 标题2 - 22px Bold
  title2,

  /// 标题3 - 20px Semibold
  title3,

  /// 列表项标题 - 17px Semibold
  headline,

  /// 副标题 - 15px Regular 灰色
  subhead,

  /// 副标题 - 15px Regular
  subtitle,
}

/// App 分组脚注组件
class AppSectionFooter extends StatelessWidget {
  /// 脚注文本
  final String? text;

  /// 脚注 Widget（优先级高于 text）
  final Widget? child;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 文字颜色
  final Color? textColor;

  const AppSectionFooter({
    super.key,
    this.text,
    this.child,
    this.padding,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectivePadding = padding ?? const EdgeInsets.fromLTRB(
      AppSpacing.md,
      AppSpacing.xs,
      AppSpacing.md,
      AppSpacing.sm,
    );

    return Padding(
      padding: effectivePadding,
      child: child ??
          Text(
            text!,
            style: TextStyle(
              fontSize: 13,
              color: textColor ??
                  (isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary),
            ),
          ),
    );
  }
}

/// App 卡片标题组件（带左侧装饰条）
class AppCardSectionTitle extends StatelessWidget {
  /// 标题
  final String title;

  /// 装饰颜色
  final Color? accentColor;

  /// 右侧 Widget
  final Widget? trailing;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  const AppCardSectionTitle({
    super.key,
    required this.title,
    this.accentColor,
    this.trailing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveAccentColor = accentColor ?? AppColors.primary;

    return Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          // 装饰条
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: effectiveAccentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // 标题
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),

          // 右侧
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// App 带标题的分隔线
class AppDividerHeader extends StatelessWidget {
  /// 标题
  final String? title;

  /// 标题 Widget
  final Widget? titleWidget;

  /// 装饰颜色
  final Color? color;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  const AppDividerHeader({
    super.key,
    this.title,
    this.titleWidget,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ??
        (isDark ? AppColors.darkSeparator : AppColors.lightSeparator);

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          if (title != null || titleWidget != null) ...[
            titleWidget ??
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
            const SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Container(
              height: 0.5,
              color: effectiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
