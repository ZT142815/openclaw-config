import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 对话框组件
/// 支持确认框、输入框、自定义内容
///
/// 【使用示例】
/// ```dart
/// // 确认对话框
/// AppDialog.confirm(
///   context,
///   title: '确认删除',
///   content: '确定要删除这个项目吗？此操作无法撤销。',
///   confirmText: '删除',
///   confirmColor: AppColors.error,
///   onConfirm: () => _delete(),
/// )
///
/// // 提示对话框
/// AppDialog.alert(
///   context,
///   title: '提示',
///   content: '操作成功！',
/// )
///
/// // 自定义对话框
/// showDialog(
///   context: context,
///   builder: (context) => AppDialog(
///     child: Column(
///       mainAxisSize: MainAxisSize.min,
///       children: [...],
///     ),
///   ),
/// )
/// ```
class AppDialog extends StatelessWidget {
  /// 对话框内容
  final Widget? child;

  /// 标题
  final String? title;

  /// 内容
  final String? content;

  /// 标题 Widget（优先级高于 title）
  final Widget? titleWidget;

  /// 内容 Widget（优先级高于 content）
  final Widget? contentWidget;

  /// 确认按钮文字
  final String? confirmText;

  /// 取消按钮文字
  final String? cancelText;

  /// 确认按钮回调
  final VoidCallback? onConfirm;

  /// 取消按钮回调
  final VoidCallback? onCancel;

  /// 确认按钮颜色
  final Color? confirmColor;

  /// 是否显示取消按钮
  final bool showCancel;

  /// 是否显示确认按钮
  final bool showConfirm;

  /// 圆角
  final double? borderRadius;

  /// 宽度
  final double? width;

  const AppDialog({
    super.key,
    this.child,
    this.title,
    this.content,
    this.titleWidget,
    this.contentWidget,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.confirmColor,
    this.showCancel = true,
    this.showConfirm = true,
    this.borderRadius,
    this.width,
  });

  /// 显示确认对话框
  static Future<bool?> confirm(
    BuildContext context, {
    String? title,
    String? content,
    Widget? contentWidget,
    String confirmText = '确认',
    String cancelText = '取消',
    Color? confirmColor,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        contentWidget: contentWidget,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmColor: confirmColor,
        onConfirm: () {
          onConfirm?.call();
          Navigator.of(context).pop(true);
        },
        onCancel: () {
          onCancel?.call();
          Navigator.of(context).pop(false);
        },
      ),
    );
  }

  /// 显示提示对话框
  static Future<void> alert(
    BuildContext context, {
    String? title,
    String? content,
    Widget? contentWidget,
    String confirmText = '好的',
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        contentWidget: contentWidget,
        confirmText: confirmText,
        showCancel: false,
        onConfirm: () {
          onConfirm?.call();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// 显示输入对话框
  static Future<String?> input(
    BuildContext context, {
    String? title,
    String? content,
    String? placeholder,
    String? initialValue,
    String confirmText = '确认',
    String cancelText = '取消',
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
  }) {
    final controller = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () => Navigator.of(context).pop(controller.text),
        onCancel: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.md),
          child: CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            autofocus: true,
            keyboardType: keyboardType,
            onChanged: onChanged,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.darkSurfaceElevated,
              borderRadius: BorderRadius.circular(AppRadius.input),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveRadius = borderRadius ?? AppRadius.alertDialog;
    final effectiveWidth = width ?? 270;

    return Center(
      child: Container(
        width: effectiveWidth,
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(effectiveRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.2),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 内容区域
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  // 标题
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
                      textAlign: TextAlign.center,
                    ),

                  // 内容
                  if (contentWidget != null)
                    contentWidget!
                  else if (content != null)
                    Padding(
                      padding: EdgeInsets.only(top: title != null ? 8 : 0),
                      child: Text(
                        content!,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // 自定义内容
                  if (child != null) child!,
                ],
              ),
            ),

            // 按钮区域
            const SizedBox(height: AppSpacing.md),
            _buildButtons(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, bool isDark) {
    final hasCancel = showCancel;
    final hasConfirm = showConfirm;

    if (!hasCancel && !hasConfirm) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkSeparator : AppColors.lightSeparator,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          if (hasCancel)
            Expanded(
              child: _DialogButton(
                text: cancelText ?? '取消',
                onTap: () {
                  onCancel?.call();
                  Navigator.of(context).pop(false);
                },
                isDark: isDark,
              ),
            ),
          if (hasCancel && hasConfirm)
            Container(
              width: 0.5,
              height: 44,
              color: isDark ? AppColors.darkSeparator : AppColors.lightSeparator,
            ),
          if (hasConfirm)
            Expanded(
              child: _DialogButton(
                text: confirmText ?? '确认',
                onTap: () {
                  onConfirm?.call();
                  Navigator.of(context).pop(true);
                },
                isDark: isDark,
                isPrimary: true,
                primaryColor: confirmColor,
              ),
            ),
        ],
      ),
    );
  }
}

/// 对话框按钮
class _DialogButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isDark;
  final bool isPrimary;
  final Color? primaryColor;

  const _DialogButton({
    required this.text,
    this.onTap,
    required this.isDark,
    this.isPrimary = false,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: isPrimary ? FontWeight.w600 : FontWeight.normal,
            color: isPrimary
                ? (primaryColor ?? AppColors.primary)
                : (isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary),
          ),
        ),
      ),
    );
  }
}

/// App 底部弹窗
class AppBottomSheet extends StatelessWidget {
  /// 内容
  final Widget child;

  /// 标题
  final String? title;

  /// 圆角
  final double? borderRadius;

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否拖拽关闭
  final bool draggable;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.borderRadius,
    this.backgroundColor,
    this.draggable = true,
  });

  /// 显示底部弹窗
  static Future<T?> show<T>(
    BuildContext context,
    Widget child, {
    String? title,
    bool draggable = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AppBottomSheet(
        title: title,
        draggable: draggable,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBgColor = backgroundColor ??
        (isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurface);
    final effectiveRadius = borderRadius ?? AppRadius.bottomSheet;

    return Container(
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(effectiveRadius),
          topRight: Radius.circular(effectiveRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 拖拽指示器
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 5,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkTextTertiary
                  : AppColors.lightSeparatorOpaque,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),

          // 标题
          if (title != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              title!,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ],

          // 内容
          const SizedBox(height: AppSpacing.md),
          child,

          // 安全区
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
