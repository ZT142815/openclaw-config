import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// App 头像组件
/// 支持圆形头像、头像+徽章、头像+名字、默认头像
///
/// 【使用示例】
/// ```dart
/// // 基础圆形头像
/// AppAvatar(
///   imageUrl: 'https://example.com/avatar.jpg',
///   size: 48,
/// )
///
/// // 带名字
/// AppAvatar.withName(
///   name: '张三',
///   imageUrl: '...',
/// )
///
/// // 带徽章
/// AppAvatar(
///   imageUrl: '...',
///   size: 48,
///   badge: AppAvatarBadge(count: 5),
/// )
///
/// // 默认头像
/// AppAvatar.defaultAvatar(name: '李四')
/// ```
class AppAvatar extends StatelessWidget {
  /// 图片 URL
  final String? imageUrl;

  /// 本地图片
  final ImageProvider? image;

  /// 尺寸
  final double size;

  /// 头像形状
  final BoxShape shape;

  /// 圆角（当 shape 不为 circle 时使用）
  final double? borderRadius;

  /// 边框
  final BoxBorder? border;

  /// 边框宽度
  final double borderWidth;

  /// 边框颜色
  final Color? borderColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 子组件（覆盖图片）
  final Widget? child;

  /// 默认头像配置
  final AppAvatarDefaultConfig? defaultConfig;

  /// 头像名称（用于默认头像和加载失败时）
  final String? name;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.image,
    this.size = 48,
    this.shape = BoxShape.circle,
    this.borderRadius,
    this.border,
    this.borderWidth = 0,
    this.borderColor,
    this.onTap,
    this.child,
    this.defaultConfig,
    this.name,
  });

  /// 带名字的头像
  factory AppAvatar.withName({
    Key? key,
    required String name,
    String? imageUrl,
    ImageProvider? image,
    double size = 48,
    VoidCallback? onTap,
    AppAvatarDefaultConfig? defaultConfig,
  }) {
    return AppAvatar(
      key: key,
      name: name,
      imageUrl: imageUrl,
      image: image,
      size: size,
      onTap: onTap,
      defaultConfig: defaultConfig,
    );
  }

  /// 默认头像
  factory AppAvatar.defaultAvatar({
    Key? key,
    String? name,
    double size = 48,
    VoidCallback? onTap,
    AppAvatarDefaultConfig? defaultConfig,
  }) {
    return AppAvatar(
      key: key,
      name: name,
      size: size,
      onTap: onTap,
      defaultConfig: defaultConfig,
    );
  }

  /// 获取圆角
  BorderRadius? _getBorderRadius() {
    if (shape == BoxShape.circle) return null;
    return BorderRadius.circular(borderRadius ?? AppRadius.medium);
  }

  /// 获取边框
  Decoration? _getDecoration(Color placeholderColor) {
    final effectiveBorderColor = borderColor ?? Colors.transparent;

    BoxDecoration? decoration;
    if (border != null) {
      decoration = BoxDecoration(border: border);
    } else if (borderWidth > 0) {
      decoration = BoxDecoration(
        shape: shape,
        borderRadius: _getBorderRadius(),
        border: Border.all(
          color: effectiveBorderColor,
          width: borderWidth,
        ),
      );
    }

    return decoration;
  }

  /// 获取占位符背景色
  Color _getPlaceholderColor(String? name) {
    if (defaultConfig?.backgroundColor != null) {
      return defaultConfig!.backgroundColor!;
    }
    // 根据名字生成颜色
    return _generateColorFromName(name);
  }

  /// 根据名字生成颜色
  Color _generateColorFromName(String? name) {
    if (name == null || name.isEmpty) {
      return AppColors.primary;
    }
    final colors = [
      AppColors.primary,
      AppColors.success,
      AppColors.warning,
      AppColors.info,
      const Color(0xFFAF52DE), // 紫色
      const Color(0xFFFF2D55), // 粉色
    ];
    final index = name.codeUnits.fold(0, (prev, code) => prev + code) % colors.length;
    return colors[index];
  }

  /// 获取首字母
  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final trimmed = name.trim();
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return trimmed.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveSize = size;

    Widget avatarContent;

    if (child != null) {
      avatarContent = child!;
    } else if (image != null) {
      avatarContent = Image(
        image: image!,
        fit: BoxFit.cover,
        width: effectiveSize,
        height: effectiveSize,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder(isDark);
        },
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = Image.network(
        imageUrl!,
        width: effectiveSize,
        height: effectiveSize,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingPlaceholder(isDark);
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder(isDark);
        },
      );
    } else {
      avatarContent = _buildPlaceholder(isDark);
    }

    final decoration = _getDecoration(_getPlaceholderColor(name));

    Widget avatar = Container(
      width: effectiveSize,
      height: effectiveSize,
      decoration: decoration != null
          ? decoration.copyWith(
              color: decoration.color ??
                  (shape == BoxShape.circle
                      ? _getPlaceholderColor(name)
                      : null),
            )
          : BoxDecoration(
              color: shape == BoxShape.circle
                  ? _getPlaceholderColor(name)
                  : null,
              shape: shape,
              borderRadius: _getBorderRadius(),
            ),
      clipBehavior: shape == BoxShape.circle ? Clip.antiAlias : Clip.none,
      child: decoration == null
          ? ClipRRect(
              borderRadius: _getBorderRadius() ?? BorderRadius.zero,
              child: avatarContent,
            )
          : avatarContent,
    );

    if (onTap != null) {
      avatar = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildPlaceholder(bool isDark) {
    final bgColor = _getPlaceholderColor(name);
    final textColor = defaultConfig?.textColor ?? Colors.white;

    return Container(
      width: size,
      height: size,
      color: bgColor,
      child: Center(
        child: Text(
          _getInitials(name),
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingPlaceholder(bool isDark) {
    final bgColor = isDark
        ? AppColors.darkSurfaceTertiary
        : AppColors.lightSurfaceTertiary;

    return Container(
      width: size,
      height: size,
      color: bgColor,
      child: Center(
        child: CupertinoActivityIndicator(
          radius: size * 0.15,
        ),
      ),
    );
  }
}

/// 默认头像配置
class AppAvatarDefaultConfig {
  /// 背景颜色
  final Color? backgroundColor;

  /// 文字颜色
  final Color? textColor;

  /// 字体大小倍数
  final double? fontSizeRatio;

  const AppAvatarDefaultConfig({
    this.backgroundColor,
    this.textColor,
    this.fontSizeRatio,
  });
}

/// 头像徽章
class AppAvatarBadge extends StatelessWidget {
  /// 徽章内容
  final int? count;

  /// 徽章文本
  final String? text;

  /// 徽章颜色
  final Color? backgroundColor;

  /// 徽章文字颜色
  final Color? textColor;

  /// 徽章大小
  final double size;

  /// 徽章位置
  final BadgePosition position;

  /// 是否显示红点
  final bool showDot;

  /// 是否显示
  final bool visible;

  const AppAvatarBadge({
    super.key,
    this.count,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.size = 18,
    this.position = BadgePosition.topRight,
    this.showDot = false,
    this.visible = true,
  });

  /// 红点徽章
  const AppAvatarBadge.dot({
    super.key,
    this.backgroundColor,
    this.position = BadgePosition.topRight,
    this.visible = true,
  })  : count = null,
        text = null,
        textColor = null,
        size = 10,
        showDot = true;

  /// 数字徽章
  const AppAvatarBadge.count({
    super.key,
    required this.count,
    this.backgroundColor,
    this.textColor,
    this.size = 18,
    this.position = BadgePosition.topRight,
    this.visible = true,
  })  : text = null,
        showDot = false;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final effectiveBgColor = backgroundColor ?? AppColors.error;
    final effectiveTextColor = textColor ?? Colors.white;

    Offset offset;
    switch (position) {
      case BadgePosition.topLeft:
        offset = const Offset(-2, 2);
        break;
      case BadgePosition.topRight:
        offset = const Offset(2, 2);
        break;
      case BadgePosition.bottomLeft:
        offset = const Offset(-2, -2);
        break;
      case BadgePosition.bottomRight:
        offset = const Offset(2, -2);
        break;
    }

    Widget badge;
    if (showDot) {
      badge = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: effectiveBgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      );
    } else {
      String displayText;
      if (text != null) {
        displayText = text!;
      } else if (count != null) {
        displayText = count! > 99 ? '99+' : '$count';
      } else {
        return const SizedBox.shrink();
      }

      badge = Container(
        padding: EdgeInsets.symmetric(
          horizontal: count != null && count! > 9 ? 4 : 0,
          vertical: 0,
        ),
        constraints: BoxConstraints(
          minWidth: size,
          minHeight: size,
        ),
        decoration: BoxDecoration(
          color: effectiveBgColor,
          borderRadius: BorderRadius.circular(size / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            displayText,
            style: TextStyle(
              fontSize: size * 0.65,
              fontWeight: FontWeight.w600,
              color: effectiveTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Transform.translate(
      offset: offset,
      child: badge,
    );
  }
}

/// 徽章位置
enum BadgePosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// 头像+名字组合
class AppAvatarWithName extends StatelessWidget {
  /// 头像组件
  final AppAvatar avatar;

  /// 名字
  final String? name;

  /// 副标题
  final String? subtitle;

  /// 布局方向
  final Axis direction;

  /// 间距
  final double spacing;

  /// 头像与名字对齐方式
  final CrossAxisAlignment alignment;

  const AppAvatarWithName({
    super.key,
    required this.avatar,
    this.name,
    this.subtitle,
    this.direction = Axis.horizontal,
    this.spacing = AppSpacing.sm,
    this.alignment = CrossAxisAlignment.center,
  });

  /// 水平布局
  factory AppAvatarWithName.row({
    Key? key,
    required AppAvatar avatar,
    String? name,
    String? subtitle,
    double spacing = AppSpacing.sm,
    CrossAxisAlignment alignment = CrossAxisAlignment.center,
  }) {
    return AppAvatarWithName(
      key: key,
      avatar: avatar,
      name: name,
      subtitle: subtitle,
      direction: Axis.horizontal,
      spacing: spacing,
      alignment: alignment,
    );
  }

  /// 垂直布局
  factory AppAvatarWithName.column({
    Key? key,
    required AppAvatar avatar,
    String? name,
    String? subtitle,
    double spacing = AppSpacing.xs,
    CrossAxisAlignment alignment = CrossAxisAlignment.center,
  }) {
    return AppAvatarWithName(
      key: key,
      avatar: avatar,
      name: name,
      subtitle: subtitle,
      direction: Axis.vertical,
      spacing: spacing,
      alignment: alignment,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final textWidget = Column(
      crossAxisAlignment:
          direction == Axis.vertical ? CrossAxisAlignment.start : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (name != null)
          Text(
            name!,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 13,
              color: secondaryColor,
            ),
          ),
      ],
    );

    if (direction == Axis.horizontal) {
      return Row(
        crossAxisAlignment: alignment,
        children: [
          avatar,
          SizedBox(width: spacing),
          textWidget,
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: alignment,
        children: [
          avatar,
          SizedBox(height: spacing),
          textWidget,
        ],
      );
    }
  }
}
