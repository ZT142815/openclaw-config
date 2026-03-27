# Flutter 通用设计规范 - Apple HIG + Material Design 3

> ⚠️ **重要**：所有 Flutter iOS App 开发必须遵循此规范
>
> 📅 更新日期：2026-03-26
> 📁 文件位置：`~/.openclaw/workspace-developer/FLUTTER-DESIGN-GENERAL.md`
> 🎯 定位：适用于所有类型的 Flutter iOS App（工具类、电商、社交、内容类均可）

---

## 📑 目录

- [1️⃣ 核心理念](#1️⃣-核心理念)
- [2️⃣ 色彩系统](#2️⃣-色彩系统)
- [3️⃣ 字体规范](#3️⃣-字体规范)
- [4️⃣ 间距系统](#4️⃣-间距系统)
- [5️⃣ 圆角规范](#5️⃣-圆角规范)
- [6️⃣ 组件规范](#6️⃣-组件规范)
- [7️⃣ 图标规范](#7️⃣-图标规范)
- [8️⃣ 阴影规范](#8️⃣-阴影规范)
- [📋 使用检查清单](#📋-使用检查清单)
- [🎯 快速参考](#🎯-快速参考)

---

## 1️⃣ 核心理念

| 理念 | 说明 |
|------|------|
| **Apple HIG 优先** | 遵循 Apple 人机交互指南，保持 iOS 原生感 |
| **Material Design 3 辅助** | 借鉴 Material 3 的组件化和系统化设计 |
| **简洁克制** | 不要过度装饰，保持干净清爽 |
| **双模式支持** | 完整的深色模式 + 浅色模式 |
| **系统字体** | 使用 SF Pro，保持与 iOS 系统一致 |

---

## 2️⃣ 色彩系统

### 2.1 主色调（Blue System）

采用与 iOS 系统一致的蓝色系：

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary | `#007AFF` | 主按钮、主要操作 |
| Primary Light | `#0A84FF` | 浅色主题主色 |
| Primary Dark | `#0055D4` | 深色主题主色 |
| Primary 10% | `rgba(0, 122, 255, 0.1)` | 背景高亮 |

### 2.2 辅助色系统

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Success | `#34C759` | 成功状态、完成操作 |
| Warning | `#FF9500` | 警告状态、注意提醒 |
| Error | `#FF3B30` | 错误状态、危险操作 |
| Info | `#5AC8FA` | 信息提示、链接色 |

### 2.3 深色模式（Dark Mode）

#### 背景色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Background | `#000000` | 页面背景（纯黑） |
| Surface | `#1C1C1E` | 卡片表面 |
| Surface Elevated | `#2C2C2E` | 浮层、弹窗背景 |
| Surface Tertiary | `#3A3A3C` | 分组背景 |

#### 文字色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary Text | `#FFFFFF` | 标题、重要内容 |
| Secondary Text | `#8E8E93` | 副标题、说明文字 |
| Tertiary Text | `#636366` | 占位符、辅助说明 |
| Quaternary Text | `#48484A` | 禁用状态文字 |

#### 分隔线

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Separator | `rgba(255, 255, 255, 0.12)` | 分隔线 |
| Separator Opaque | `#38383A` | 不透明分隔线 |

### 2.4 浅色模式（Light Mode）

#### 背景色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Background | `#F2F2F7` | 页面背景（系统灰） |
| Surface | `#FFFFFF` | 卡片表面 |
| Surface Elevated | `#FFFFFF` | 浮层、弹窗背景 |
| Surface Tertiary | `#F2F2F7` | 分组背景 |

#### 文字色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary Text | `#000000` | 标题、重要内容 |
| Secondary Text | `#3C3C43` (60%) | 副标题、说明文字 |
| Tertiary Text | `#3C3C43` (30%) | 占位符、辅助说明 |
| Quaternary Text | `#3C3C43` (18%) | 禁用状态文字 |

#### 分隔线

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Separator | `rgba(60, 60, 67, 0.12)` | 分隔线 |
| Separator Opaque | `#C6C6C8` | 不透明分隔线 |

---

## 3️⃣ 字体规范

### 3.1 字体家族

```
主字体：SF Pro（系统字体，iOS 自动使用）
备选字体：.SF Pro Text, -apple-system, system-ui
等宽字体：SF Mono（用于代码、数字显示）
```

> Flutter 中使用 `CupertinoTextThemeData` 或 `TextTheme` 自动继承系统字体

### 3.2 字号层级

| 名称 | 字号 | 字重 | 行高 | 用途 |
|------|------|------|------|------|
| Large Title | 34px | Bold (700) | 41px | 页面大标题 |
| Title 1 | 28px | Bold (700) | 34px | 区块标题 |
| Title 2 | 22px | Bold (700) | 28px | 卡片标题 |
| Title 3 | 20px | Semibold (600) | 25px | 次级标题 |
| Headline | 17px | Semibold (600) | 22px | 列表项标题 |
| Body | 17px | Regular (400) | 22px | 主要内容 |
| Callout | 16px | Regular (400) | 21px | 召唤行动 |
| Subhead | 15px | Regular (400) | 20px | 副标题 |
| Footnote | 13px | Regular (400) | 18px | 脚注说明 |
| Caption 1 | 12px | Regular (400) | 16px | 辅助说明 |
| Caption 2 | 11px | Regular (400) | 13px | 小标签 |

### 3.3 Flutter 字体配置

```dart
// 方式一：使用 ThemeData
ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
  ),
)

// 方式二：使用 CupertinoThemeData
CupertinoThemeData(
  textTheme: const CupertinoTextThemeData(
    navLargeTitleTextStyle: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    navTitleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
  ),
)
```

---

## 4️⃣ 间距系统

### 基础网格：8px

> 所有间距必须是 8px 的倍数，保证视觉一致性

### 间距体系

| 名称 | 大小 | 用途 |
|------|------|------|
| xxs | 4px | 紧凑元素间距 |
| xs | 8px | 小间距、图标与文字 |
| sm | 12px | 组件内部间距 |
| md | 16px | 标准间距、列表项 |
| lg | 24px | 区块间距 |
| xl | 32px | 页面区块间距 |
| xxl | 48px | 大区块分隔 |

### 布局规则

| 项目 | 值 |
|------|------|
| 页面水平边距 | 16px |
| 页面安全区 | 自动适配 |
| 卡片内边距 | 16px |
| 列表项高度 | 44px（最小触控） |
| 列表项间距 | 0px（用分隔线）|
| 组件间距 | 8/12/16/24px |

---

## 5️⃣ 圆角规范

### 统一圆角系统

| 名称 | 大小 | 用途 |
|------|------|------|
| none | 0px | 全屏页面角落 |
| small | 8px | 输入框、小按钮 |
| medium | 10px | 输入框、Tag |
| large | 12px | 主要按钮 |
| xlarge | 16px | 卡片、容器 |
| xxlarge | 20px | 大卡片 |
| full | 999px | 胶囊按钮、Chip |

### 组件圆角对照

| 组件 | 圆角 |
|------|------|
| 主按钮 | 12px |
| 次按钮 | 12px |
| 输入框 | 10px |
| 卡片 | 16px |
| 大卡片 | 20px |
| 头像 | 50%（圆形）|
| 标签/Chip | 999px（胶囊）|
| 底部弹窗 | 20px（顶部）|
| Alert 对话框 | 14px |
| 开关 | 状态指示器 |

---

## 6️⃣ 组件规范

### 6.1 主题配置

```dart
// app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF007AFF);
  static const Color primaryLight = Color(0xFF0A84FF);
  
  // Semantic
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = Color(0xFF5AC8FA);
  
  // Dark Mode
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF1C1C1E);
  static const Color darkSurfaceElevated = Color(0xFF2C2C2E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8E8E93);
  
  // Light Mode
  static const Color lightBackground = Color(0xFFF2F2F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0x993C3C43); // 60%
}

class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  static const double small = 8;
  static const double medium = 10;
  static const double large = 12;
  static const double xlarge = 16;
  static const double xxlarge = 20;
  static const double full = 999;
}
```

### 6.2 主按钮 PrimaryButton

**样式**
- 背景：`#007AFF`（深色模式）`#007AFF`（浅色模式）
- 圆角：12px
- 高度：50px（主要操作）/ 44px（次要操作）
- 文字：17px Semibold 白色
- 禁用：50% 透明度

**Flutter 实现**

```dart
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.large),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading
            ? const CupertinoActivityIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
```

**使用示例**

```dart
// 完整宽度主按钮
PrimaryButton(
  text: '登录',
  isFullWidth: true,
  onPressed: () => _login(),
)

// 加载状态
PrimaryButton(
  text: '提交',
  isLoading: _isSubmitting,
  onPressed: _isSubmitting ? null : _submit,
)
```

---

### 6.3 次按钮 SecondaryButton

**样式**
- 背景：透明
- 边框：`1px #007AFF`
- 圆角：12px
- 高度：50px
- 文字：17px Semibold 主色

**Flutter 实现**

```dart
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.large),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
```

---

### 6.4 卡片 Card

**样式**
- 背景：Surface 色
- 圆角：16px
- 内边距：16px
- 阴影：轻度（浅色模式）/ 无（深色模式）

**Flutter 实现**

```dart
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? (isDark 
            ? AppColors.darkSurface 
            : AppColors.lightSurface),
        borderRadius: BorderRadius.circular(AppRadius.xlarge),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.xlarge),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppSpacing.md),
            child: child,
          ),
        ),
      ),
    );
  }
}
```

**使用示例**

```dart
// 基础卡片
AppCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('标题', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      Text('内容描述...'),
    ],
  ),
)

// 可点击卡片
AppCard(
  onTap: () => _navigateToDetail(),
  child: Row(
    children: [
      Icon(Icons.chevron_right),
      Expanded(child: Text('查看详情')),
    ],
  ),
)
```

---

### 6.5 列表项 ListTile

**样式**
- 高度：44px（标准）/ 56px（带副标题）
- 左图标：24x24px，距左边缘 16px
- 主文字：17px Regular
- 副文字：15px Regular，次色
- 右箭头：Chevron 图标，次色

**Flutter 实现**

```dart
class AppListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  const AppListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: subtitle != null ? 56 : 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          color: textColor,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 15,
                            color: secondaryColor,
                          ),
                        ),
                    ],
                  ),
                ),
                if (trailing != null)
                  trailing!
                else if (onTap != null)
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 20,
                    color: secondaryColor,
                  ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Container(
            margin: EdgeInsets.only(left: leading != null ? 52 : 16),
            height: 0.5,
            color: isDark 
                ? Colors.white.withOpacity(0.12) 
                : Colors.black.withOpacity(0.12),
          ),
      ],
    );
  }
}
```

**使用示例**

```dart
// 基础列表项
AppListTile(
  leading: Icon(CupertinoIcons.person),
  title: '个人资料',
  onTap: () => _openProfile(),
)

// 带副标题
AppListTile(
  leading: Icon(CupertinoIcons.mail),
  title: '邮箱',
  subtitle: 'user@example.com',
  trailing: Icon(CupertinoIcons.pencil, size: 20),
  onTap: () => _editEmail(),
)

// 设置列表
Column(
  children: [
    AppListTile(
      leading: Icon(CupertinoIcons.bell),
      title: '通知',
      trailing: CupertinoSwitch(value: _notifications, onChanged: ...),
      showDivider: false,
    ),
    AppListTile(
      leading: Icon(CupertinoIcons.lock),
      title: '隐私',
      onTap: () => _openPrivacy(),
    ),
  ],
)
```

---

### 6.6 输入框 AppTextField

**样式**
- 背景：Surface Elevated 色
- 圆角：10px
- 内边距：12px 水平，14px 垂直
- 边框：无（聚焦时显示主色边框）
- Placeholder：次色

**Flutter 实现**

```dart
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final Widget? prefix;
  final Widget? suffix;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? errorText;

  const AppTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.prefix,
    this.suffix,
    this.autofocus = false,
    this.focusNode,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: isDark 
                ? AppColors.darkSurfaceElevated 
                : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppRadius.medium),
            border: Border.all(
              color: errorText != null 
                  ? AppColors.error 
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            autofocus: autofocus,
            focusNode: focusNode,
            prefix: prefix != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: prefix,
                  )
                : null,
            suffix: suffix != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: suffix,
                  )
                : null,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.medium),
            ),
            style: TextStyle(
              fontSize: 17,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
            placeholderStyle: TextStyle(
              fontSize: 17,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            errorText!,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
```

**使用示例**

```dart
// 基础输入框
AppTextField(
  controller: _emailController,
  placeholder: '请输入邮箱',
  label: '邮箱',
  keyboardType: TextInputType.emailAddress,
)

// 带图标
AppTextField(
  controller: _passwordController,
  placeholder: '请输入密码',
  label: '密码',
  obscureText: _obscurePassword,
  prefix: Icon(CupertinoIcons.lock, color: Colors.grey),
  suffix: IconButton(
    icon: Icon(_obscurePassword 
        ? CupertinoIcons.eye 
        : CupertinoIcons.eye_slash),
    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
  ),
)

// 错误状态
AppTextField(
  controller: _codeController,
  placeholder: '请输入验证码',
  errorText: _errorMessage,
)
```

---

### 6.7 标签 Chip / Badge

**样式**
- 背景：15% 主色
- 文字：12px Semibold 主色
- 圆角：999px（胶囊形）
- 内边距：6px 水平，4px 垂直
- 边框：无

**Flutter 实现**

```dart
class AppChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool selected;

  const AppChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = selected
        ? AppColors.primary
        : (backgroundColor ?? AppColors.primary.withOpacity(0.15));
    final fgColor = selected
        ? Colors.white
        : (textColor ?? AppColors.primary);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: fgColor,
          ),
        ),
      ),
    );
  }
}

// Badge（带数字的小标签）
class AppBadge extends StatelessWidget {
  final int count;
  final int? maxCount;
  final Color? backgroundColor;

  const AppBadge({
    super.key,
    required this.count,
    this.maxCount = 99,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    
    final displayCount = count > maxCount! ? '$maxCount+' : '$count';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.error,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        displayCount,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
```

**使用示例**

```dart
// 筛选标签组
Wrap(
  spacing: 8,
  children: [
    AppChip(label: '全部', selected: true),
    AppChip(label: '已完成', onTap: () => _filter('completed')),
    AppChip(label: '进行中', onTap: () => _filter('ongoing')),
    AppChip(label: '已取消', onTap: () => _filter('cancelled')),
  ],
)

// 通知数量 Badge
Row(
  children: [
    Icon(CupertinoIcons.bell),
    AppBadge(count: 5), // 显示 "5"
    AppBadge(count: 150, maxCount: 99), // 显示 "99+"
  ],
)
```

---

## 7️⃣ 图标规范

### 7.1 图标库选择

| 图标库 | 用途 | 建议 |
|--------|------|------|
| **Cupertino Icons** | iOS 原生风格 | ✅ 首选 |
| Material Icons | Android 风格 | ⚠️ 谨慎使用 |
| Lucide Icons | 现代线条风格 | 可用于特色图标 |

### 7.2 图标尺寸规范

| 场景 | 尺寸 |
|------|------|
| Tab Bar 图标 | 28px |
| Navigation Bar 图标 | 22px |
| List Item 引导图标 | 24px |
| 按钮内图标 | 20px |
| 内联小图标 | 16px |
| 装饰图标 | 48-64px |

### 7.3 图标颜色规范

| 场景 | 颜色 |
|------|------|
| Tab Bar 选中 | Primary `#007AFF` |
| Tab Bar 未选中 | `#8E8E93` |
| List Item 引导图标 | Primary `#007AFF` |
| 次要图标 | `#8E8E93` |
| 图标按钮 | 跟随上下文 |

### 7.4 常用图标对照

```dart
// 导航相关
CupertinoIcons.home / home_filled
CupertinoIcons.person / person_fill
CupertinoIcons.search
CupertinoIcons.settings
CupertinoIcons.heart / heart_fill
CupertinoIcons.bell / bell_fill

// 操作相关
CupertinoIcons.plus
CupertinoIcons.minus
CupertinoIcons.xmark
CupertinoIcons.checkmark
CupertinoIcons.pencil
CupertinoIcons.trash
CupertinoIcons.share

// 内容相关
CupertinoIcons.doc_text
CupertinoIcons.photo
CupertinoIcons.camera
CupertinoIcons.music_note

// 箭头方向
CupertinoIcons.chevron_right
CupertinoIcons.chevron_left
CupertinoIcons.arrow_up
CupertinoIcons.arrow_down

// 状态相关
CupertinoIcons.exclamationmark_circle
CupertinoIcons.info_circle
CupertinoIcons.checkmark_circle_fill
CupertinoIcons.xmark_circle_fill
```

---

## 8️⃣ 阴影规范

### 8.1 阴影层级

| 层级 | 用途 | 参数 |
|------|------|------|
| 无阴影 | 深色模式卡片 | - |
| 轻度 | 浅色模式卡片 | `0 2px 8px rgba(0,0,0,0.06)` |
| 中度 | 浮层、底部弹窗 | `0 4px 16px rgba(0,0,0,0.12)` |
| 重度 | Modal、Dialog | `0 8px 32px rgba(0,0,0,0.24)` |
| 强调 | 浮动按钮 FAB | `0 4px 12px rgba(0,122,255,0.3)` |

### 8.2 Flutter 阴影实现

```dart
// 卡片阴影（浅色模式）
BoxShadow(
  color: Colors.black.withOpacity(0.06),
  blurRadius: 8,
  offset: const Offset(0, 2),
),

// 底部弹窗阴影
BoxShadow(
  color: Colors.black.withOpacity(0.15),
  blurRadius: 24,
  offset: const Offset(0, -4),
),

// Dialog 阴影
BoxShadow(
  color: Colors.black.withOpacity(0.25),
  blurRadius: 32,
  offset: const Offset(0, 8),
),

// 主色强调阴影（按钮悬停/按下）
BoxShadow(
  color: AppColors.primary.withOpacity(0.3),
  blurRadius: 12,
  offset: const Offset(0, 4),
),
```

### 8.3 深色模式阴影处理

> **重要**：深色模式下避免使用阴影，改用边框或背景对比度区分层级

```dart
// 深色模式卡片 - 使用边框而非阴影
Container(
  decoration: BoxDecoration(
    color: AppColors.darkSurface,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.white.withOpacity(0.1),
      width: 0.5,
    ),
  ),
)

// 浅色模式卡片 - 使用阴影
Container(
  decoration: BoxDecoration(
    color: AppColors.lightSurface,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  ),
)
```

---

## 📋 使用检查清单

开发新页面或组件时，确保：

### 色彩
- [ ] 使用统一的 Primary 色 `#007AFF`
- [ ] 语义色正确使用（Success/Warning/Error）
- [ ] 深色/浅色模式色彩适配

### 字体
- [ ] 字号按层级使用，不随意调整
- [ ] 重要文字加粗，次要文字用次色

### 间距
- [ ] 所有间距使用 8px 网格倍数
- [ ] 页面边距 16px
- [ ] 组件间距 8/12/16/24px

### 圆角
- [ ] 按钮 12px
- [ ] 卡片 16px
- [ ] 输入框 10px
- [ ] Chip 胶囊形 999px

### 组件
- [ ] 使用统一封装的组件
- [ ] 列表项有分隔线
- [ ] 可点击元素有触控反馈

### 模式适配
- [ ] 同时支持深色/浅色模式
- [ ] 深色模式避免阴影，使用边框
- [ ] 文字色有足够对比度

---

## 🎯 快速参考

### 常用色值

| 用途 | 色值 |
|------|------|
| Primary | `#007AFF` |
| Success | `#34C759` |
| Warning | `#FF9500` |
| Error | `#FF3B30` |
| 深色背景 | `#000000` |
| 深色卡片 | `#1C1C1E` |
| 浅色背景 | `#F2F2F7` |
| 浅色卡片 | `#FFFFFF` |
| 次色文字 | `#8E8E93` (深) / `#3C3C43` 60% (浅) |

### 常用尺寸

| 元素 | 尺寸 |
|------|------|
| 页面边距 | 16px |
| 按钮高度 | 50px / 44px |
| 按钮圆角 | 12px |
| 卡片圆角 | 16px |
| 输入框圆角 | 10px |
| 列表项高度 | 44px |
| 触控最小区域 | 44x44px |

### 字号层级

| 层级 | 大小 | 字重 |
|------|------|------|
| 大标题 | 34px | Bold |
| 标题1 | 28px | Bold |
| 标题2 | 22px | Bold |
| 标题3 | 20px | Semibold |
| Headline | 17px | Semibold |
| Body | 17px | Regular |
| Caption | 12px | Regular |

---

## 📝 更新日志

| 日期 | 内容 |
|------|------|
| 2026-03-26 | 初始版本，Flutter 通用设计规范，整合 Apple HIG + Material Design 3 |

---

## 🔗 相关文档

- [FOCUS PRO 设计规范](./FLUTTER-DESIGN-v3.md) - 专注工具类 App 专用
- [开发文档](./docs/开发文档.md) - 技术架构设计
- [接口文档](./docs/接口文档.md) - API 接口定义
