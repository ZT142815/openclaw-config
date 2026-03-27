import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 搜索框组件
/// 支持 iOS 风格搜索，带清除和取消按钮
///
/// 【使用示例】
/// ```dart
/// // 基础搜索框
/// AppSearchBar(
///   controller: _searchController,
///   onChanged: (value) => _search(value),
/// )
///
/// // 自定义占位符
/// AppSearchBar(
///   controller: _searchController,
///   placeholder: '搜索商品',
///   onSubmitted: (value) => _search(value),
/// )
///
/// // 简化版（自动处理状态）
/// AppSearchBar.simple(
///   controller: _searchController,
///   onSearch: (value) => _search(value),
/// )
/// ```
class AppSearchBar extends StatefulWidget {
  /// 文本控制器
  final TextEditingController? controller;

  /// 占位符文本
  final String placeholder;

  /// 搜索回调
  final ValueChanged<String>? onChanged;

  /// 提交回调
  final ValueChanged<String>? onSubmitted;

  /// 取消回调
  final VoidCallback? onCancel;

  /// 获得焦点回调
  final VoidCallback? onFocus;

  /// 失去焦点回调
  final VoidCallback? onBlur;

  /// 是否自动聚焦
  final bool autofocus;

  /// 是否显示取消按钮
  final bool showCancelButton;

  /// 搜索图标位置
  final SearchIconPosition iconPosition;

  /// 背景颜色
  final Color? backgroundColor;

  /// 高度
  final double height;

  /// 圆角
  final double? borderRadius;

  /// 是否显示搜索图标
  final bool showSearchIcon;

  /// 清除按钮回调
  final VoidCallback? onClear;

  /// 前缀 Widget
  final Widget? prefix;

  /// 是否启用
  final bool enabled;

  const AppSearchBar({
    super.key,
    this.controller,
    this.placeholder = '搜索',
    this.onChanged,
    this.onSubmitted,
    this.onCancel,
    this.onFocus,
    this.onBlur,
    this.autofocus = false,
    this.showCancelButton = true,
    this.iconPosition = SearchIconPosition.left,
    this.backgroundColor,
    this.height = 36,
    this.borderRadius,
    this.showSearchIcon = true,
    this.onClear,
    this.prefix,
    this.enabled = true,
  });

  /// 简化版搜索框（自动管理状态）
  factory AppSearchBar.simple({
    Key? key,
    required TextEditingController controller,
    required ValueChanged<String> onSearch,
    String placeholder = '搜索',
    bool autofocus = false,
  }) {
    return AppSearchBar(
      key: key,
      controller: controller,
      placeholder: placeholder,
      autofocus: autofocus,
      onChanged: onSearch,
      onSubmitted: onSearch,
    );
  }

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);

    // 初始状态
    _showClear = _controller.text.isNotEmpty;

    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClear = _controller.text.isNotEmpty;
    });
    widget.onChanged?.call(_controller.text);
  }

  void _onFocusChanged() {
    final hadFocus = _isFocused;
    _isFocused = _focusNode.hasFocus;

    if (_isFocused && !hadFocus) {
      widget.onFocus?.call();
      if (widget.showCancelButton) {
        setState(() {});
      }
    } else if (!_isFocused && hadFocus) {
      widget.onBlur?.call();
      if (widget.showCancelButton) {
        setState(() {});
      }
    }
  }

  void _onClear() {
    _controller.clear();
    widget.onClear?.call();
  }

  void _onCancel() {
    _controller.clear();
    _focusNode.unfocus();
    widget.onCancel?.call();
  }

  void _onSubmitted(String value) {
    widget.onSubmitted?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBgColor = widget.backgroundColor ??
        (isDark ? AppColors.darkSurface : AppColors.lightSurfaceTertiary);
    final effectiveRadius = widget.borderRadius ?? AppRadius.searchBar;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: effectiveBgColor,
              borderRadius: BorderRadius.circular(effectiveRadius),
            ),
            child: Row(
              children: [
                if (widget.showSearchIcon && widget.iconPosition == SearchIconPosition.left) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    CupertinoIcons.search,
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                    size: 18,
                  ),
                ],
                if (widget.prefix != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  widget.prefix!,
                ],
                Expanded(
                  child: CupertinoTextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    placeholder: widget.placeholder,
                    enabled: widget.enabled,
                    onSubmitted: _onSubmitted,
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.showSearchIcon ? AppSpacing.xs : AppSpacing.sm,
                      vertical: 0,
                    ),
                    decoration: const BoxDecoration(),
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                    placeholderStyle: TextStyle(
                      fontSize: 16,
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary,
                    ),
                    cursorColor: AppColors.primary,
                  ),
                ),
                if (_showClear) ...[
                  GestureDetector(
                    onTap: _onClear,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                      ),
                      child: Icon(
                        CupertinoIcons.clear_circled_solid,
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.lightTextTertiary,
                        size: 18,
                      ),
                    ),
                  ),
                ],
                if (widget.showSearchIcon && widget.iconPosition == SearchIconPosition.right) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    CupertinoIcons.search,
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                    size: 18,
                  ),
                ],
                if (widget.iconPosition == SearchIconPosition.right) ...[
                  const SizedBox(width: AppSpacing.xs),
                ],
              ],
            ),
          ),
        ),
        if (widget.showCancelButton && _isFocused) ...[
          const SizedBox(width: AppSpacing.xs),
          GestureDetector(
            onTap: _onCancel,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.xxs,
              ),
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// 搜索图标位置
enum SearchIconPosition {
  left,
  right,
}
