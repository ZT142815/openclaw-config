import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// App 自定义导航栏组件
/// 支持渐变背景、左侧返回按钮、居中标题、右侧操作按钮
///
/// 【使用示例】
/// ```dart
/// // 基础导航栏
/// AppNavBar(
///   title: '标题',
///   onBack: () => Navigator.pop(context),
/// )
///
/// // 带右侧按钮
/// AppNavBar(
///   title: '编辑',
///   onBack: () => Navigator.pop(context),
///   rightWidget: IconButton(
///     icon: Icon(CupertinoIcons.checkmark),
///     onPressed: _save,
///   ),
/// )
///
/// // 渐变背景
/// AppNavBar(
///   title: '个人中心',
///   gradient: AppColors.primaryGradient,
///   onBack: () => Navigator.pop(context),
/// )
/// ```
class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  /// 标题
  final String? title;

  /// 标题 Widget（优先级高于 title）
  final Widget? titleWidget;

  /// 左侧 Widget
  final Widget? leftWidget;

  /// 右侧 Widget
  final Widget? rightWidget;

  /// 返回按钮回调
  final VoidCallback? onBack;

  /// 是否显示返回按钮
  final bool showBackButton;

  /// 返回按钮图标
  final IconData backIcon;

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否使用渐变背景
  final bool useGradient;

  /// 渐变色
  final Gradient? gradient;

  /// 标题颜色
  final Color? titleColor;

  /// 高度
  final double height;

  /// 底部安全区
  final bool bottomSafeArea;

  /// 标题是否居中
  final bool centerTitle;

  /// 透明度（支持动画）
  final double opacity;

  const AppNavBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leftWidget,
    this.rightWidget,
    this.onBack,
    this.showBackButton = true,
    this.backIcon = CupertinoIcons.back,
    this.backgroundColor,
    this.useGradient = false,
    this.gradient,
    this.titleColor,
    this.height = 44,
    this.bottomSafeArea = true,
    this.centerTitle = true,
    this.opacity = 1.0,
  });

  @override
  Size get preferredSize => Size.fromHeight(
      height + (bottomSafeArea ? MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top : 0));

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: useGradient
            ? null
            : (backgroundColor ??
                (isDark ? AppColors.darkSurface : AppColors.lightSurface)),
        gradient: useGradient
            ? (gradient ?? AppColors.primaryGradient)
            : null,
      ),
      child: Opacity(
        opacity: opacity,
        child: Stack(
          children: [
            // 底部安全区
            if (bottomSafeArea)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: topPadding,
                  color: Colors.transparent,
                ),
              ),

            // 主内容
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomSafeArea ? 0 : null,
              top: bottomSafeArea ? topPadding : 0,
              child: SizedBox(
                height: height,
                child: Row(
                  children: [
                    // 左侧区域
                    _buildLeftWidget(context, isDark),

                    // 标题区域
                    Expanded(
                      child: _buildTitleWidget(context, isDark),
                    ),

                    // 右侧区域
                    _buildRightWidget(context, isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftWidget(BuildContext context, bool isDark) {
    if (leftWidget != null) {
      return leftWidget!;
    }

    if (!showBackButton) {
      return const SizedBox(width: AppSpacing.md);
    }

    final titleColor = this.titleColor ??
        (useGradient
            ? Colors.white
            : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary));

    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      onPressed: onBack ?? () => Navigator.maybePop(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            backIcon,
            color: titleColor,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildTitleWidget(BuildContext context, bool isDark) {
    if (titleWidget != null) {
      return Center(child: titleWidget);
    }

    if (title == null) {
      return const SizedBox.shrink();
    }

    final effectiveTitleColor = titleColor ??
        (useGradient
            ? Colors.white
            : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary));

    return centerTitle
        ? Center(
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: effectiveTitleColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: effectiveTitleColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
  }

  Widget _buildRightWidget(BuildContext context, bool isDark) {
    if (rightWidget == null) {
      return const SizedBox(width: AppSpacing.md);
    }

    return rightWidget!;
  }
}

/// App 透明导航栏
/// 适用于沉浸式页面，配合透明状态栏
class AppNavBarTransparent extends AppNavBar {
  const AppNavBarTransparent({
    super.key,
    super.title,
    super.titleWidget,
    super.leftWidget,
    super.rightWidget,
    super.onBack,
    super.showBackButton = true,
    super.backIcon = CupertinoIcons.back,
    super.height = 44,
    super.centerTitle = true,
  }) : super(
          backgroundColor: Colors.transparent,
          bottomSafeArea: true,
        );
}

/// App 大标题导航栏
/// 适用于列表页面，支持滚动时标题收缩
class AppNavBarLargeTitle extends StatelessWidget implements PreferredSizeWidget {
  /// 大标题
  final String largeTitle;

  /// 小标题
  final String? smallTitle;

  /// 左侧 Widget
  final Widget? leading;

  /// 右侧 Widget
  final Widget? trailing;

  /// 返回按钮回调
  final VoidCallback? onBack;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 折叠阈值
  final double collapseThreshold;

  const AppNavBarLargeTitle({
    super.key,
    required this.largeTitle,
    this.smallTitle,
    this.leading,
    this.trailing,
    this.onBack,
    this.scrollController,
    this.collapseThreshold = 50,
  });

  @override
  Size get preferredSize => const Size.fromHeight(96);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;

    return AppNavBar(
      title: smallTitle ?? largeTitle,
      leftWidget: leading,
      rightWidget: trailing,
      onBack: onBack,
      height: topPadding + 44,
      bottomSafeArea: false,
    );
  }
}
