# FOCUS PRO 设计规范 - 专注工具类 App

> ⚠️ **重要**：所有专注工具类 Flutter App 开发必须遵循此规范
>
> 📅 更新日期：2026-03-23
> 📁 文件位置：`~/.openclaw/workspace-developer/FLUTTER-DESIGN-v3.md`

---

## 📑 目录

- [1️⃣ 核心理念](#1️⃣-核心理念)
- [2️⃣ 色彩系统](#2️⃣-色彩系统)
- [3️⃣ 字体规范](#3️⃣-字体规范)
- [4️⃣ 间距系统](#4️⃣-间距系统)
- [5️⃣ 圆角规范](#5️⃣-圆角规范)
- [6️⃣ 组件规范](#6️⃣-组件规范)
- [7️⃣ 图标系统](#7️⃣-图标系统)
- [📋 使用检查清单](#📋-使用检查清单)
- [🎯 快速参考](#🎯-快速参考)

---

## 1️⃣ 核心理念

| 理念 | 说明 |
|------|------|
| **渐变美学** | 使用渐变增强高级感 |
| **玻璃拟态** | 半透明 + 模糊效果提升现代感 |
| **双模式** | 深色模式（冷色调）+ 浅色模式（暖色调）|
| **专注体验** | 为专注工具类 App 打造 |

---

## 2️⃣ 色彩系统

### 2.1 深色模式（Dark Mode）

#### 主色调

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary 渐变 | `#8B5CF6` → `#A78BFA` | 按钮、强调元素 |
| 核心色 1 | `#8B5CF6` | 紫罗兰 |
| 核心色 2 | `#14B8A6` | 青绿色（成功、进度） |

#### 辅助色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Accent | `#EC4899` | 粉红（标签、提醒） |
| Warning | `#F59E0B` | 琥珀色（警告、高亮） |

#### 背景色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| 主背景 | `#0A0A0F` | 页面背景 |
| 卡片 | `#18181B` | 卡片表面 |
| 玻璃效果 | `rgba(139, 92, 246, 0.1)` | 玻璃拟态 |

#### 文字色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary | `#FFFFFF` | 标题、重要内容 |
| Secondary | `#9CA3AF` | 副标题、说明文字 |
| Disabled | `#4B5563` | 不可用状态 |

---

### 2.2 浅色模式（Light Mode）

#### 主色调

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary 渐变 | `#F97316` → `#EC4899` | 按钮、强调元素 |
| 核心色 1 | `#F97316` | 橙色 |
| 核心色 2 | `#EC4899` | 粉红色 |

#### 辅助色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Accent | `#8B5CF6` | 紫色 |
| Success | `#14B8A6` | 青绿色 |

#### 背景色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| 主背景 | `#FFFFFF` | 页面背景 |
| 表面 | `#FAFAFA` | 卡片表面 |
| 玻璃效果 | `rgba(255, 255, 255, 0.95)` | 玻璃拟态 |

#### 文字色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary | `#111827` | 标题、重要内容 |
| Secondary | `#6B7280` | 副标题、说明文字 |
| Disabled | `#D1D5DB` | 不可用状态 |

---

### 2.3 设计差异

| 方面 | 深色模式 | 浅色模式 |
|------|----------|------------|
| 主色调 | 冷色调（紫青）| 暖色调（橙粉）|
| 背景 | 深黑 | 亮白 |
| 阴影 | 更重 | 更轻 |
| 边框 | 白色透明度 | 黑色透明度 |

---

## 3️⃣ 字体规范

### 3.1 字体家族

```
主字体：Inter - 用于正文、UI 元素
显示字体：Outfit - 用于大标题、品牌文字
等宽字体：JetBrains Mono - 用于时间显示、数据
```

### 3.2 字号层级

| 名称 | 字号 | 字重 | 用途 |
|------|------|------|------|
| H1 | 36px | Black (900) | 页面主标题 |
| H2 | 24px | Bold (700) | 区块标题 |
| H3 | 18px | Bold (700) | 卡片标题 |
| Body | 16px | SemiBold (600) | 主要内容 |
| Caption | 14px | Regular (400) | 辅助说明 |
| Label | 12px | Bold (700) | 小标签（全大写）|

---

## 4️⃣ 间距系统

### 基础网格：4px

### 间距体系

| 名称 | 大小 | 用途 |
|------|------|------|
| xs | 4px | 超小间距 |
| sm | 8px | 小间距 |
| md | 12px | 默认间距 |
| lg | 16px | 标准间距 |
| xl | 20px | 中等间距 |
| 2xl | 24px | 大间距 |
| 3xl | 32px | 超大间距 |
| 4xl | 48px | 特大间距 |

### 布局规则

| 项目 | 值 |
|------|------|
| 页面水平边距 | 24px |
| 卡片内边距 | 20-32px |
| 元素间距 | 12-16px |

---

## 5️⃣ 圆角规范

### 4 级圆角系统

| 名称 | 大小 | 用途 |
|------|------|------|
| 屏幕容器 | 56px | App 外框 |
| 大卡片 | 40px | 主要内容卡片 |
| 中卡片/按钮 | 24px | 按钮、中等卡片 |
| 小卡片/图标 | 16px | 小组件、图标容器 |

---

## 6️⃣ 组件规范

### 6.1 主按钮 Primary Button

**样式**
- 渐变背景：`#8B5CF6` → `#A78BFA`
- 圆角：22px（深色）/ 24px（浅色）
- 阴影：`0 10px 40px rgba(139, 92, 246, 0.45)`
- 高度：48px
- 文字：16px 粗体 白色

### Flutter 实现

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(22),
    boxShadow: [
      BoxShadow(
        color: Color(0xFF8B5CF6).withOpacity(0.45),
        blurRadius: 40,
        offset: Offset(0, 10),
      ),
    ],
  ),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),
    onPressed: () {},
    child: Text('开始专注', style: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    )),
  ),
)
```

---

### 6.2 玻璃卡片 Glass Card

**样式**
- 背景：半透明渐变 + 32px 模糊效果
- 边框：`1px rgba(255,255,255,0.15)`（深色）
- 圆角：24px
- 内边距：20px

### Flutter 实现

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF8B5CF6).withOpacity(0.1),
        Color(0xFF14B8A6).withOpacity(0.05),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: Colors.white.withOpacity(0.15),
    ),
  ),
  padding: EdgeInsets.all(20),
  child: // 卡片内容
)
```

---

### 6.3 状态标签 Badge

**样式**
- 圆角：胶囊形（full）
- 背景：15% 透明度
- 边框：25% 透明度
- 文字：12px 粗体

---

## 7️⃣ 图标系统

| 项目 | 规范 |
|------|------|
| 图标库 | Lucide Icons / Material Icons |
| 标准尺寸 | 24x24px |
| 容器尺寸 | 48x48px |
| 容器圆角 | 16px |
| 颜色 | `#A78BFA`（深色模式）|

---

## 📋 使用检查清单

开发时确保：

- [ ] 使用统一色彩（深色 #8B5CF6 / 浅色 #F97316）
- [ ] 字号按层级使用（H1 到 Label）
- [ ] 按钮圆角 22-24px
- [ ] 卡片圆角 24-40px
- [ ] 使用渐变效果
- [ ] 使用玻璃拟态
- [ ] 有阴影层次
- [ ] 有动画过渡

---

## 🎯 快速参考

### 深色模式常用色值

| 用途 | 色值 |
|------|------|
| 主色渐变 | `#8B5CF6` → `#A78BFA` |
| 成功色 | `#14B8A6` |
| 警告色 | `#F59E0B` |
| 主背景 | `#0A0A0F` |
| 卡片背景 | `#18181B` |
| 主文本 | `#FFFFFF` |
| 次文本 | `#9CA3AF` |

### 浅色模式常用色值

| 用途 | 色值 |
|------|------|
| 主色渐变 | `#F97316` → `#EC4899` |
| 成功色 | `#14B8A6` |
| 主背景 | `#FFFFFF` |
| 卡片背景 | `#FAFAFA` |
| 主文本 | `#111827` |
| 次文本 | `#6B7280` |

### 常用尺寸

| 元素 | 尺寸 |
|------|------|
| 按钮高度 | 48px |
| 按钮圆角 | 22-24px |
| 卡片圆角 | 24-40px |
| 页面边距 | 24px |
| 组件间距 | 12-16px |

### 字号

| 层级 | 大小 |
|------|------|
| H1 | 36px |
| H2 | 24px |
| H3 | 18px |
| Body | 16px |
| Caption | 14px |
| Label | 12px |

---

## 📝 更新日志

| 日期 | 内容 |
|------|------|
| 2026-03-23 | 初始版本，FOCUS PRO 设计规范 |
