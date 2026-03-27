import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 图标按钮组件
/// 支持多种样式：填充、描边、幽灵
///
/// 【样式规范】
/// - 尺寸：44x44px（最小触控区域）
/// - 图标尺寸：20-24px
/// - 圆角：8px
///
/// 【使用示例】
/// ```dart
/// // 填充样式
/// IconButton(
///   icon: CupertinoIcons.plus,
///   onPressed: () => _add(),
/// )
///
/// // 描边样式
/// IconButton.outlined(
///   icon: CupertinoIcons.heart,
///   onPressed: () => _like(),
/// )
///
/// // 幽灵样式
/// IconButton.ghost(
///   icon: CupertinoIcons.share,
///   onPressed: () => _share(),
/// )
///
/// // 带徽章
/// Stack(
///   children: [
///     IconButton(
///       icon: CupertinoIcons.bell,
///       onPressed: () => _notifications(),
///     ),
///     Positioned(
///       right: 8,
///       top: 8,
///       child: Container(
///         width: 8,
///         height: 8,
///         decoration: BoxDecoration(
///           color: AppColors.error,
///           shape: BoxShape.circle,
///         ),
///       ),
///     ),
///   ],
/// )
/// ```
enum IconButtonStyle { filled, outlined, ghost }

class AppIconButton extends StatefulWidget {
  /// 图标 Widget
  final Widget icon;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 按钮样式
  final IconButtonStyle style;

  /// 按钮尺寸
  final double size;

  /// 图标尺寸
  final double iconSize;

  /// 背景颜色（filled 样式）
  final Color? backgroundColor;

  /// 图标颜色
  final Color? iconColor;

  /// 边框颜色（outlined 样式）
  final Color? borderColor;

  /// 是否圆形
  final bool circular;

  /// 自定义圆角（非圆形时）
  final double? borderRadius;

  /// 扩展 Widget（替换图标）
  final Widget? child;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.style = IconButtonStyle.filled,
    this.size = 44,
    this.iconSize = 22,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.circular = true,
    this.borderRadius,
  }) : child = null;

  const AppIconButton.child({
    super.key,
    required this.child,
    this.onPressed,
    this.style = IconButtonStyle.filled,
    this.size = 44,
    this.backgroundColor,
    this.borderColor,
    this.circular = true,
    this.borderRadius,
  })  : icon = const SizedBox.shrink(),
        iconSize = 22;

  /// 填充样式工厂构造
  factory AppIconButton.filled({
    Key? key,
    required Widget icon,
    VoidCallback? onPressed,
    double size = 44,
    double iconSize = 22,
    Color? backgroundColor,
    Color? iconColor,
    bool circular = true,
    double? borderRadius,
  }) {
    return AppIconButton(
      key: key,
      icon: icon,
      onPressed: onPressed,
      style: IconButtonStyle.filled,
      size: size,
      iconSize: iconSize,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      circular: circular,
      borderRadius: borderRadius,
    );
  }

  /// 描边样式工厂构造
  factory AppIconButton.outlined({
    Key? key,
    required Widget icon,
    VoidCallback? onPressed,
    double size = 44,
    double iconSize = 22,
    Color? borderColor,
    Color? iconColor,
    bool circular = true,
    double? borderRadius,
  }) {
    return AppIconButton(
      key: key,
      icon: icon,
      onPressed: onPressed,
      style: IconButtonStyle.outlined,
      size: size,
      iconSize: iconSize,
      borderColor: borderColor,
      iconColor: iconColor,
      circular: circular,
      borderRadius: borderRadius,
    );
  }

  /// 幽灵样式工厂构造
  factory AppIconButton.ghost({
    Key? key,
    required Widget icon,
    VoidCallback? onPressed,
    double size = 44,
    double iconSize = 22,
    Color? iconColor,
    bool circular = true,
    double? borderRadius,
  }) {
    return AppIconButton(
      key: key,
      icon: icon,
      onPressed: onPressed,
      style: IconButtonStyle.ghost,
      size: size,
      iconSize: iconSize,
      iconColor: iconColor,
      circular: circular,
      borderRadius: borderRadius,
    );
  }

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = widget.onPressed == null;

    // 根据样式计算颜色
    Color bgColor;
    Color borderColor;
    Color fgColor;

    switch (widget.style) {
      case IconButtonStyle.filled:
        bgColor = widget.backgroundColor ?? AppColors.primary;
        borderColor = Colors.transparent;
        fgColor = widget.iconColor ?? Colors.white;
        break;
      case IconButtonStyle.outlined:
        bgColor = Colors.transparent;
        borderColor = widget.borderColor ??
            (isDark ? AppColors.darkSeparator : AppColors.lightSeparator);
        fgColor = widget.iconColor ?? AppColors.primary;
        break;
      case IconButtonStyle.ghost:
        bgColor = Colors.transparent;
        borderColor = Colors.transparent;
        fgColor = widget.iconColor ??
            (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary);
        break;
    }

    final radius = widget.circular
        ? widget.size / 2
        : (widget.borderRadius ?? AppRadius.buttonIcon);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onPressed,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isDisabled ? 0.5 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: borderColor,
                width: widget.style == IconButtonStyle.outlined ? 1 : 0,
              ),
            ),
            child: Center(
              child: widget.child ??
                  IconTheme(
                    data: IconThemeData(
                      size: widget.iconSize,
                      color: fgColor,
                    ),
                    child: widget.icon,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 常用图标按钮快捷方式
class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;

  const AppBackButton({
    super.key,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppIconButton(
      icon: const Icon(CupertinoIcons.back),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      style: IconButtonStyle.ghost,
      iconColor: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
    );
  }
}

class AppCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;

  const AppCloseButton({
    super.key,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppIconButton(
      icon: const Icon(CupertinoIcons.xmark),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      style: IconButtonStyle.ghost,
      iconColor: color ?? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
    );
  }
}
