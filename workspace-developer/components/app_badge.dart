import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';

/// App 徽章组件
/// 用于显示数量、状态指示
///
/// 【使用示例】
/// ```dart
/// // 通知数量 Badge
/// Row(
///   children: [
///     Icon(CupertinoIcons.bell),
///     const SizedBox(width: 4),
///     AppBadge(count: 5),
///   ],
/// )
///
/// // 自定义最大显示
/// AppBadge(count: 150, maxCount: 99) // 显示 "99+"
///
/// // 小圆点
/// AppBadge.dot() // 无数字的小圆点
///
/// // 红点提示
/// AppBadge.indicator()
/// ```
class AppBadge extends StatelessWidget {
  /// 显示的数字（<= 0 时不显示）
  final int count;

  /// 最大显示数字（超过显示 maxCount+）
  final int maxCount;

  /// 背景颜色
  final Color? backgroundColor;

  /// 文字颜色
  final Color? textColor;

  /// 高度（用于计算大小）
  final double? height;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 自定义子 Widget
  final Widget? child;

  /// 圆角（默认圆形）
  final double? borderRadius;

  const AppBadge({
    super.key,
    required this.count,
    this.maxCount = 99,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.padding,
    this.child,
    this.borderRadius,
  });

  /// 创建带数字的徽章
  const AppBadge.count({
    super.key,
    required this.count,
    this.maxCount = 99,
    this.backgroundColor,
    this.textColor,
  })  : height = null,
        padding = null,
        child = null,
        borderRadius = null;

  /// 创建小圆点徽章（无数字）
  const AppBadge.dot({
    super.key,
    this.backgroundColor,
    this.height = 8,
    this.padding = EdgeInsets.zero,
    this.textColor = Colors.transparent,
    this.maxCount = 0,
    this.count = 0,
    this.borderRadius = null,
    this.child = null,
  });

  /// 创建无数字的徽章
  const AppBadge.countless({
    super.key,
    this.backgroundColor,
    this.height = 8,
    this.padding = EdgeInsets.zero,
    this.textColor = Colors.transparent,
    this.maxCount = 0,
    this.count = 0,
    this.borderRadius = null,
    this.child = null,
  });

  @override
  Widget build(BuildContext context) {
    // count <= 0 时不显示
    if (count <= 0) {
      return const SizedBox.shrink();
    }

    final displayCount = count > maxCount ? '$maxCount+' : '$count';
    final effectiveHeight = height ?? 18;
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 5);

    return Container(
      height: effectiveHeight,
      constraints: BoxConstraints(minWidth: effectiveHeight),
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.error,
        borderRadius: BorderRadius.circular(borderRadius ?? effectiveHeight / 2),
      ),
      child: Center(
        child: Text(
          displayCount,
          style: TextStyle(
            fontSize: effectiveHeight * 0.65,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}

/// App 状态徽章（带文字）
class AppStatusBadge extends StatelessWidget {
  /// 状态文字
  final String text;

  /// 背景颜色
  final Color? backgroundColor;

  /// 文字颜色
  final Color? textColor;

  /// 尺寸大小
  final BadgeSize size;

  const AppStatusBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.size = BadgeSize.small,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 根据尺寸计算样式
    double fontSize;
    EdgeInsets padding;
    Color bgColor;
    Color fgColor;

    switch (size) {
      case BadgeSize.small:
        fontSize = 10;
        padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
        bgColor = backgroundColor ??
            (isDark ? AppColors.darkSurfaceTertiary : AppColors.lightSurfaceTertiary);
        fgColor = textColor ??
            (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary);
        break;
      case BadgeSize.medium:
        fontSize = 12;
        padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 3);
        bgColor = backgroundColor ??
            (isDark ? AppColors.darkSurfaceTertiary : AppColors.lightSurfaceTertiary);
        fgColor = textColor ??
            (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary);
        break;
      case BadgeSize.large:
        fontSize = 13;
        padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
        bgColor = backgroundColor ?? AppColors.primary15;
        fgColor = textColor ?? AppColors.primary;
        break;
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: fgColor,
        ),
      ),
    );
  }
}

/// 徽章尺寸枚举
enum BadgeSize { small, medium, large }

/// App 带徽章的图标按钮
class AppIconBadge extends StatelessWidget {
  /// 图标
  final Widget icon;

  /// 徽章数量（<= 0 不显示）
  final int count;

  /// 徽章位置
  final BadgePosition position;

  /// 徽章偏移
  final Offset offset;

  /// 徽章最大显示数
  final int maxCount;

  /// 徽章背景颜色
  final Color? badgeColor;

  const AppIconBadge({
    super.key,
    required this.icon,
    this.count = 0,
    this.position = BadgePosition.topRight,
    this.offset = Offset.zero,
    this.maxCount = 99,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 0) {
      return icon;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        Positioned(
          top: position.isTop ? -4 + offset.dy : null,
          bottom: position.isBottom ? -4 - offset.dy : null,
          right: position.isRight ? -4 + offset.dx : null,
          left: position.isLeft ? -4 - offset.dx : null,
          child: AppBadge(
            count: count,
            maxCount: maxCount,
            backgroundColor: badgeColor,
          ),
        ),
      ],
    );
  }
}

/// 徽章位置枚举
enum BadgePosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

extension BadgePositionExtension on BadgePosition {
  bool get isTop => this == topLeft || this == topRight;
  bool get isBottom => this == bottomLeft || this == bottomRight;
  bool get isLeft => this == topLeft || this == bottomLeft;
  bool get isRight => this == topRight || this == bottomRight;
}

/// App 红点提示徽章
class AppDotBadge extends StatelessWidget {
  /// 大小
  final double size;

  /// 颜色
  final Color? color;

  /// 是否显示
  final bool visible;

  const AppDotBadge({
    super.key,
    this.size = 8,
    this.color,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? AppColors.error,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// App 消息气泡（用于聊天等场景）
class AppBubbleBadge extends StatelessWidget {
  /// 显示的文字或数字
  final String content;

  /// 最大数字
  final int? maxNumber;

  /// 背景颜色
  final Color? backgroundColor;

  /// 文字颜色
  final Color? textColor;

  const AppBubbleBadge({
    super.key,
    required this.content,
    this.maxNumber,
    this.backgroundColor,
    this.textColor,
  });

  /// 从数字创建
  const AppBubbleBadge.number(
    int count, {
    super.key,
    int? maxNumber,
    Color? backgroundColor,
    Color? textColor,
  })  : content = '',
        backgroundColor = backgroundColor,
        textColor = textColor;

  @override
  Widget build(BuildContext context) {
    String displayText;
    if (content.isEmpty && maxNumber != null) {
      // 数字模式
      final intCount = int.tryParse(content) ?? 0;
      displayText = intCount > maxNumber! ? '$maxNumber+' : content;
    } else {
      displayText = content;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.error,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
