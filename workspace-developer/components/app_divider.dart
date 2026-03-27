import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// App 分割线组件
/// 支持水平/垂直、实线/虚线、带缩进
///
/// 【使用示例】
/// ```dart
/// // 基础水平分割线
/// AppDivider()
///
/// // 带缩进
/// AppDivider(indent: 16)
/// AppDivider(indent: 16, endIndent: 16)
///
/// // 虚线
/// AppDivider.dashed()
///
/// // 垂直分割线
/// AppDivider.vertical()
/// AppDivider.vertical(height: 60)
///
/// // 自定义样式
/// AppDivider(
///   thickness: 2,
///   color: Colors.grey,
/// )
/// ```
class AppDivider extends StatelessWidget {
  /// 方向
  final Axis direction;

  /// 厚度
  final double thickness;

  /// 颜色
  final Color? color;

  /// 缩进（水平方向为左边距，垂直方向为上边距）
  final double indent;

  /// 结束缩进（水平方向为右边距，垂直方向为下边距）
  final double endIndent;

  /// 是否虚线
  final bool dashed;

  /// 虚线线段长度
  final double dashWidth;

  /// 虚线间隙长度
  final double dashSpace;

  /// 边距
  final EdgeInsets? margin;

  /// 分隔线类型
  final DividerType? type;

  const AppDivider({
    super.key,
    this.direction = Axis.horizontal,
    this.thickness = 0.5,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.dashed = false,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.margin,
    this.type,
  });

  /// 水平分割线
  const AppDivider.horizontal({
    super.key,
    this.thickness = 0.5,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.dashed = false,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.margin,
  }) : direction = Axis.horizontal;

  /// 垂直分割线
  const AppDivider.vertical({
    super.key,
    this.thickness = 0.5,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.dashed = false,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.margin,
  }) : direction = Axis.vertical;

  /// 虚线分割线
  const AppDivider.dashed({
    super.key,
    this.direction = Axis.horizontal,
    this.thickness = 0.5,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.margin,
  })  : dashed = true,
        type = null;

  /// 创建分隔线
  factory AppDivider.create({
    Key? key,
    Axis direction = Axis.horizontal,
    double thickness = 0.5,
    Color? color,
    double indent = 0,
    double endIndent = 0,
    bool dashed = false,
    double dashWidth = 5,
    double dashSpace = 3,
    EdgeInsets? margin,
  }) {
    return AppDivider(
      key: key,
      direction: direction,
      thickness: thickness,
      color: color,
      indent: indent,
      endIndent: endIndent,
      dashed: dashed,
      dashWidth: dashWidth,
      dashSpace: dashSpace,
      margin: margin,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ??
        (isDark ? AppColors.darkSeparator : AppColors.lightSeparator);

    Widget divider;
    if (dashed) {
      divider = CustomPaint(
        size: direction == Axis.horizontal
            ? Size(double.infinity, thickness)
            : Size(thickness, double.infinity),
        painter: _DashedLinePainter(
          direction: direction,
          color: effectiveColor,
          strokeWidth: thickness,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          indent: indent,
          endIndent: endIndent,
        ),
      );
    } else {
      divider = Container(
        width: direction == Axis.horizontal ? null : thickness,
        height: direction == Axis.horizontal ? thickness : null,
        color: effectiveColor,
        margin: EdgeInsets.only(
          left: direction == Axis.horizontal ? indent : 0,
          right: direction == Axis.horizontal ? endIndent : 0,
          top: direction == Axis.vertical ? indent : 0,
          bottom: direction == Axis.vertical ? endIndent : 0,
        ),
      );
    }

    if (margin != null) {
      return Padding(
        padding: margin!,
        child: divider,
      );
    }

    return divider;
  }
}

/// 分隔线类型
enum DividerType {
  /// 标准分隔线
  standard,

  /// 粗分隔线（分组标题上方）
  section,

  /// 轻分隔线
  light,

  /// 中分隔线
  medium,

  /// 重分隔线
  heavy,
}

/// 虚线绘制器
class _DashedLinePainter extends CustomPainter {
  final Axis direction;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double indent;
  final double endIndent;

  _DashedLinePainter({
    required this.direction,
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (direction == Axis.horizontal) {
      double startX = indent;
      final endX = size.width - endIndent;

      while (startX < endX) {
        canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset((startX + dashWidth).clamp(0, endX), size.height / 2),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    } else {
      double startY = indent;
      final endY = size.height - endIndent;

      while (startY < endY) {
        canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(size.width / 2, (startY + dashWidth).clamp(0, endY)),
          paint,
        );
        startY += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) {
    return oldDelegate.direction != direction ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent;
  }
}

/// App 分隔线列表
/// 用于快速创建带分隔线的列表
class AppDividerList extends StatelessWidget {
  /// 子组件列表
  final List<Widget> children;

  /// 分隔线颜色
  final Color? color;

  /// 分隔线厚度
  final double thickness;

  /// 分隔线缩进
  final double indent;

  /// 分隔线结束缩进
  final double endIndent;

  /// 是否虚线
  final bool dashed;

  /// 是否在最后一项后添加分隔线
  final bool showDividerAfterLast;

  const AppDividerList({
    super.key,
    required this.children,
    this.color,
    this.thickness = 0.5,
    this.indent = 16,
    this.endIndent = 0,
    this.dashed = false,
    this.showDividerAfterLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    final result = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);

      final isLast = i == children.length - 1;
      if (!isLast || showDividerAfterLast) {
        result.add(
          AppDivider(
            indent: indent,
            endIndent: endIndent,
            color: color,
            thickness: thickness,
            dashed: dashed,
          ),
        );
      }
    }

    return result;
  }
}

/// App 分组分割线
/// 带有标题的分割线组合
class AppGroupDivider extends StatelessWidget {
  /// 标题
  final String? title;

  /// 标题 Widget
  final Widget? titleWidget;

  /// 下方内容
  final Widget? child;

  /// 标题对齐
  final CrossAxisAlignment titleAlignment;

  /// 上边距
  final double topMargin;

  /// 下边距
  final double bottomMargin;

  /// 分割线颜色
  final Color? color;

  const AppGroupDivider({
    super.key,
    this.title,
    this.titleWidget,
    this.child,
    this.titleAlignment = CrossAxisAlignment.start,
    this.topMargin = 24,
    this.bottomMargin = 8,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ??
        (isDark ? AppColors.darkSeparator : AppColors.lightSeparator);

    return Column(
      crossAxisAlignment: titleAlignment,
      children: [
        SizedBox(height: topMargin),
        if (title != null || titleWidget != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: titleWidget ??
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppDivider(
            color: effectiveColor,
            thickness: 0.5,
          ),
        ],
        if (child != null) ...[
          const SizedBox(height: bottomMargin),
          child!,
        ],
      ],
    );
  }
}
