import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// App 底部导航栏组件
/// 支持多标签页、徽章、选中状态
///
/// 【使用示例】
/// ```dart
/// AppBottomNav(
///   currentIndex: _currentIndex,
///   onTap: (index) => setState(() => _currentIndex = index),
///   items: [
///     AppNavItem(
///       icon: CupertinoIcons.home,
///       activeIcon: CupertinoIcons.home_fill,
///       label: '首页',
///     ),
///     AppNavItem(
///       icon: CupertinoIcons.heart,
///       activeIcon: CupertinoIcons.heart_fill,
///       label: '收藏',
///       badge: 5,
///     ),
///     AppNavItem(
///       icon: CupertinoIcons.person,
///       activeIcon: CupertinoIcons.person_fill,
///       label: '我的',
///     ),
///   ],
/// )
/// ```
class AppBottomNav extends StatelessWidget {
  /// 当前选中索引
  final int currentIndex;

  /// 点击回调
  final ValueChanged<int>? onTap;

  /// 导航项列表
  final List<AppNavItem> items;

  /// 高度
  final double height;

  /// 背景颜色
  final Color? backgroundColor;

  /// 选中图标颜色
  final Color? activeColor;

  /// 未选中图标颜色
  final Color? inactiveColor;

  /// 是否显示顶部边框
  final bool showBorder;

  /// 边框颜色
  final Color? borderColor;

  /// 是否透明背景
  final bool transparent;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.height = AppSpacing.tabBarHeight,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.showBorder = true,
    this.borderColor,
    this.transparent = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBgColor = backgroundColor ??
        (isDark ? AppColors.darkSurface : AppColors.lightSurface);
    final effectiveActiveColor = activeColor ?? AppColors.primary;
    final effectiveInactiveColor =
        inactiveColor ?? AppColors.darkTextSecondary;
    final effectiveBorderColor =
        borderColor ?? (isDark ? AppColors.darkSeparator : AppColors.lightSeparator);

    return Container(
      height: height + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: transparent ? Colors.transparent : effectiveBgColor,
        border: showBorder
            ? Border(
                top: BorderSide(
                  color: effectiveBorderColor,
                  width: 0.5,
                ),
              )
            : null,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              return _buildNavItem(
                context,
                items[index],
                index,
                currentIndex == index,
                effectiveActiveColor,
                effectiveInactiveColor,
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    AppNavItem item,
    int index,
    bool isActive,
    Color activeColor,
    Color inactiveColor,
  ) {
    final color = isActive ? activeColor : inactiveColor;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap?.call(index),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 图标 + 徽章
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    isActive ? item.activeIcon : item.icon,
                    size: 24,
                    color: color,
                  ),
                  if (item.badge != null && item.badge! > 0)
                    Positioned(
                      top: -4,
                      right: -8,
                      child: _BadgeWidget(count: item.badge!),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              // 标签
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 导航项数据模型
class AppNavItem {
  /// 图标
  final IconData icon;

  /// 选中图标
  final IconData? activeIcon;

  /// 标签文字
  final String label;

  /// 徽章数量
  final int? badge;

  /// 自定义图标 Widget
  final Widget? iconWidget;

  /// 自定义选中图标 Widget
  final Widget? activeIconWidget;

  /// 是否禁用
  final bool disabled;

  const AppNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.badge,
    this.iconWidget,
    this.activeIconWidget,
    this.disabled = false,
  });

  /// 创建自定义图标的导航项
  const AppNavItem.custom({
    required this.label,
    required Widget icon,
    Widget? activeIcon,
    this.badge,
    this.disabled = false,
  })  : icon = CupertinoIcons.circle,
        activeIcon = null,
        iconWidget = icon,
        activeIconWidget = activeIcon;
}

/// 徽章小部件
class _BadgeWidget extends StatelessWidget {
  final int count;

  const _BadgeWidget({required this.count});

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    final displayCount = count > 99 ? '99+' : '$count';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      constraints: const BoxConstraints(minWidth: 16),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        displayCount,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// App Cupertino 风格底部导航栏
class AppCupertinoBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<AppNavItem> items;

  const AppCupertinoBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          activeIcon: Icon(item.activeIcon ?? item.icon),
          label: item.label,
        );
      }).toList(),
    );
  }
}

/// App 浮动底部导航栏（带圆角背景）
class AppFloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<AppNavItem> items;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double height;

  const AppFloatingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.margin,
    this.width,
    this.height = 64,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(height / 2),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isActive = currentIndex == index;
            final color = isActive
                ? AppColors.primary
                : (isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary);

            return Expanded(
              child: GestureDetector(
                onTap: () => onTap?.call(index),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isActive ? (item.activeIcon ?? item.icon) : item.icon,
                      size: 24,
                      color: color,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
