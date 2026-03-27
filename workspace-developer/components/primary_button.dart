import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 主按钮组件
/// 支持渐变背景、阴影效果、按压动效、加载状态
///
/// 【样式规范】
/// - 高度：50px
/// - 圆角：12px
/// - 背景：主色渐变
/// - 文字：17px Semibold 白色
/// - 禁用：50% 透明度
///
/// 【使用示例】
/// ```dart
/// // 基础用法
/// PrimaryButton(
///   text: '登录',
///   onPressed: () => _login(),
/// )
///
/// // 完整宽度
/// PrimaryButton(
///   text: '注册',
///   isFullWidth: true,
///   onPressed: () => _register(),
/// )
///
/// // 加载状态
/// PrimaryButton(
///   text: '提交',
///   isLoading: _isLoading,
///   onPressed: _isLoading ? null : _submit,
/// )
/// ```
class PrimaryButton extends StatefulWidget {
  /// 按钮文字
  final String text;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 是否显示加载状态
  final bool isLoading;

  /// 是否占满宽度
  final bool isFullWidth;

  /// 是否使用渐变背景
  final bool useGradient;

  /// 自定义高度
  final double? height;

  /// 自定义圆角
  final double? borderRadius;

  /// 自定义文字颜色
  final Color? textColor;

  /// 自定义背景颜色（不使用渐变时）
  final Color? backgroundColor;

  /// 扩展 Widget（替换文字）
  final Widget? child;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.useGradient = true,
    this.height,
    this.borderRadius,
    this.textColor,
    this.backgroundColor,
    this.child,
  }) : child = null;

  const PrimaryButton.icon({
    super.key,
    required this.child,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.useGradient = true,
    this.height,
    this.borderRadius,
  }) : text = '';

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

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

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    _controller.reverse();
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = widget.onPressed == null || widget.isLoading;
    final height = widget.height ?? AppSpacing.buttonHeightPrimary;
    final radius = widget.borderRadius ?? AppRadius.buttonPrimary;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: isDisabled ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.isFullWidth ? double.infinity : null,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: widget.useGradient && !isDisabled
                ? (isDark
                    ? AppColors.primaryGradient
                    : AppColors.primaryGradient)
                : null,
            color: widget.useGradient
                ? null
                : (widget.backgroundColor ?? AppColors.primary),
            boxShadow: isDisabled
                ? null
                : [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(_isPressed ? 0.5 : 0.3),
                      blurRadius: _isPressed ? 8 : 12,
                      offset: Offset(0, _isPressed ? 2 : 4),
                    ),
                  ],
          ),
          child: Center(
            child: widget.isLoading
                ? const CupertinoActivityIndicator(color: Colors.white)
                : widget.child ??
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: widget.textColor ?? Colors.white,
                        ),
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}

/// PrimaryButton 简洁版 - 不带渐变
class PrimaryButtonSimple extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final double? height;

  const PrimaryButtonSimple({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height ?? AppSpacing.buttonHeightPrimary,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor:
              isDark ? AppColors.primary.withOpacity(0.3) : AppColors.primary.withOpacity(0.5),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttonPrimary),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
        child: isLoading
            ? const CupertinoActivityIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
