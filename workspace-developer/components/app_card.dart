import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 卡片组件
/// 支持点击效果、多种背景色、阴影配置
///
/// 【样式规范】
/// - 圆角：16px
/// - 内边距：16px
/// - 阴影：浅色模式轻度阴影 / 深色模式无阴影
///
/// 【使用示例】
/// ```dart
/// // 基础卡片
/// AppCard(
///   child: Column(
///     crossAxisAlignment: CrossAxisAlignment.start,
///     children: [
///       Text('标题', style: Theme.of(context).textTheme.titleLarge),
///       const SizedBox(height: 8),
///       Text('内容描述...'),
///     ],
///   ),
/// )
///
/// // 可点击卡片
/// AppCard(
///   onTap: () => _navigateToDetail(),
///   child: Row(
///     children: [
///       Icon(CupertinoIcons.chevron_right),
///       Expanded(child: Text('查看详情')),
///     ],
///   ),
/// )
///
/// // 带边框卡片（深色模式风格）
/// AppCard(
///   useBorder: true,
///   child: Text('带边框的卡片'),
/// )
///
/// // 紧凑卡片
/// AppCard(
///   padding: EdgeInsets.all(AppSpacing.sm),
///   child: Text('紧凑内容'),
/// )
/// ```
class AppCard extends StatelessWidget {
  /// 卡片内容
  final Widget child;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 点击回调
  final VoidCallback? onTap;

  /// 背景颜色（覆盖自动适配）
  final Color? backgroundColor;

  /// 是否使用边框代替阴影（深色模式建议开启）
  final bool useBorder;

  /// 是否使用阴影（浅色模式）
  final bool useShadow;

  /// 圆角
  final double? borderRadius;

  /// 阴影颜色
  final Color? shadowColor;

  /// 阴影模糊半径
  final double? shadowBlurRadius;

  /// 阴影偏移
  final Offset? shadowOffset;

  /// 自定义装饰器（覆盖默认装饰）
  final BoxDecoration? decoration;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.useBorder = false,
    this.useShadow = true,
    this.borderRadius,
    this.shadowColor,
    this.shadowBlurRadius,
    this.shadowOffset,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBorderRadius = borderRadius ?? AppRadius.card;

    // 计算装饰
    BoxDecoration? effectiveDecoration;

    if (decoration != null) {
      effectiveDecoration = decoration;
    } else {
      Color? effectiveBgColor;
      List<BoxShadow>? boxShadow;
      Border? border;

      if (backgroundColor != null) {
        effectiveBgColor = backgroundColor;
      } else {
        effectiveBgColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
      }

      // 阴影或边框
      if (isDark || useBorder) {
        // 深色模式或强制使用边框：不使用阴影
        border = Border.all(
          color: isDark
              ? AppColors.darkSeparator
              : AppColors.lightSeparator,
          width: 0.5,
        );
      } else if (useShadow) {
        // 浅色模式使用阴影
        boxShadow = [
          BoxShadow(
            color: shadowColor ?? Colors.black.withOpacity(0.06),
            blurRadius: shadowBlurRadius ?? 10,
            offset: shadowOffset ?? const Offset(0, 2),
          ),
        ];
      }

      effectiveDecoration = BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        boxShadow: boxShadow,
        border: border,
      );
    }

    // 构建卡片 Widget
    Widget card = Container(
      decoration: effectiveDecoration,
      child: padding != null
          ? Padding(padding: padding!, child: child)
          : child,
    );

    // 如果有点击回调，包裹 InkWell
    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          child: card,
        ),
      );
    }

    return card;
  }
}

/// App 大卡片组件
class AppCardLarge extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const AppCardLarge({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderRadius: AppRadius.cardLarge,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark ? AppColors.darkSurface : AppColors.lightSurface),
        borderRadius: BorderRadius.circular(AppRadius.cardLarge),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: child,
    );
  }
}

/// App 分组卡片（带标题）
class AppCardSection extends StatelessWidget {
  /// 分组标题
  final String? title;

  /// 标题 Widget（优先级高于 title）
  final Widget? titleWidget;

  /// 卡片内容
  final Widget child;

  /// 分组卡片列表
  final List<Widget>? children;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 标题与内容的间距
  final double? gap;

  const AppCardSection({
    super.key,
    this.title,
    this.titleWidget,
    required this.child,
    this.children,
    this.padding,
    this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null || titleWidget != null) ...[
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.xs,
              bottom: AppSpacing.xs,
            ),
            child: titleWidget ??
                Text(
                  title!,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
          ),
        ],
        AppCard(
          padding: padding ?? const EdgeInsets.all(AppSpacing.md),
          child: children != null ? Column(children: children!) : child,
        ),
      ],
    );
  }
}
