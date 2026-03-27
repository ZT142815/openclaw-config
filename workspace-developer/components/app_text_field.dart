import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 文本输入框组件
/// 支持标签、错误提示、前后缀图标、密码显示切换
///
/// 【样式规范】
/// - 圆角：10px
/// - 内边距：12px 水平，14px 垂直
/// - 背景：Surface Elevated 色
/// - 聚焦时显示主色边框
///
/// 【使用示例】
/// ```dart
/// // 基础输入框
/// AppTextField(
///   controller: _emailController,
///   placeholder: '请输入邮箱',
///   label: '邮箱',
///   keyboardType: TextInputType.emailAddress,
/// )
///
/// // 密码输入框
/// AppTextField(
///   controller: _passwordController,
///   placeholder: '请输入密码',
///   label: '密码',
///   obscureText: _obscurePassword,
///   prefix: Icon(CupertinoIcons.lock, color: Colors.grey),
///   suffix: IconButton(
///     icon: Icon(_obscurePassword
///         ? CupertinoIcons.eye
///         : CupertinoIcons.eye_slash),
///     onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
///   ),
/// )
///
/// // 错误状态
/// AppTextField(
///   controller: _codeController,
///   placeholder: '请输入验证码',
///   errorText: _errorMessage,
/// )
/// ```
class AppTextField extends StatefulWidget {
  /// 文本控制器
  final TextEditingController? controller;

  /// 占位符文字
  final String? placeholder;

  /// 标签文字
  final String? label;

  /// 标签 Widget（优先级高于 label）
  final Widget? labelWidget;

  /// 是否隐藏输入（密码模式）
  final bool obscureText;

  /// 键盘类型
  final TextInputType? keyboardType;

  /// 文本变化回调
  final ValueChanged<String>? onChanged;

  /// 编辑完成回调
  final VoidCallback? onEditingComplete;

  /// 提交回调
  final ValueChanged<String>? onSubmitted;

  /// 前缀 Widget
  final Widget? prefix;

  /// 后缀 Widget
  final Widget? suffix;

  /// 是否自动聚焦
  final bool autofocus;

  /// FocusNode
  final FocusNode? focusNode;

  /// 错误提示文字
  final String? errorText;

  /// 是否可编辑
  final bool readOnly;

  /// 最大行数
  final int? maxLines;

  /// 最大字符数
  final int? maxLength;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 输入框高度（覆盖默认高度）
  final double? height;

  /// 背景颜色
  final Color? backgroundColor;

  /// 圆角
  final double? borderRadius;

  /// 样式覆盖
  final TextStyle? style;

  /// 聚焦边框颜色
  final Color? focusedBorderColor;

  /// 是否显示计数
  final bool showCounter;

  const AppTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.labelWidget,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.prefix,
    this.suffix,
    this.autofocus = false,
    this.focusNode,
    this.errorText,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.height,
    this.backgroundColor,
    this.borderRadius,
    this.style,
    this.focusedBorderColor,
    this.showCounter = false,
  }) : labelWidget = null;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasError = widget.errorText != null;
    final effectiveBgColor = widget.backgroundColor ??
        (isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurface);
    final effectiveBorderRadius = widget.borderRadius ?? AppRadius.input;

    // 计算边框颜色
    Color borderColor;
    if (hasError) {
      borderColor = AppColors.error;
    } else if (_isFocused) {
      borderColor = widget.focusedBorderColor ?? AppColors.primary;
    } else {
      borderColor = Colors.transparent;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 标签
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],

        // 输入框容器
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height ?? (widget.maxLines != 1 ? null : AppSpacing.inputHeight),
          constraints: widget.maxLines != 1
              ? BoxConstraints(minHeight: widget.height ?? AppSpacing.inputHeight)
              : null,
          decoration: BoxDecoration(
            color: effectiveBgColor,
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // 前缀
              if (widget.prefix != null)
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.sm),
                  child: widget.prefix,
                ),

              // 输入框
              Expanded(
                child: CupertinoTextField(
                  controller: widget.controller,
                  placeholder: widget.placeholder,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete,
                  onSubmitted: widget.onSubmitted,
                  autofocus: widget.autofocus,
                  focusNode: _focusNode,
                  readOnly: widget.readOnly,
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  textAlign: widget.textAlign,
                  style: widget.style ??
                      TextStyle(
                        fontSize: 17,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                  placeholderStyle: TextStyle(
                    fontSize: 17,
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextSecondary,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.prefix != null ? AppSpacing.xs : AppSpacing.sm,
                    vertical: 14,
                  ),
                ),
              ),

              // 后缀
              if (widget.suffix != null)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: widget.suffix,
                ),

              // 字符计数
              if (widget.showCounter && widget.maxLength != null)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Text(
                    '${widget.controller?.text.length ?? 0}/${widget.maxLength}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // 错误提示
        if (hasError) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.errorText!,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}

/// App 密码输入框（带显示/隐藏切换）
class AppPasswordField extends StatefulWidget {
  /// 文本控制器
  final TextEditingController? controller;

  /// 占位符文字
  final String? placeholder;

  /// 标签文字
  final String? label;

  /// 文本变化回调
  final ValueChanged<String>? onChanged;

  /// 编辑完成回调
  final VoidCallback? onEditingComplete;

  /// 提交回调
  final ValueChanged<String>? onSubmitted;

  /// 错误提示文字
  final String? errorText;

  /// 是否自动聚焦
  final bool autofocus;

  /// FocusNode
  final FocusNode? focusNode;

  /// 初始是否显示密码
  final bool initiallyVisible;

  const AppPasswordField({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.errorText,
    this.autofocus = false,
    this.focusNode,
    this.initiallyVisible = false,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = !widget.initiallyVisible;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      placeholder: widget.placeholder ?? '请输入密码',
      label: widget.label,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      errorText: widget.errorText,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      prefix: Icon(
        CupertinoIcons.lock,
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
        size: 20,
      ),
      suffix: IconButton(
        icon: Icon(
          _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}

/// App 搜索框
class AppSearchBar extends StatelessWidget {
  /// 文本控制器
  final TextEditingController? controller;

  /// 占位符文字
  final String? placeholder;

  /// 文本变化回调
  final ValueChanged<String>? onChanged;

  /// 提交回调
  final ValueChanged<String>? onSubmitted;

  /// 取消按钮点击回调
  final VoidCallback? onCancel;

  /// 是否自动聚焦
  final bool autofocus;

  /// FocusNode
  final FocusNode? focusNode;

  const AppSearchBar({
    super.key,
    this.controller,
    this.placeholder = '搜索',
    this.onChanged,
    this.onSubmitted,
    this.onCancel,
    this.autofocus = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoSearchTextField(
      controller: controller,
      placeholder: placeholder,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofocus: autofocus,
      focusNode: focusNode,
      style: TextStyle(
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
      ),
      backgroundColor: isDark
          ? AppColors.darkSurfaceElevated
          : AppColors.lightSurface,
      borderRadius: BorderRadius.circular(AppRadius.searchBar),
      prefixInsets: const EdgeInsets.only(left: 12),
      suffixInsets: const EdgeInsets.only(right: 12),
    );
  }
}
