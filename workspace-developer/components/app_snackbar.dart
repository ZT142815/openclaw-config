import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App Snackbar 组件
/// 底部弹出提示，支持操作按钮，滑动删除
///
/// 【使用示例】
/// ```dart
/// // 基础提示
/// AppSnackbar.show(context, '内容已保存');
///
/// // 带操作按钮
/// AppSnackbar.show(
///   context,
///   message: '照片已删除',
///   action: SnackBarAction(
///     label: '撤销',
///     onTap: () => _undo(),
///   ),
/// );
///
/// // 自定义样式
/// AppSnackbar.show(
///   context,
///   message: '网络连接失败',
///   type: SnackBarType.error,
///   duration: const Duration(seconds: 4),
/// );
/// ```
class AppSnackbar {
  AppSnackbar._();

  /// 默认显示时长
  static const Duration defaultDuration = Duration(seconds: 3);

  /// 显示 Snackbar
  static void show(
    BuildContext context, {
    required String message,
    SnackBarAction? action,
    SnackBarType type = SnackBarType.neutral,
    Duration? duration,
    VoidCallback? onVisible,
    VoidCallback? onDismiss,
    String? leadingIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (leadingIcon != null) ...[
              Icon(
                _getIconData(leadingIcon),
                color: _getTextColor(type, isDark),
                size: 20,
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 15,
                  color: _getTextColor(type, isDark),
                ),
              ),
            ),
          ],
        ),
        action: action != null
            ? SnackBarAction(
                label: action.label,
                textColor: _getActionColor(type, isDark),
                onPressed: action.onTap,
              )
            : null,
        backgroundColor: _getBackgroundColor(type, isDark),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        margin: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        duration: duration ?? defaultDuration,
        onVisible: onVisible,
        dismissDirection: DismissDirection.horizontal,
      ),
    ).closed.then((reason) {
      onDismiss?.call();
    });
  }

  /// 成功提示
  static void success(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.success,
      action: action,
      duration: duration,
    );
  }

  /// 错误提示
  static void error(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.error,
      action: action,
      duration: duration,
    );
  }

  /// 警告提示
  static void warning(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.warning,
      action: action,
      duration: duration,
    );
  }

  /// 信息提示
  static void info(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.info,
      action: action,
      duration: duration,
    );
  }

  /// 获取背景颜色
  static Color _getBackgroundColor(SnackBarType type, bool isDark) {
    switch (type) {
      case SnackBarType.success:
        return isDark
            ? AppColors.success.withOpacity(0.95)
            : AppColors.success;
      case SnackBarType.error:
        return isDark ? AppColors.error.withOpacity(0.95) : AppColors.error;
      case SnackBarType.warning:
        return isDark
            ? AppColors.warning.withOpacity(0.95)
            : AppColors.warning;
      case SnackBarType.info:
        return isDark ? AppColors.info.withOpacity(0.95) : AppColors.info;
      case SnackBarType.neutral:
        return isDark
            ? AppColors.darkSurfaceElevated
            : AppColors.lightSurfaceElevated;
    }
  }

  /// 获取文字颜色
  static Color _getTextColor(SnackBarType type, bool isDark) {
    switch (type) {
      case SnackBarType.success:
      case SnackBarType.error:
      case SnackBarType.warning:
      case SnackBarType.info:
        return Colors.white;
      case SnackBarType.neutral:
        return isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    }
  }

  /// 获取操作按钮颜色
  static Color _getActionColor(SnackBarType type, bool isDark) {
    switch (type) {
      case SnackBarType.success:
      case SnackBarType.error:
      case SnackBarType.warning:
      case SnackBarType.info:
        return Colors.white;
      case SnackBarType.neutral:
        return AppColors.primary;
    }
  }

  /// 获取图标数据
  static IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'success':
        return CupertinoIcons.checkmark_circle_fill;
      case 'error':
        return CupertinoIcons.xmark_circle_fill;
      case 'warning':
        return CupertinoIcons.exclamationmark_triangle_fill;
      case 'info':
        return CupertinoIcons.info_circle_fill;
      default:
        return CupertinoIcons.info_circle_fill;
    }
  }
}

/// Snackbar 类型
enum SnackBarType {
  neutral,
  success,
  error,
  warning,
  info,
}

/// Snackbar 操作按钮
class SnackBarAction {
  /// 按钮文字
  final String label;

  /// 点击回调
  final VoidCallback onTap;

  const SnackBarAction({
    required this.label,
    required this.onTap,
  });
}
