/// Flutter 通用间距系统
/// 基于 8px 基础网格，确保视觉一致性
///
/// 【使用示例】
/// ```dart
/// // 标准用法
/// padding: const EdgeInsets.all(AppSpacing.md)
/// margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg)
/// gap: SizedBox(height: AppSpacing.xs)
/// ```
class AppSpacing {
  AppSpacing._();

  // ============================================================
  // 基础间距层级
  // ============================================================
  /// 超紧凑间距 - 4px
  /// 用于紧密相关元素的间距
  static const double xxs = 4;

  /// 小间距 - 8px
  /// 用于图标与文字、小组件之间的间距
  static const double xs = 8;

  /// 中小间距 - 12px
  /// 用于组件内部元素间距
  static const double sm = 12;

  /// 标准间距 - 16px
  /// 用于页面边距、列表项、卡片内边距
  static const double md = 16;

  /// 中大间距 - 24px
  /// 用于区块之间的间距
  static const double lg = 24;

  /// 大间距 - 32px
  /// 用于页面区块之间的分隔
  static const double xl = 32;

  /// 超大间距 - 48px
  /// 用于大区块之间的分隔
  static const double xxl = 48;

  // ============================================================
  // 布局特定间距
  // ============================================================
  /// 页面水平边距
  static const double pageHorizontal = 16;

  /// 页面垂直边距
  static const double pageVertical = 16;

  /// 列表项标准高度
  static const double listItemHeight = 44;

  /// 列表项带副标题高度
  static const double listItemHeightWithSubtitle = 56;

  /// 按钮标准高度 - 主要操作
  static const double buttonHeightPrimary = 50;

  /// 按钮标准高度 - 次要操作
  static const double buttonHeightSecondary = 44;

  /// 输入框高度
  static const double inputHeight = 48;

  /// Tab Bar 高度（不含安全区）
  static const double tabBarHeight = 49;

  /// Navigation Bar 高度（不含安全区）
  static const double navBarHeight = 44;

  /// 最小触控区域
  static const double minTapArea = 44;

  // ============================================================
  // 便捷方法
  // ============================================================

  /// 创建水平内边距
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: pageHorizontal,
    vertical: pageVertical,
  );

  /// 创建卡片内边距
  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  /// 创建列表项内边距
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
  );

  /// 创建按钮内边距
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: lg,
  );

  /// 创建紧凑型按钮内边距
  static const EdgeInsets buttonPaddingCompact = EdgeInsets.symmetric(
    horizontal: md,
  );

  /// 创建水平间距
  static SizedBox horizontalSpace(double value) => SizedBox(width: value);

  /// 创建垂直间距
  static SizedBox verticalSpace(double value) => SizedBox(height: value);

  /// 创建超紧凑垂直间距
  static const SizedBox vxxs = SizedBox(height: xxs);

  /// 创建小垂直间距
  static const SizedBox vxs = SizedBox(height: xs);

  /// 创建中小垂直间距
  static const SizedBox vsm = SizedBox(height: sm);

  /// 创建标准垂直间距
  static const SizedBox vmd = SizedBox(height: md);

  /// 创建中大垂直间距
  static const SizedBox vlg = SizedBox(height: lg);

  /// 创建大垂直间距
  static const SizedBox vxl = SizedBox(height: xl);

  /// 创建超大大垂直间距
  static const SizedBox vxxl = SizedBox(height: xxl);

  /// 创建超紧凑水平间距
  static const SizedBox hxxs = SizedBox(width: xxs);

  /// 创建小水平间距
  static const SizedBox hxs = SizedBox(width: xs);

  /// 创建中小水平间距
  static const SizedBox hsm = SizedBox(width: sm);

  /// 创建标准水平间距
  static const SizedBox hmd = SizedBox(width: md);

  /// 创建中大水平间距
  static const SizedBox hlg = SizedBox(width: lg);

  /// 创建大水平间距
  static const SizedBox hxl = SizedBox(width: xl);
}
