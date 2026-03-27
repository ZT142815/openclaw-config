import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 进度组件
/// 支持线性进度条、圆形进度指示器、百分比显示
///
/// 【使用示例】
/// ```dart
/// // 线性进度条
/// AppProgress.linear(value: 0.6)
/// AppProgress.linear(
///   value: 0.3,
///   showPercentage: true,
///   height: 8,
/// )
///
/// // 圆形进度
/// AppProgress.circular(value: 0.75)
/// AppProgress.circular(
///   value: 0.5,
///   size: 60,
///   strokeWidth: 6,
///   showPercentage: true,
/// )
///
/// // 带标签
/// AppProgress.linear(
///   value: progress,
///   label: '下载中',
///   showPercentage: true,
/// )
/// ```
class AppProgress extends StatelessWidget {
  /// 进度类型
  final ProgressType type;

  /// 进度值 (0.0 - 1.0)
  final double value;

  /// 高度（线性进度条用）
  final double height;

  /// 宽度（圆形进度用）
  final double size;

  /// 线条宽度
  final double strokeWidth;

  /// 是否显示百分比
  final bool showPercentage;

  /// 是否显示动画
  final bool animated;

  /// 进度条颜色
  final Color? progressColor;

  /// 背景颜色
  final Color? backgroundColor;

  /// 标签文字
  final String? label;

  /// 标签位置
  final LabelPosition labelPosition;

  /// 圆角（线性进度条用）
  final double? borderRadius;

  /// 渐变色（优先级高于 progressColor）
  final Gradient? gradient;

  const AppProgress({
    super.key,
    this.type = ProgressType.linear,
    required this.value,
    this.height = 4,
    this.size = 40,
    this.strokeWidth = 3,
    this.showPercentage = false,
    this.animated = true,
    this.progressColor,
    this.backgroundColor,
    this.label,
    this.labelPosition = LabelPosition.right,
    this.borderRadius,
    this.gradient,
  });

  /// 线性进度条
  const AppProgress.linear({
    super.key,
    required this.value,
    this.height = 4,
    this.showPercentage = false,
    this.animated = true,
    this.progressColor,
    this.backgroundColor,
    this.label,
    this.labelPosition = LabelPosition.right,
    this.borderRadius,
    this.gradient,
  })  : type = ProgressType.linear,
        size = 40,
        strokeWidth = 3;

  /// 圆形进度
  const AppProgress.circular({
    super.key,
    required this.value,
    this.size = 40,
    this.strokeWidth = 3,
    this.showPercentage = false,
    this.animated = true,
    this.progressColor,
    this.backgroundColor,
    this.label,
    this.labelPosition = LabelPosition.bottom,
    this.borderRadius,
    this.gradient,
  })  : type = ProgressType.circular,
        height = 4;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ProgressType.linear:
        return _LinearProgress(
          value: value.clamp(0.0, 1.0),
          height: height,
          showPercentage: showPercentage,
          animated: animated,
          progressColor: progressColor,
          backgroundColor: backgroundColor,
          label: label,
          labelPosition: labelPosition,
          borderRadius: borderRadius,
          gradient: gradient,
        );
      case ProgressType.circular:
        return _CircularProgress(
          value: value.clamp(0.0, 1.0),
          size: size,
          strokeWidth: strokeWidth,
          showPercentage: showPercentage,
          animated: animated,
          progressColor: progressColor,
          backgroundColor: backgroundColor,
          label: label,
          labelPosition: labelPosition,
          gradient: gradient,
        );
    }
  }
}

/// 进度类型
enum ProgressType {
  linear,
  circular,
}

/// 标签位置
enum LabelPosition {
  left,
  right,
  top,
  bottom,
}

/// 线性进度条
class _LinearProgress extends StatelessWidget {
  final double value;
  final double height;
  final bool showPercentage;
  final bool animated;
  final Color? progressColor;
  final Color? backgroundColor;
  final String? label;
  final LabelPosition labelPosition;
  final double? borderRadius;
  final Gradient? gradient;

  const _LinearProgress({
    required this.value,
    required this.height,
    required this.showPercentage,
    required this.animated,
    this.progressColor,
    this.backgroundColor,
    this.label,
    required this.labelPosition,
    this.borderRadius,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveProgressColor =
        progressColor ?? AppColors.primary;
    final effectiveBgColor = backgroundColor ??
        (isDark
            ? AppColors.darkSurfaceTertiary
            : AppColors.lightSeparator);
    final effectiveBorderRadius = borderRadius ?? (height / 2);

    final progressWidget = Container(
      height: height,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedContainer(
                duration:
                    animated ? const Duration(milliseconds: 300) : Duration.zero,
                curve: Curves.easeInOut,
                width: constraints.maxWidth * value,
                decoration: BoxDecoration(
                  gradient: gradient,
                  color: gradient == null ? effectiveProgressColor : null,
                  borderRadius: BorderRadius.circular(effectiveBorderRadius),
                ),
              ),
            ],
          );
        },
      ),
    );

    final percentageText = '${(value * 100).toInt()}%';

    Widget content;
    if (showPercentage || label != null) {
      final children = <Widget>[];

      switch (labelPosition) {
        case LabelPosition.left:
          if (label != null) {
            children.add(Text(
              label!,
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ));
            children.add(const SizedBox(width: AppSpacing.xs));
          }
          if (showPercentage) {
            children.add(Text(
              percentageText,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ));
            children.add(const SizedBox(width: AppSpacing.xs));
          }
          children.add(Expanded(child: progressWidget));
          break;

        case LabelPosition.right:
          children.add(Expanded(child: progressWidget));
          if (showPercentage) {
            children.add(const SizedBox(width: AppSpacing.xs));
            children.add(Text(
              percentageText,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ));
          }
          if (label != null) {
            children.add(const SizedBox(width: AppSpacing.xs));
            children.add(Text(
              label!,
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ));
          }
          break;

        case LabelPosition.top:
        case LabelPosition.bottom:
          children.add(Expanded(child: progressWidget));
          break;
      }

      content = Column(
        crossAxisAlignment: labelPosition == LabelPosition.top
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (labelPosition == LabelPosition.top) ...[
            if (label != null)
              Text(
                label!,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            if (showPercentage)
              Text(
                percentageText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
            const SizedBox(height: AppSpacing.xxs),
            progressWidget,
          ] else if (labelPosition == LabelPosition.bottom) ...[
            progressWidget,
            const SizedBox(height: AppSpacing.xxs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                if (showPercentage)
                  Text(
                    percentageText,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
              ],
            ),
          ] else
            Row(children: children),
      ];
    } else {
      content = progressWidget;
    }

    return content;
  }
}

/// 圆形进度指示器
class _CircularProgress extends StatelessWidget {
  final double value;
  final double size;
  final double strokeWidth;
  final bool showPercentage;
  final bool animated;
  final Color? progressColor;
  final Color? backgroundColor;
  final String? label;
  final LabelPosition labelPosition;
  final Gradient? gradient;

  const _CircularProgress({
    required this.value,
    required this.size,
    required this.strokeWidth,
    required this.showPercentage,
    required this.animated,
    this.progressColor,
    this.backgroundColor,
    this.label,
    required this.labelPosition,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveProgressColor =
        progressColor ?? AppColors.primary;
    final effectiveBgColor = backgroundColor ??
        (isDark
            ? AppColors.darkSurfaceTertiary
            : AppColors.lightSeparator);
    final percentageText = '${(value * 100).toInt()}%';

    final progressWidget = SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value),
        duration: animated ? const Duration(milliseconds: 500) : Duration.zero,
        curve: Curves.easeInOut,
        builder: (context, animatedValue, child) {
          return CustomPaint(
            painter: _CircularProgressPainter(
              progress: animatedValue,
              progressColor: gradient == null ? effectiveProgressColor : Colors.transparent,
              backgroundColor: effectiveBgColor,
              strokeWidth: strokeWidth,
              gradient: gradient,
            ),
            child: Center(
              child: showPercentage
                  ? Text(
                      percentageText,
                      style: TextStyle(
                        fontSize: size * 0.28,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );

    if (label != null || showPercentage) {
      switch (labelPosition) {
        case LabelPosition.top:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label ?? percentageText,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              progressWidget,
            ],
          );
        case LabelPosition.bottom:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              progressWidget,
              const SizedBox(height: AppSpacing.xs),
              Text(
                label ?? percentageText,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          );
        case LabelPosition.left:
        case LabelPosition.right:
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (labelPosition == LabelPosition.left) ...[
                Text(
                  label ?? percentageText,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              progressWidget,
              if (labelPosition == LabelPosition.right) ...[
                const SizedBox(width: AppSpacing.xs),
                Text(
                  label ?? percentageText,
                  style: TextStyle(
                    fontSize: 13,
                    color: is