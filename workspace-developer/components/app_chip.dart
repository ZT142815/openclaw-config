import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';

/// App 标签/选择器组件
/// 支持选中状态、点击事件、自定义颜色
///
/// 【样式规范】
/// - 背景：15% 主色（未选中）/ 主色（选中）
/// - 文字：12px Semibold
/// - 圆角：999px（胶囊形）
/// - 内边距：10px 水平，4px 垂直
///
/// 【使用示例】
/// ```dart
/// // 筛选标签组
/// Wrap(
///   spacing: 8,
///   runSpacing: 8,
///   children: [
///     AppChip(label: '全部', selected: true),
///     AppChip(label: '已完成', onTap: () => _filter('completed')),
///     AppChip(label: '进行中', onTap: () => _filter('ongoing')),
///     AppChip(label: '已取消', onTap: () => _filter('cancelled')),
///   ],
/// )
///
/// // 自定义颜色
/// AppChip(
///   label: '热门',
///   backgroundColor: AppColors.warning.withOpacity(0.15),
///   textColor: AppColors.warning,
/// )
/// ```
class AppChip extends StatelessWidget {
  /// 标签文字
  final String label;

  /// 背景颜色（覆盖默认）
  final Color? backgroundColor;

  /// 文字颜色（覆盖默认）
  final Color? textColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 是否选中
  final bool selected;

  /// 选中时的背景颜色
  final Color? selectedBackgroundColor;

  /// 选中时的文字颜色
  final Color? selectedTextColor;

  /// 高度
  final double? height;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 圆角
  final double? borderRadius;

  /// 自定义文字样式
  final TextStyle? textStyle;

  const AppChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.selected = false,
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.height,
    this.padding,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 计算颜色
    final bgColor = selected
        ? (selectedBackgroundColor ?? AppColors.primary)
        : (backgroundColor ?? AppColors.primary15);

    final fgColor = selected
        ? (selectedTextColor ?? Colors.white)
        : (textColor ?? AppColors.primary);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height ?? 28,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.chip),
        ),
        child: Center(
          child: Text(
            label,
            style: textStyle ??
                TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: fgColor,
                ),
          ),
        ),
      ),
    );
  }
}

/// App 过滤标签组
class AppFilterChipGroup extends StatelessWidget {
  /// 标签选项列表
  final List<AppFilterOption> options;

  /// 当前选中的值
  final String? selectedValue;

  /// 选择回调
  final ValueChanged<String>? onSelected;

  /// 标签之间的间距
  final double spacing;

  /// 行之间的间距
  final double runSpacing;

  /// 对齐方式
  final WrapAlignment alignment;

  const AppFilterChipGroup({
    super.key,
    required this.options,
    this.selectedValue,
    this.onSelected,
    this.spacing = 8,
    this.runSpacing = 8,
    this.alignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      children: options.map((option) {
        return AppChip(
          label: option.label,
          selected: option.value == selectedValue,
          onTap: () => onSelected?.call(option.value),
          backgroundColor: option.backgroundColor,
          textColor: option.textColor,
          selectedBackgroundColor: option.selectedBackgroundColor,
          selectedTextColor: option.selectedTextColor,
        );
      }).toList(),
    );
  }
}

/// 过滤选项数据类
class AppFilterOption {
  final String label;
  final String value;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;

  const AppFilterOption({
    required this.label,
    required this.value,
    this.backgroundColor,
    this.textColor,
    this.selectedBackgroundColor,
    this.selectedTextColor,
  });
}

/// App 输入型 Chip（带删除按钮）
class AppInputChip extends StatelessWidget {
  /// 标签文字
  final String label;

  /// 删除回调
  final VoidCallback? onDeleted;

  /// 删除按钮图标
  final IconData? deleteIcon;

  /// 背景颜色
  final Color? backgroundColor;

  /// 文字颜色
  final Color? textColor;

  const AppInputChip({
    super.key,
    required this.label,
    this.onDeleted,
    this.deleteIcon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.primary15;
    final fgColor = textColor ?? AppColors.primary;

    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 10, right: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: fgColor,
              ),
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onDeleted,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                deleteIcon ?? CupertinoIcons.xmark_circle_fill,
                size: 16,
                color: fgColor.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// App 轮廓型 Chip
class AppOutlineChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool selected;
  final Color? borderColor;
  final Color? textColor;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;

  const AppOutlineChip({
    super.key,
    required this.label,
    this.onTap,
    this.selected = false,
    this.borderColor,
    this.textColor,
    this.selectedBackgroundColor,
    this.selectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveBorderColor = borderColor ??
        (isDark ? AppColors.darkSeparator : AppColors.lightSeparatorOpaque);
    final effectiveTextColor = textColor ??
        (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary);
    final effectiveBgColor = selected
        ? (selectedBackgroundColor ?? AppColors.primary)
        : Colors.transparent;
    final effectiveFgColor = selected
        ? (selectedTextColor ?? Colors.white)
        : effectiveTextColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: effectiveBgColor,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(
            color: selected ? Colors.transparent : effectiveBorderColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: effectiveFgColor,
            ),
          ),
        ),
      ),
    );
  }
}
