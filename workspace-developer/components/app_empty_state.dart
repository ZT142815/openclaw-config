import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 空状态组件
/// 用于列表/页面无数据时显示
///
/// 【使用示例】
/// ```dart
/// // 基础空状态
/// AppEmptyState(
///   icon: CupertinoIcons.tray,
///   title: '暂无数据',
///   message: '这里还没有任何内容，请稍后再试',
/// )
///
/// // 带操作按钮
/// AppEmptyState(
///   icon: CupertinoIcons.search,
///   title: '搜索结果为空',
///   message: '没有找到匹配的内容',
///   action: AppButton(
///     text: '清除搜索',
///     onPressed: () => _clearSearch(),
///   ),
/// )
/// ```
class AppEmptyState extends StatelessWidget {
  /// 图标
  final IconData? icon;

  /// 自定义图标 Widget（优先级高于 icon）
  final Widget? iconWidget;

  /// 标题
  final String? title;

  /// 描述文字
  final String? message;

  /// 标题 Widget（优先级高于 title）
  final Widget? titleWidget;

  /// 描述 Widget（优先级高于 message）
  final Widget? messageWidget;

  /// 操作按钮
  final Widget? action;

  /// 操作按钮文字（优先级低于 action）
  final String? actionText;

  /// 操作按钮回调
  final VoidCallback? onAction;

  /// 间距
  final double spacing;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 对齐方式
  final MainAxisAlignment mainAxisAlignment;

  /// 图标大小
  final double iconSize;

  /// 图标颜色
  final Color? iconColor;

  const AppEmptyState({
    super.key,
    this.icon,
    this.iconWidget,
    this.title,
    this.message,
    this.titleWidget,
    this.messageWidget,
    this.action,
    this.actionText,
    this.onAction,
    this.spacing = AppSpacing.md,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.iconSize = 64,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveIconColor =
        iconColor ?? (isDark ? AppColors.darkTextTertiary : AppColors.lightSeparatorOpaque);

    return Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 图标
          if (iconWidget != null)
            iconWidget!
          else if (icon != null)
            Icon(
              icon,
              size: iconSize,
              color: effectiveIconColor,
            ),

          // 标题
          if (titleWidget != null)
            titleWidget!
          else if (title != null) ...[
            SizedBox(height: spacing),
            Text(
              title!,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],

          // 描述
          if (messageWidget != null)
            messageWidget!
          else if (message != null) ...[
            SizedBox(height: spacing / 2),
            Text(
              message!,
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],

          // 操作按钮
          if (action != null) ...[
            SizedBox(height: spacing),
            action!,
          ] else if (actionText != null && onAction != null) ...[
            SizedBox(height: spacing),
            TextButton(
              onPressed: onAction,
              child: Text(actionText!),
            ),
          ],
        ],
      ),
    );
  }
}

/// App 错误状态组件
class AppErrorState extends StatelessWidget {
  /// 错误消息
  final String? message;

  /// 错误详情
  final String? detail;

  /// 重试回调
  final VoidCallback? onRetry;

  /// 重试按钮文字
  final String? retryText;

  /// 自定义图标
  final IconData? icon;

  const AppErrorState({
    super.key,
    this.message,
    this.detail,
    this.onRetry,
    this.retryText = '重试',
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: icon ?? CupertinoIcons.exclamationmark_circle,
      iconColor: AppColors.error,
      title: message ?? '加载失败',
      message: detail,
      action: onRetry != null
          ? _RetryButton(
              text: retryText!,
              onPressed: onRetry!,
            )
          : null,
    );
  }
}

/// 重试按钮
class _RetryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _RetryButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(CupertinoIcons.refresh, size: 18),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.buttonPrimary),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }
}

/// App 加载状态组件
class AppLoadingState extends StatelessWidget {
  /// 提示文字
  final String? message;

  /// 加载样式
  final LoadingStateStyle style;

  const AppLoadingState({
    super.key,
    this.message,
    this.style = LoadingStateStyle.cupertino,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (style == LoadingStateStyle.cupertino)
            CupertinoActivityIndicator(
              radius: 14,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            )
          else
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              message!,
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 加载状态样式
enum LoadingStateStyle { cupertino, material }

/// App 网络错误状态
class AppNetworkErrorState extends StatelessWidget {
  final VoidCallback? onRetry;

  const AppNetworkErrorState({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: CupertinoIcons.wifi_slash,
      title: '网络连接失败',
      message: '请检查您的网络设置',
      action: onRetry != null
          ? _RetryButton(
              text: '重新加载',
              onPressed: onRetry!,
            )
          : null,
    );
  }
}

/// App 无权限状态
class AppPermissionState extends StatelessWidget {
  final String? permissionName;
  final VoidCallback? onRequestPermission;

  const AppPermissionState({
    super.key,
    this.permissionName,
    this.onRequestPermission,
  });

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: CupertinoIcons.lock,
      title: '需要权限',
      message: permissionName != null
          ? '需要 $permissionName 权限才能继续'
          : '需要相关权限才能继续',
      action: onRequestPermission != null
          ? _RetryButton(
              text: '授予权限',
              onPressed: onRequestPermission!,
            )
          : null,
    );
  }
}

/// App 搜索空状态
class AppSearchEmptyState extends StatelessWidget {
  final String? keyword;
  final VoidCallback? onClear;

  const AppSearchEmptyState({
    super.key,
    this.keyword,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: CupertinoIcons.search,
      title: '未找到结果',
      message: keyword != null
          ? '没有找到与 "$keyword" 相关的内容'
          : '没有找到相关内容',
      action: onClear != null
          ? _RetryButton(
              text: '清除搜索',
              onPressed: onClear!,
            )
          : null,
    );
  }
}

/// App 收藏空状态
class AppFavoriteEmptyState extends StatelessWidget {
  final VoidCallback? onExplore;

  const AppFavoriteEmptyState({
    super.key,
    this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: CupertinoIcons.heart,
      title: '暂无收藏',
      message: '收藏感兴趣的内容，方便以后查看',
      action: onExplore != null
          ? _RetryButton(
              text: '去逛逛',
              onPressed: onExplore!,
            )
          : null,
    );
  }
}
