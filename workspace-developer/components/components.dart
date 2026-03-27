/// Flutter 通用组件库
/// 
/// 遵循 Apple HIG + Material Design 3 设计规范
/// 支持深色/浅色模式自动切换
/// 
/// 【快速使用】
/// ```dart
/// import 'package:your_app/components/components.dart';
/// 
/// // 使用组件
/// PrimaryButton(
///   text: '登录',
///   onPressed: () => _login(),
/// )
/// 
/// AppCard(
///   child: Text('内容'),
/// )
/// ```

// ============================================================
// 基础常量
// ============================================================
export 'app_colors.dart';
export 'app_spacing.dart';
export 'app_radius.dart';
export 'app_theme.dart';

// ============================================================
// 基础组件
// ============================================================
// 按钮
export 'primary_button.dart';
export 'secondary_button.dart';
export 'icon_button.dart';

// 卡片
export 'app_card.dart';

// 输入
export 'app_text_field.dart';

// 列表
export 'app_list_tile.dart';

// 标签/徽章
export 'app_chip.dart';
export 'app_badge.dart';

// ============================================================
// 布局组件
// ============================================================
export 'app_scaffold.dart';
export 'app_bottom_nav.dart';
export 'app_nav_bar.dart';
export 'app_divider.dart';

// ============================================================
// 反馈组件
// ============================================================
export 'app_dialog.dart';
export 'app_loading.dart';
export 'app_empty_state.dart';
export 'app_toast.dart';
export 'app_snackbar.dart';

// ============================================================
// 输入组件
// ============================================================
export 'app_search_bar.dart';

// ============================================================
// 展示组件
// ============================================================
export 'app_progress.dart';
export 'app_avatar.dart';
export 'app_refresh.dart';

// ============================================================
// 辅助组件
// ============================================================
export 'app_section_header.dart';

// ============================================================
// 类型别名（方便使用）
// ============================================================

/// 主按钮组件别名
typedef AppPrimaryButton = PrimaryButton;

/// 次按钮组件别名
typedef AppSecondaryButton = SecondaryButton;

/// 图标按钮组件别名
typedef AppIconButton = AppIconButton;

/// 卡片组件别名
typedef AppCard = AppCard;

/// 输入框组件别名
typedef AppTextField = AppTextField;

/// 列表项组件别名
typedef AppListTile = AppListTile;

/// 标签组件别名
typedef AppChip = AppChip;

/// 徽章组件别名
typedef AppBadge = AppBadge;

/// 脚手架组件别名
typedef AppScaffold = AppScaffold;

/// 导航栏组件别名
typedef AppNavBar = AppNavBar;

/// 底部导航组件别名
typedef AppBottomNav = AppBottomNav;

/// 对话框组件别名
typedef AppDialog = AppDialog;

/// 底部弹窗别名
typedef AppBottomSheet = AppBottomSheet;

/// 加载指示器别名
typedef AppLoading = AppLoading;

/// 空状态别名
typedef AppEmptyState = AppEmptyState;

/// 分组标题别名
typedef AppSectionHeader = AppSectionHeader;

/// Toast 提示别名
typedef AppToast = AppToast;

/// Snackbar 提示别名
typedef AppSnackbar = AppSnackbar;

/// 搜索框别名
typedef AppSearchBar = AppSearchBar;

/// 进度条别名
typedef AppProgress = AppProgress;

/// 分割线别名
typedef AppDivider = AppDivider;

/// 头像别名
typedef AppAvatar = AppAvatar;

/// 下拉刷新别名
typedef AppRefresh = AppRefresh;
