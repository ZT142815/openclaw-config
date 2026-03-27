import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

/// App 加载指示器组件
/// 支持多种样式、大小、自定义内容
///
/// 【使用示例】
/// ```dart
/// // 全屏加载
/// AppLoading.show(context)
///
/// // 关闭全屏加载
/// AppLoading.hide(context)
///
/// // 局部加载
/// AppLoading.line()
///
/// // 骨架屏效果
/// AppLoading.skeleton(
///   child: Container(
///     width: 200,
///     height: 20,
///     color: Colors.grey,
///   ),
/// )
/// ```
class AppLoading extends StatelessWidget {
  /// 加载指示器类型
  final LoadingStyle style;

  /// 尺寸
  final LoadingSize size;

  /// 颜色
  final Color? color;

  /// 自定义颜色（用于深色/浅色模式）
  final Color? lightColor;
  final Color? darkColor;

  /// 文字提示
  final String? message;

  /// 圆角（骨架屏用）
  final double? borderRadius;

  const AppLoading({
    super.key,
    this.style = LoadingStyle.cupertino,
    this.size = LoadingSize.medium,
    this.color,
    this.lightColor,
    this.darkColor,
    this.message,
    this.borderRadius,
  });

  /// 获取尺寸数值
  double get _sizeValue {
    switch (size) {
      case LoadingSize.small:
        return 16;
      case LoadingSize.medium:
        return 24;
      case LoadingSize.large:
        return 32;
      case LoadingSize.xlarge:
        return 48;
    }
  }

  /// 获取颜色
  Color _getColor(BuildContext context) {
    if (color != null) return color!;
    if (lightColor != null && darkColor != null) {
      return Theme.of(context).brightness == Brightness.dark
          ? darkColor!
          : lightColor!;
    }
    // 默认颜色
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = _getColor(context);
    final effectiveSize = _sizeValue;

    switch (style) {
      case LoadingStyle.cupertino:
        return CupertinoActivityIndicator(
          radius: effectiveSize / 2,
          color: effectiveColor,
        );

      case LoadingStyle.material:
        return SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
          ),
        );

      case LoadingStyle.linear:
        return SizedBox(
          width: effectiveSize * 4,
          height: effectiveSize / 2,
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            backgroundColor: effectiveColor.withOpacity(0.2),
          ),
        );

      case LoadingStyle.pulse:
        return _PulseLoading(
          size: effectiveSize,
          color: effectiveColor,
        );

      case LoadingStyle.threeBounce:
        return _ThreeBounceLoading(
          size: effectiveSize / 2,
          color: effectiveColor,
        );

      case LoadingStyle.spinner:
        return _SpinnerLoading(
          size: effectiveSize,
          color: effectiveColor,
        );
    }
  }

  /// 显示全屏加载
  static void show(
    BuildContext context, {
    LoadingStyle style = LoadingStyle.cupertino,
    LoadingSize size = LoadingSize.large,
    String? message,
    Color? color,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black54,
      builder: (context) => PopScope(
        canPop: barrierDismissible,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppLoading(
                  style: style,
                  size: size,
                  color: color,
                ),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 隐藏全屏加载
  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 骨架屏加载效果
  static Widget skeleton({
    double? width,
    double? height,
    double? borderRadius,
    Color? shimmerColor,
    Color? baseColor,
  }) {
    return _SkeletonBox(
      width: width,
      height: height,
      borderRadius: borderRadius,
      shimmerColor: shimmerColor,
      baseColor: baseColor,
    );
  }

  /// 骨架屏文本效果
  static Widget skeletonText({
    double? width,
    int lines = 1,
    double lineHeight = 16,
    double spacing = 8,
    Color? shimmerColor,
    Color? baseColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(lines, (index) {
        final isLast = index == lines - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : spacing),
          child: _SkeletonBox(
            width: isLast ? width! * 0.6 : width,
            height: lineHeight,
            shimmerColor: shimmerColor,
            baseColor: baseColor,
          ),
        );
      }),
    );
  }
}

/// 加载样式枚举
enum LoadingStyle {
  cupertino,
  material,
  linear,
  pulse,
  threeBounce,
  spinner,
}

/// 加载尺寸枚举
enum LoadingSize { small, medium, large, xlarge }

/// 脉冲动画加载
class _PulseLoading extends StatefulWidget {
  final double size;
  final Color color;

  const _PulseLoading({
    required this.size,
    required this.color,
  });

  @override
  State<_PulseLoading> createState() => _PulseLoadingState();
}

class _PulseLoadingState extends State<_PulseLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}

/// 三点跳动加载
class _ThreeBounceLoading extends StatefulWidget {
  final double size;
  final Color color;

  const _ThreeBounceLoading({
    required this.size,
    required this.color,
  });

  @override
  State<_ThreeBounceLoading> createState() => _ThreeBounceLoadingState();
}

class _ThreeBounceLoadingState extends State<_ThreeBounceLoading>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    // 依次启动动画
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.size / 4),
          child: AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_animations[index].value * widget.size * 0.5),
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(
                      0.4 + _animations[index].value * 0.6,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

/// 旋转加载
class _SpinnerLoading extends StatefulWidget {
  final double size;
  final Color color;

  const _SpinnerLoading({
    required this.size,
    required this.color,
  });

  @override
  State<_SpinnerLoading> createState() => _SpinnerLoadingState();
}

class _SpinnerLoadingState extends State<_SpinnerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.color.withOpacity(0.2),
            width: 3,
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 3,
            height: widget.size / 3,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}

/// 骨架屏盒子
class _SkeletonBox extends StatefulWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? shimmerColor;
  final Color? baseColor;

  const _SkeletonBox({
    this.width,
    this.height,
    this.borderRadius,
    this.shimmerColor,
    this.baseColor,
  });

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(
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
    final baseColor = widget.baseColor ??
        (isDark ? AppColors.darkSurfaceTertiary : AppColors.lightSeparator);
    final shimmerColor = widget.shimmerColor ??
        (isDark
            ? AppColors.darkSurfaceElevated
            : AppColors.lightSurface);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 4),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                baseColor,
                shimmerColor,
                baseColor,
              ],
              stops: [
                _animation.value - 1,
                _animation.value,
                _animation.value + 1,
              ].map((s) => s.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}
