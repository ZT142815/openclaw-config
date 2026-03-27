import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// App 下拉刷新组件
/// 支持自定义刷新指示器、多种刷新样式、加载更多
///
/// 【使用示例】
/// ```dart
/// // 基础下拉刷新
/// AppRefresh(
///   onRefresh: () => _loadData(),
///   child: ListView(...),
/// )
///
/// // 自定义刷新指示器
/// AppRefresh(
///   onRefresh: () => _loadData(),
///   refreshIndicator: AppRefreshIndicator.cupertino(),
///   child: ListView(...),
/// )
///
/// // 加载更多
/// AppRefresh(
///   onRefresh: () => _loadData(),
///   onLoadMore: () => _loadMore(),
///   child: ListView(...),
/// )
/// ```
class AppRefresh extends StatefulWidget {
  /// 子组件
  final Widget child;

  /// 刷新回调
  final Future<void> Function() onRefresh;

  /// 加载更多回调
  final Future<void> Function()? onLoadMore;

  /// 刷新指示器类型
  final RefreshIndicatorType indicatorType;

  /// 自定义刷新指示器
  final Widget? refreshIndicator;

  /// 自定义加载更多指示器
  final Widget? loadMoreIndicator;

  /// 是否显示加载更多
  final bool showLoadMore;

  /// 是否启用刷新
  final bool enableRefresh;

  /// 是否启用加载更多
  final bool enableLoadMore;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 首席曲
  final bool primary;

  /// 物理滚动
  final bool physics;

  /// 顶部 padding
  final double? topPadding;

  /// 底部 padding
  final double? bottomPadding;

  /// 是否正在刷新
  final bool isRefreshing;

  /// 是否正在加载更多
  final bool isLoadingMore;

  const AppRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.onLoadMore,
    this.indicatorType = RefreshIndicatorType.cupertino,
    this.refreshIndicator,
    this.loadMoreIndicator,
    this.showLoadMore = true,
    this.enableRefresh = true,
    this.enableLoadMore = true,
    this.scrollController,
    this.primary = true,
    this.physics = true,
    this.topPadding,
    this.bottomPadding,
    this.isRefreshing = false,
    this.isLoadingMore = false,
  });

  /// Cupertino 风格刷新
  factory AppRefresh.cupertino({
    Key? key,
    required Widget child,
    required Future<void> Function() onRefresh,
    Future<void> Function()? onLoadMore,
    bool showLoadMore = true,
    bool enableRefresh = true,
    bool enableLoadMore = true,
    ScrollController? scrollController,
    bool primary = true,
    bool physics = true,
    double? topPadding,
    double? bottomPadding,
    bool isRefreshing = false,
    bool isLoadingMore = false,
  }) {
    return AppRefresh(
      key: key,
      child: child,
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      indicatorType: RefreshIndicatorType.cupertino,
      showLoadMore: showLoadMore,
      enableRefresh: enableRefresh,
      enableLoadMore: enableLoadMore,
      scrollController: scrollController,
      primary: primary,
      physics: physics,
      topPadding: topPadding,
      bottomPadding: bottomPadding,
      isRefreshing: isRefreshing,
      isLoadingMore: isLoadingMore,
    );
  }

  /// Material 风格刷新
  factory AppRefresh.material({
    Key? key,
    required Widget child,
    required Future<void> Function() onRefresh,
    Future<void> Function()? onLoadMore,
    bool showLoadMore = true,
    bool enableRefresh = true,
    bool enableLoadMore = true,
    ScrollController? scrollController,
    bool primary = true,
    bool physics = true,
    double? topPadding,
    double? bottomPadding,
    bool isRefreshing = false,
    bool isLoadingMore = false,
  }) {
    return AppRefresh(
      key: key,
      child: child,
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      indicatorType: RefreshIndicatorType.material,
      showLoadMore: showLoadMore,
      enableRefresh: enableRefresh,
      enableLoadMore: enableLoadMore,
      scrollController: scrollController,
      primary: primary,
      physics: physics,
      topPadding: topPadding,
      bottomPadding: bottomPadding,
      isRefreshing: isRefreshing,
      isLoadingMore: isLoadingMore,
    );
  }

  @override
  State<AppRefresh> createState() => _AppRefreshState();
}

class _AppRefreshState extends State<AppRefresh> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  void _onScroll() {
    if (!widget.enableLoadMore ||
        widget.onLoadMore == null ||
        _isLoadingMore ||
        widget.isLoadingMore) {
      return;
    }

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() {
      _isLoadingMore = true;
    });

    try {
      await widget.onLoadMore?.call();
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    await widget.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = widget.topPadding ?? 0;
    final bottomPadding = widget.bottomPadding ?? 0;

    Widget content = widget.child;

    // 添加底部加载更多
    if (widget.showLoadMore && widget.onLoadMore != null) {
      content = Column(
        children: [
          Expanded(child: content),
          _buildLoadMoreIndicator(),
        ],
      );
    }

    Widget scrollView;

    switch (widget.indicatorType) {
      case RefreshIndicatorType.cupertino:
        scrollView = CustomScrollView(
          controller: _scrollController,
          physics: widget.physics
              ? const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                )
              : const NeverScrollableScrollPhysics(),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: widget.enableRefresh ? _onRefresh : null,
            ),
            if (topPadding > 0)
              SliverToBoxAdapter(
                child: SizedBox(height: topPadding),
              ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: content,
            ),
            if (bottomPadding > 0)
              SliverToBoxAdapter(
                child: SizedBox(height: bottomPadding),
              ),
          ],
        );
        break;

      case RefreshIndicatorType.material:
        scrollView = RefreshIndicator(
          onRefresh: widget.enableRefresh ? _onRefresh : () async {},
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: widget.physics
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: topPadding,
              bottom: bottomPadding,
            ),
            child: content,
          ),
        );
        break;

      case RefreshIndicatorType.custom:
        scrollView = _CustomRefreshScrollView(
          scrollController: _scrollController,
          onRefresh: widget.enableRefresh ? _onRefresh : null,
          refreshIndicator: widget.refreshIndicator,
          physics: widget.physics,
          topPadding: topPadding,
          bottomPadding: bottomPadding,
          child: content,
        );
        break;
    }

    return scrollView;
  }

  Widget _buildLoadMoreIndicator() {
    if (!widget.showLoadMore ||
        widget.onLoadMore == null ||
        widget.isLoadingMore ||
        _isLoadingMore) {
      return const SizedBox(height: AppSpacing.xl);
    }

    return SizedBox(
      height: AppSpacing.xl,
      child: Center(
        child: widget.loadMoreIndicator ??
            CupertinoActivityIndicator(
              radius: 10,
            ),
      ),
    );
  }
}

/// 刷新指示器类型
enum RefreshIndicatorType {
  /// Cupertino 风格
  cupertino,

  /// Material 风格
  material,

  /// 自定义
  custom,
}

/// 自定义刷新滚动视图
class _CustomRefreshScrollView extends StatefulWidget {
  final ScrollController scrollController;
  final Future<void> Function()? onRefresh;
  final Widget? refreshIndicator;
  final bool physics;
  final double topPadding;
  final double bottomPadding;
  final Widget child;

  const _CustomRefreshScrollView({
    required this.scrollController,
    this.onRefresh,
    this.refreshIndicator,
    this.physics = true,
    this.topPadding = 0,
    this.bottomPadding = 0,
    required this.child,
  });

  @override
  State<_CustomRefreshScrollView> createState() =>
      _CustomRefreshScrollViewState();
}

class _CustomRefreshScrollViewState extends State<_CustomRefreshScrollView> {
  bool _isRefreshing = false;
  double _pullDistance = 0;

  static const double _triggerDistance = 80;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          if (notification.metrics.pixels < 0) {
            setState(() {
              _pullDistance = -notification.metrics.pixels;
            });
          }
        } else if (notification is ScrollEndNotification) {
          if (_pullDistance > _triggerDistance && !_isRefreshing) {
            _triggerRefresh();
          } else {
            setState(() {
              _pullDistance = 0;
            });
          }
        }
        return false;
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: widget.scrollController,
            physics: widget.physics
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: widget.topPadding + (_isRefreshing ? _triggerDistance : _pullDistance),
              bottom: widget.bottomPadding,
            ),
            child: widget.child,
          ),
          if (_isRefreshing || _pullDistance > 0)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Transform.translate(
                offset: Offset(0, _isRefreshing ? _triggerDistance : _pullDistance),
                child: widget.refreshIndicator ??
                    _DefaultRefreshIndicator(
                      pullDistance: _pullDistance,
                      isRefreshing: _isRefreshing,
                      triggerDistance: _triggerDistance,
                    ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _triggerRefresh() async {
    setState(() {
      _isRefreshing = true;
      _pullDistance = _triggerDistance;
    });

    try {
      await widget.onRefresh?.call();
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
          _pullDistance = 0;
        });
      }
    }
  }
}

/// 默认刷新指示器
class _DefaultRefreshIndicator extends StatelessWidget {
  final double pullDistance;
  final bool isRefreshing;
  final double triggerDistance;

  const _DefaultRefreshIndicator({
    required this.pullDistance,
    required this.isRefreshing,
    required this.triggerDistance,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = (pullDistance / triggerDistance).clamp(0.0, 1.0);

    return SizedBox(
      height: triggerDistance,
      child: Center(
        child: isRefreshing
            ? CupertinoActivityIndicator(
                radius: 14,
              )
            : Transform.rotate(
                angle: progress * 3.14159,
                child: Icon(
                  CupertinoIcons.arrow_down,
                  size: 24,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
      ),
    );
  }
}

/// App 刷新指示器组件
/// 提供多种预设的刷新指示器样式
class AppRefreshIndicator extends StatelessWidget {
  /// 指示器类型
  final AppRefreshIndicatorStyle style;

  /// 颜色
  final Color? color;

  /// 尺寸
  final double size;

  const AppRefreshIndicator({
    super.key,
    this.style = AppRefreshIndicatorStyle.cupertino,
    this.color,
    this.size = 24,
  });

  /// Cupertino 风格
  const AppRefreshIndicator.cupertino({
    super.key,
    this.color,
    this.size = 24,
  }) : style = AppRefreshIndicatorStyle.cupertino;

  /// Material 风格
  const AppRefreshIndicator.material({
    super.key,
    this.color,
    this.size = 24,
  }) : style = AppRefreshIndicatorStyle.material;

  /// 脉冲风格
  const AppRefreshIndicator.pulse({
    super.key,
    this.color,
    this.size = 24,
  }) : style = AppRefreshIndicatorStyle.pulse;

  /// 三点跳动风格
  const AppRefreshIndicator.threeBounce({
    super.key,
    this.color,
    this.size = 24,
  }) : style = AppRefreshIndicatorStyle.threeBounce;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ??
        (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary);

    switch (style) {
      case AppRefreshIndicatorStyle.cupertino:
        return CupertinoActivityIndicator(radius: size / 2);
      case AppRefreshIndicatorStyle.material:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
          ),
        );
      case AppRefreshIndicatorStyle.pulse:
        return _PulseIndicator(color: effectiveColor, size: size);
      case AppRefreshIndicatorStyle.threeBounce:
        return _ThreeBounceIndicator(color: effectiveColor, size: size);
    }
  }
}

/// 刷新指示器样式
enum AppRefreshIndicatorStyle {
  cupertino,
  material,
  pulse,
  threeBounce,
}

/// 脉冲动画指示器
class _PulseIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const _PulseIndicator({
    required this.color,
    required this.size,
  });

  @override
  State<_PulseIndicator> createState() => _PulseIndicatorState();
}

class _PulseIndicatorState extends State<_PulseIndicator>
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
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
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

/// 三点跳动指示器
class _ThreeBounceIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const _ThreeBounceIndicator({
    required this.color,
    required this.size,
  });

  @override
  State<_ThreeBounceIndicator> createState() => _ThreeBounceIndicatorState();
}

class _ThreeBounceIndicatorState extends State<_ThreeBounceIndicator>
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

    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
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
    final dotSize = widget.size / 3;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: dotSize / 4),
          child: AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_animations[index].value * dotSize),
                child: Container(
                  width: dotSize,
                  height: dotSize,
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
