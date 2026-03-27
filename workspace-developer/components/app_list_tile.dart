import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// App 列表项组件
/// 支持图标、副标题、右侧操作、分隔线
///
/// 【样式规范】
/// - 高度：44px（标准）/ 56px（带副标题）
/// - 左图标：24x24px，距左边缘 16px
/// - 主文字：17px Regular
/// - 副文字：15px Regular，次色
/// - 右箭头：Chevron 图标，次色
///
/// 【使用示例】
/// ```dart
/// // 基础列表项
/// AppListTile(
///   leading: Icon(CupertinoIcons.person),
///   title: '个人资料',
///   onTap: () => _openProfile(),
/// )
///
/// // 带副标题
/// AppListTile(
///   leading: Icon(CupertinoIcons.mail),
///   title: '邮箱',
///   subtitle: 'user@example.com',
///   trailing: Icon(CupertinoIcons.pencil, size: 20),
///   onTap: () => _editEmail(),
/// )
///
/// // 设置列表
/// Column(
///   children: [
///     AppListTile(
///       leading: Icon(CupertinoIcons.bell),
///       title: '通知',
///       trailing: CupertinoSwitch(value: _notifications, onChanged: ...),
///       showDivider: false,
///     ),
///     AppListTile(
///       leading: Icon(CupertinoIcons.lock),
///       title: '隐私',
///       onTap: () => _openPrivacy(),
///     ),
///   ],
/// )
/// ```
class AppListTile extends StatelessWidget {
  /// 左侧图标/头像
  final Widget? leading;

  /// 主标题
  final String title;

  /// 副标题
  final String? subtitle;

  /// 副标题 Widget（优先级高于 subtitle）
  final Widget? subtitleWidget;

  /// 右侧 Widget
  final Widget? trailing;

  /// 点击回调
  final VoidCallback? onTap;

  /// 是否显示分隔线
  final bool showDivider;

  /// 分隔线左边距（用于对齐）
  final double? dividerIndent;

  /// 分隔线右边距
  final double? dividerEndIndent;

  /// 列表项高度（覆盖自动计算）
  final double? height;

  /// 水平内边距
  final EdgeInsetsGeometry? contentPadding;

  /// 是否禁用
  final bool enabled;

  /// 自定义主标题样式
  final TextStyle? titleStyle;

  /// 自定义副标题样式
  final TextStyle? subtitleStyle;

  const AppListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    this.trailing,
    this.onTap,
    this.showDivider = true,
    this.dividerIndent,
    this.dividerEndIndent,
    this.height,
    this.contentPadding,
    this.enabled = true,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveHeight = height ?? (subtitle != null || subtitleWidget != null
        ? AppSpacing.listItemHeightWithSubtitle
        : AppSpacing.listItemHeight);

    final textColor = enabled
        ? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary)
        : (isDark ? AppColors.darkTextDisabled : AppColors.lightTextDisabled);

    final secondaryColor = enabled
        ? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)
        : (isDark ? AppColors.darkTextTertiary : AppColors.lightTextDisabled);

    final effectiveDividerIndent = dividerIndent ?? (leading != null ? 52.0 : AppSpacing.md);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : null,
            child: Container(
              height: effectiveHeight,
              padding: contentPadding ??
                  const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  // 左侧图标
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: AppSpacing.sm),
                  ],

                  // 中间内容
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: titleStyle ??
                              TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color: textColor,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle != null || subtitleWidget != null) ...[
                          const SizedBox(height: 2),
                          subtitleWidget ??
                              Text(
                                subtitle!,
                                style: subtitleStyle ??
                                    TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: secondaryColor,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ],
                      ],
                    ),
                  ),

                  // 右侧内容
                  if (trailing != null)
                    trailing
                  else if (onTap != null && enabled)
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 20,
                      color: secondaryColor,
                    ),
                ],
              ),
            ),
          ),
        ),

        // 分隔线
        if (showDivider)
          Container(
            margin: EdgeInsets.only(left: effectiveDividerIndent),
            height: 0.5,
            color: isDark ? AppColors.darkSeparator : AppColors.lightSeparator,
          ),
      ],
    );
  }
}

/// App 分组列表头
class AppListSectionHeader extends StatelessWidget {
  /// 标题文字
  final String title;

  /// 右侧 Widget
  final Widget? trailing;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  const AppListSectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: padding ??
          const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.xs,
          ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
                letterSpacing: 0.5,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// App 分组列表尾
class AppListSectionFooter extends StatelessWidget {
  /// 脚注文本
  final String? text;

  /// 脚注 Widget（优先级高于 text）
  final Widget? child;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  const AppListSectionFooter({
    super.key,
    this.text,
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: padding ??
          const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
            AppSpacing.sm,
          ),
      child: child ??
          Text(
            text!,
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
    );
  }
}

/// App 简单分隔列表项（无图标）
class AppDividerListTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showDivider;
  final Color? backgroundColor;

  const AppDividerListTile({
    super.key,
    required this.title,
    this.onTap,
    this.trailing,
    this.showDivider = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: title,
      onTap: onTap,
      trailing: trailing,
      showDivider: showDivider,
    );
  }
}
