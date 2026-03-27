import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 次按钮组件
/// 边框样式，用于次要操作
///
/// 【样式规范】
/// - 高度：50px
/// - 圆角：12px
/// - 背景：透明
/// - 边框：1px 主色
/// - 文字：17px Semibold 主色
/// - 禁用：50% 透明度
///
/// 【使用示例】
/// ```dart
/// // 基础用法
/// SecondaryButton(
///   text: '取消',
///   onPressed: () => _cancel(),
/// )
///
/// // 完整宽度
/// SecondaryButton(
///   text: '了解更多',
///   isFullWidth: true,
///   onPressed: () => _learnMore(),
/// )
/// ```
class SecondaryButton extends StatefulWidget {
  /// 按钮文字
  final String text;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 是否占满宽度
  final bool isFullWidth;

  /// 自定义高度
  final double? height;

  /// 自定义圆角
  final double? borderRadius;

  /// 自定义边框颜色
  final Color? borderColor;

  /// 自定义文字颜色
  final Color? textColor;

  /// 是否使用虚线边框
  final bool dashed;

  /// 扩展 Widget（替换文字）
  final Widget? child;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFullWidth = false,
    this.height,
    this.borderRadius,
    this.borderColor,
    this.textColor,
    this.dashed = false,
    this.child,
  }) : child = null;

  const SecondaryButton.icon({
    super.key,
    required this.child,
    this.onPressed,
    this.isFullWidth = false,
    this.height,
    this.borderRadius,
    this.borderColor,
  }) : text = '';

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
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
    final height = widget.height ?? AppSpacing.buttonHeightPrimary;
    final radius = widget.borderRadius ?? AppRadius.buttonSecondary;
    final borderColor = widget.borderColor ?? AppColors.primary;
    final textColor = widget.textColor ?? AppColors.primary;

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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.isFullWidth ? double.infinity : null,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: widget.dashed
                ? Border.all(
                    color: isDisabled
                        ? borderColor.withOpacity(0.5)
                        : borderColor,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignInside,
                  )
                : Border.all(
                    color: isDisabled
                        ? borderColor.withOpacity(0.5)
                        : borderColor,
                    width: 1,
                  ),
            color: isDark
                ? AppColors.darkSurfaceElevated.withOpacity(isDisabled ? 0.3 : 0.5)
                : Colors.transparent,
          ),
          child: Center(
            child: widget.child ??
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: isDisabled ? textColor.withOpacity(0.5) : textColor,
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

/// 次按钮简洁版 - 使用 OutlinedButton
class SecondaryButtonSimple extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final double? height;

  const SecondaryButtonSimple({
    super.key,
    required this.text,
    this.onPressed,
    this.isFullWidth = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height ?? AppSpacing.buttonHeightPrimary,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonSecondary),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
