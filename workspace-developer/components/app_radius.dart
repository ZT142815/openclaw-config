import 'package:flutter/material.dart';

/// Flutter 通用圆角系统
/// 统一的圆角规范，确保视觉一致性
///
/// 【使用示例】
/// ```dart
/// // 在 BoxDecoration 中使用
/// decoration: BoxDecoration(
///   color: Colors.white,
///   borderRadius: BorderRadius.circular(AppRadius.xlarge),
/// )
///
/// // 在 shape 中使用
/// shape: RoundedRectangleBorder(
///   borderRadius: BorderRadius.circular(AppRadius.large),
/// )
/// ```
class AppRadius {
  AppRadius._();

  // ============================================================
  // 基础圆角层级
  // ============================================================
  /// 无圆角 - 0px
  /// 用于全屏页面角落
  static const double none = 0;

  /// 小圆角 - 8px
  /// 用于小按钮、小型输入框
  static const double small = 8;

  /// 中圆角 - 10px
  /// 用于标准输入框、Tag
  static const double medium = 10;

  /// 大圆角 - 12px
  /// 用于主要按钮、次要按钮
  static const double large = 12;

  /// 特大圆角 - 16px
  /// 用于卡片、容器
  static const double xlarge = 16;

  /// 超大圆角 - 20px
  /// 用于大卡片
  static const double xxlarge = 20;

  /// 全圆角 - 999px
  /// 用于胶囊按钮、Chip、头像
  /// 使用 999 而非 double.infinity 以支持 clipBehavior
  static const double full = 999;

  // ============================================================
  // 组件特定圆角
  // ============================================================
  /// 主按钮圆角
  static const double buttonPrimary = large; // 12px

  /// 次按钮圆角
  static const double buttonSecondary = large; // 12px

  /// 图标按钮圆角
  static const double buttonIcon = small; // 8px

  /// 输入框圆角
  static const double input = medium; // 10px

  /// 卡片圆角
  static const double card = xlarge; // 16px

  /// 大卡片圆角
  static const double cardLarge = xxlarge; // 20px

  /// Chip/标签圆角
  static const double chip = full; // 999px

  /// 头像圆角
  static const double avatar = full; // 50%

  /// 底部弹窗顶部圆角
  static const double bottomSheet = xxlarge; // 20px

  /// Alert 对话框圆角
  static const double alertDialog = 14;

  /// 普通对话框圆角
  static const double dialog = xlarge; // 16px

  /// 开关圆角
  static const double switchThumb = full; // 999px

  /// 搜索框圆角
  static const double searchBar = medium; // 10px

  /// 列表项圆角
  static const double listItem = none; // 0px

  // ============================================================
  // BorderRadius 便捷构造
  // ============================================================

  /// 创建统一的圆角 BorderRadius
  static BorderRadius all(double radius) => BorderRadius.circular(radius);

  /// 创建一个圆角的 BorderRadius
  static final BorderRadius buttonPrimaryRadius =
      BorderRadius.circular(buttonPrimary);

  /// 创建一个卡片的 BorderRadius
  static final BorderRadius cardRadius = BorderRadius.circular(card);

  /// 创建一个大卡片的 BorderRadius
  static final BorderRadius cardLargeRadius =
      BorderRadius.circular(cardLarge);

  /// 创建一个输入框的 BorderRadius
  static final BorderRadius inputRadius = BorderRadius.circular(input);

  /// 创建一个 Chip 的 BorderRadius
  static final BorderRadius chipRadius = BorderRadius.circular(chip);

  /// 创建一个底部弹窗的 BorderRadius
  static BorderRadius bottomSheetRadius([double? top]) {
    return BorderRadius.only(
      topLeft: Radius.circular(top ?? bottomSheet),
      topRight: Radius.circular(top ?? bottomSheet),
    );
  }

  /// 创建一个对话框的 BorderRadius
  static final BorderRadius dialogRadius = BorderRadius.circular(dialog);

  /// 创建自定义圆角的 BorderRadius
  /// [topLeft] 左上角圆角
  /// [topRight] 右上角圆角
  /// [bottomLeft] 左下角圆角
  /// [bottomRight] 右下角圆角
  static BorderRadius only({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );
  }

  /// 创建水平方向圆角（左右相同，上下不同）
  /// [horizontal] 左右圆角值
  /// [top] 顶部圆角值
  /// [bottom] 底部圆角值
  static BorderRadius horizontal({
    required double horizontal,
    double top = 0,
    double bottom = 0,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(horizontal),
      topRight: Radius.circular(horizontal),
      bottomLeft: Radius.circular(horizontal),
      bottomRight: Radius.circular(horizontal),
    );
  }
}
