import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App Toast 提示组件
/// 顶部弹出提示，支持多种样式，自动消失
///
/// 【使用示例】
/// ```dart
/// // 成功提示
/// AppToast.success(context, '保存成功');
///
/// // 失败提示
/// AppToast.error(context, '网络连接失败');
///
/// // 警告提示
/// AppToast.warning(context, '内容审核中');
///
/// // 信息提示
/// AppToast.info(context, '有新版本可用');
///
/// // 自定义样式
/// AppToast.show(
///   context,
///   message: '自定义消息',
///   icon: Icons.star,
///   duration: const Duration(seconds: 4),
/// );
/// ```
class AppToast {
  AppToast._();

  /// 默认显示时长
  static const Duration defaultDuration = Duration(seconds: 2);

  /// 显示 Toast
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration? duration,
    VoidCallback? onTap,
    bool dismissOnTap = true,
  }) {
    final overlayState = Overlay.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        isDark: isDark,
        onDismiss: () {
          overlayEntry.remove();
        },
        onTap: onTap,
        dismissOnTap: dismissOnTap,
      ),
    );

    overlayState.insert(overlayEntry);

    // 自动消失
    Timer(duration ?? defaultDuration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  /// 成功提示
  static void success(
    BuildContext context,
    String message, {
    Duration? duration,
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      type: ToastType.success,
      duration: duration,
      onTap: onTap,
    );
  }

  /// 错误提示
  static void error(
    BuildContext context,
    String message, {
    Duration? duration,
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      type: ToastType.error,
      duration: duration,
      onTap: onTap,
    );
  }

  /// 警告提示
  static void warning(
    BuildContext context,
    String message, {
    Duration? duration,
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      type: ToastType.warning,
      duration: duration,
      onTap: onTap,
    );
  }

  /// 信息提示
  static void info(
    BuildContext context,
    String message, {
    Duration? duration,
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      type: ToastType.info,
      duration: duration,
      onTap: onTap,
    );
  }
}

/// Toast 类型
enum ToastType {
  success,
  error,
  warning,
  info,
}

/// Toast 样式配置
class _ToastStyle {
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Color iconColor;

  const _ToastStyle({
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
  });

  static _ToastStyle fromType(ToastType type, bool isDark) {
    switch (type) {
      case ToastType.success:
        return _ToastStyle(
          backgroundColor:
              isDark ? AppColors.success.withOpacity(0.95) : AppColors.success,
          textColor: Colors.white,
          icon: CupertinoIcons.checkmark_circle_fill,
          iconColor: Colors.white,
        );
      case ToastType.error:
        return _ToastStyle(
          backgroundColor:
              isDark ? AppColors.error.withOpacity(0.95) : AppColors.error,
          textColor: Colors.white,
          icon: CupertinoIcons.xmark_circle_fill,
          iconColor: Colors.white,
        );
      case ToastType.warning:
        return _ToastStyle(
          backgroundColor:
              isDark ? AppColors.warning.withOpacity(0.95) : AppColors.warning,
          textColor: Colors.white,
          icon: CupertinoIcons.exclamationmark_triangle_fill,
          iconColor: Colors.white,
        );
      case ToastType.info:
        return _ToastStyle(
          backgroundColor:
              isDark ? AppColors.info.withOpacity(0.95) : AppColors.info,
          textColor: Colors.white,
          icon: CupertinoIcons.info_circle_fill,
          iconColor: Colors.white,
        );
    }
  }
}

/// Toast Widget
class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final bool isDark;
  final VoidCallback onDismiss;
  final VoidCallback? onTap;
  final bool dismissOnTap;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.isDark,
    required this.onDismiss,
    this.onTap,
    this.dismissOnTap = true,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = _ToastStyle.fromType(widget.type, widget.isDark);
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + AppSpacing.md,
      left: AppSpacing.md,
      right: AppSpacing.md,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                widget.onTap?.call();
                if (widget.dismissOnTap) {
                  _dismiss();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm + 2,
                ),
                decoration: BoxDecoration(
                  color: style.backgroundColor,
                  borderRadius: BorderRadius.circular(AppRadius.large),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      style.icon,
                      color: style.iconColor,
                      size: 22,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: style.textColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _dismiss,
                      child: Icon(
                        CupertinoIcons.xmark,
                        color: style.textColor.withOpacity(0.8),
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
