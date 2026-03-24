# Flutter 设计规范 - 现代化紫色风格

> ⚠️ **重要**：所有 Flutter App 开发必须遵循此规范
>
> 📅 更新日期：2026-03-23
> 📁 文件位置：`~/.openclaw/workspace-developer/FLUTTER-DESIGN.md`

---

## 📑 目录

- [1️⃣ 核心理念](#1️⃣-核心理念)
- [2️⃣ 色彩系统](#2️⃣-色彩系统)
- [3️⃣ 间距系统](#3️⃣-间距系统)
- [4️⃣ 字体系统](#4️⃣-字体系统)
- [5️⃣ 组件规范](#5️⃣-组件规范)
- [6️⃣ 视觉效果](#6️⃣-视觉效果)
- [7️⃣ 布局规范](#7️⃣-布局规范)
- [8️⃣ 交互反馈](#8️⃣-交互反馈)
- [📋 使用检查清单](#📋-使用检查清单)
- [🎯 快速参考](#🎯-快速参考)

---

## 1️⃣ 核心理念

| 理念 | 说明 |
|------|------|
| **现代化设计** | 玻璃拟态、渐变效果 |
| **年轻活力** | 紫色系主调，视觉冲击力强 |
| **双模式支持** | 深色模式 + 浅色模式完整支持 |
| **默认浅色** | 默认使用浅色背景，简洁明亮 |
| **沉浸体验** | 全屏沉浸式设计 |

---

## 2️⃣ 色彩系统

### 2.1 深色模式（Dark Mode）

#### 主色调

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary | `#8B5CF6` | 主要操作、强调 |
| Secondary | `#14B8A6` | 次要操作、信息 |
| Accent | `#EC4899` | 特殊标记、热点 |

#### 背景层级

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary Background | `#09090B` | 主背景 |
| Surface Background | `#18181B` | 卡片、组件 |
| Elevated Surface | `#27272A` | 悬浮层 |

#### 功能色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Success | `#10B981` | 成功状态 |
| Warning | `#F59E0B` | 警告提示 |
| Error | `#EF4444` | 错误、危险 |
| Info | `#3B82F6` | 信息提示 |

#### 文本色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary Text | `#FFFFFF` (100%) | 标题、重要文本 |
| Secondary Text | `#A1A1AA` (65%) | 辅助文本 |
| Tertiary Text | `#71717A` (45%) | 说明文本 |
| Disabled Text | `#52525B` (30%) | 禁用状态 |

#### 边框/分割线

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Border Primary | `rgba(255,255,255,0.12)` | 主要边框 |
| Border Secondary | `rgba(255,255,255,0.08)` | 次要边框 |
| Divider | `rgba(255,255,255,0.06)` | 分割线 |

---

### 2.2 浅色模式（Light Mode）

#### 主色调

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary | `#7C3AED` | 主要操作 |
| Secondary | `#0D9488` | 次要操作 |
| Accent | `#DB2777` | 特殊标记 |

#### 背景层级（默认浅色模式）

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary Background | `#F8F9FA` | 主背景（浅灰，更护眼）|
| Surface Background | `#FFFFFF` | 卡片、组件（白色）|
| Elevated Surface | `#FFFFFF` | 悬浮层（白色）|

> 💡 提示：如需深色模式，可切换到 Dark 主题

#### 功能色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Success | `#059669` | 成功状态 |
| Warning | `#D97706` | 警告提示 |
| Error | `#DC2626` | 错误、危险 |
| Info | `#2563EB` | 信息提示 |

#### 文本色

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Primary Text | `#18181B` (90%) | 标题 |
| Secondary Text | `#52525B` (70%) | 辅助文本 |
| Tertiary Text | `#A1A1AA` (50%) | 说明文本 |
| Disabled Text | `#D4D4D8` (30%) | 禁用状态 |

#### 边框/分割线

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| Border Primary | `rgba(0,0,0,0.12)` | 主要边框 |
| Border Secondary | `rgba(0,0,0,0.08)` | 次要边框 |
| Divider | `rgba(0,0,0,0.06)` | 分割线 |

---

## 3️⃣ 间距系统

### 标准间距尺度（基于 4px 网格）

| 名称 | 大小 | 用途 |
|------|------|------|
| xs | 4px | 图标间距 |
| sm | 8px | 元素内边距 |
| md | 16px | 组件间距 |
| lg | 24px | 区块间距 |
| xl | 32px | 页面内边距 |
| 2xl | 48px | 大区块间距 |

### 页面布局

| 名称 | 大小 | 用途 |
|------|------|------|
| 左右边距 | 24px | 页面边缘 |
| 顶部安全区 | 44px | 状态栏 |
| 底部安全区 | 34px | Home Indicator |

---

## 4️⃣ 字体系统

### 字体家族

```
主字体：Inter (Google Fonts)
展示字体：Inter / SF Pro Display
```

### 字阶体系

| 用途 | 字号 | 字重 | 行高 |
|------|------|------|------|
| H1 | 32px | 800 (Black) | 40px |
| H2 | 24px | 700 (Bold) | 32px |
| H3 | 20px | 700 (Bold) | 28px |
| H4 | 18px | 600 (SemiBold) | 26px |
| Body Large | 16px | 500 (Medium) | 24px |
| Body | 14px | 400 (Regular) | 22px |
| Caption | 12px | 500 (Medium) | 18px |
| Overline | 10px | 700 (Bold) | 16px |

### 字体样式规则

| 类型 | 样式 |
|------|------|
| 标题 | 字重 700-900，字母间距 -0.02em |
| 正文 | 字重 400-500，字母间距 0 |
| 辅助文本 | 字重 500-600，字母间距 0.02em，全大写 |

---

## 5️⃣ 组件规范

### 5.1 按钮（Buttons）

#### 主按钮（Primary Button）

**深色模式**
- 背景：线性渐变 `#8B5CF6` → `#A78BFA`
- 文字：`#FFFFFF`，字重 700
- 高度：48px
- 圆角：20px
- 阴影：`0 8px 32px rgba(139,92,246,0.4)`

**浅色模式**
- 背景：线性渐变 `#7C3AED` → `#9333EA`
- 阴影：`0 8px 24px rgba(124,58,237,0.3)`

#### 按钮尺寸

| 尺寸 | 高度 | 左右内边距 |
|------|------|------------|
| Large | 48px | 16px |
| Medium | 40px | 14px |
| Small | 32px | 12px |

#### Flutter 实现

```dart
// 主按钮
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Color(0xFF8B5CF6).withOpacity(0.4),
        blurRadius: 32,
        offset: Offset(0, 8),
      ),
    ],
  ),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    onPressed: () {},
    child: Text('主按钮', style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
    )),
  ),
)
```

---

### 5.2 卡片（Cards）

#### 玻璃拟态卡片

**深色模式**
- 背景：`linear-gradient(135deg, rgba(139,92,246,0.08), rgba(20,184,166,0.05))`
- 背景模糊：24px，饱和度 180%
- 边框：`1px rgba(255,255,255,0.12)`
- 圆角：24-32px
- 阴影：`0 8px 32px rgba(0,0,0,0.35)`

**浅色模式**
- 背景：`#FFFFFF`
- 边框：`1px rgba(0,0,0,0.08)`
- 阴影：`0 4px 24px rgba(0,0,0,0.08)`

#### Flutter 实现

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF8B5CF6).withOpacity(0.08),
        Color(0xFF14B8A6).withOpacity(0.05),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: Colors.white.withOpacity(0.12),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.35),
        blurRadius: 32,
        offset: Offset(0, 8),
      ),
    ],
  ),
  padding: EdgeInsets.all(20),
  child: // 卡片内容
)
```

---

### 5.3 输入框（Input Fields）

#### 标准输入框

**深色模式**
- 背景：`rgba(255,255,255,0.04)`
- 边框：`1px rgba(255,255,255,0.08)`
- 高度：48px
- 圆角：18px
- Focus 状态：边框变为 `#8B5CF6`，外发光 `0 0 0 3px rgba(139,92,246,0.15)`

**浅色模式**
- 背景：`#F8F9FA`
- 边框：`1px rgba(0,0,0,0.12)`
- Focus 状态：边框变为 `#7C3AED`

#### Flutter 实现

```dart
TextField(
  style: TextStyle(fontSize: 16),
  decoration: InputDecoration(
    filled: true,
    fillColor: Color(0x0FFFFFFF),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Color(0xFF8B5CF6), width: 2),
    ),
  ),
)
```

---

### 5.4 图标（Icons）

#### 尺寸规范

| 尺寸 | 大小 |
|------|------|
| Extra Small | 16px |
| Small | 20px |
| Medium | 24px |
| Large | 32px |
| Extra Large | 48px |

#### 样式规范

- 使用 Lucide Icons 或 Material Icons
- 线宽：2px（标准），1.5px（细线）
- 颜色跟随文本色或品牌色

---

## 6️⃣ 视觉效果

### 6.1 阴影系统

#### 深色模式

| Level | 阴影 |
|-------|-------|
| Level 1 | `0 2px 8px rgba(0,0,0,0.15)` |
| Level 2 | `0 4px 16px rgba(0,0,0,0.25)` |
| Level 3 | `0 8px 32px rgba(0,0,0,0.35)` |
| Level 4 | `0 20px 60px rgba(0,0,0,0.45)` |

#### 浅色模式

| Level | 阴影 |
|-------|-------|
| Level 1 | `0 2px 8px rgba(0,0,0,0.06)` |
| Level 2 | `0 4px 16px rgba(0,0,0,0.08)` |
| Level 3 | `0 8px 32px rgba(0,0,0,0.12)` |
| Level 4 | `0 20px 60px rgba(0,0,0,0.15)` |

---

### 6.2 渐变效果

#### 品牌主渐变

```
深色：135deg, #8B5CF6 0%, #A78BFA 50%, #14B8A6 100%
浅色：135deg, #7C3AED 0%, #9333EA 50%, #0D9488 100%
```

#### 文字渐变

```
深色：135deg, #A78BFA 0%, #14B8A6 100%
浅色：135deg, #9333EA 0%, #0D9488 100%
```

---

### 6.3 动画效果

#### 过渡时长

| 速度 | 时长 |
|------|------|
| 快速 | 150ms |
| 标准 | 300ms |
| 慢速 | 500ms |

#### 缓动函数

```
标准：cubic-bezier(0.4, 0, 0.2, 1)
进入：cubic-bezier(0, 0, 0.2, 1)
退出：cubic-bezier(0.4, 0, 1, 1)
```

#### 常用动画

| 动画 | 实现 |
|------|------|
| Hover 抬升 | translateY(-2px) + 阴影增强 |
| 按压效果 | scale(0.98) |
| 淡入上移 | opacity: 0 → 1, translateY(24px) → 0 |

---

## 7️⃣ 布局规范

### 7.1 状态栏（Status Bar）

| 属性 | 值 |
|------|------|
| 高度 | 44px |
| 背景 | 半透明 + 背景模糊 20px |
| 深色 | `rgba(9,9,11,0.95)` |
| 浅色 | `rgba(255,255,255,0.95)` |

### 7.2 导航栏（Navigation Bar）

| 属性 | 值 |
|------|------|
| 底部距离 | 24px |
| 高度 | 72px（包含中央浮动按钮） |
| 背景 | 玻璃拟态效果 |
| 圆角 | 32px |

### 7.3 网格系统

| 属性 | 值 |
|------|------|
| 列数 | 6 列（移动端） |
| 间距 | 16px |
| 边距 | 24px |

---

## 8️⃣ 交互反馈

### 8.1 触摸反馈

| 操作 | 效果 |
|------|------|
| 点击 | 轻微缩放 scale(0.98) + 200ms |
| 长按 | 逐渐放大 scale(1.05) + 阴影增强 |

### 8.2 加载状态

| 类型 | 实现 |
|------|------|
| 骨架屏 | 使用渐变动画 |
| 加载动画 | 品牌色旋转指示器 |

### 8.3 错误状态

- 边框变红
- 轻微抖动动画
- 错误提示文字：12px，Error 色

---

## 📋 使用检查清单

开发时确保：

- [ ] 使用统一色彩（主色 #8B5CF6 / #7C3AED）
- [ ] 字号按层级使用（H1 到 Caption）
- [ ] 按钮圆角 20px
- [ ] 输入框圆角 18px
- [ ] 卡片圆角 24-32px
- [ ] 使用渐变效果
- [ ] 使用玻璃拟态
- [ ] 有阴影层次
- [ ] 有动画过渡

---

## 🎯 快速参考

### 深色模式常用色值

| 用途 | 色值 |
|------|------|
| 主色 | `#8B5CF6` |
| 辅助色 | `#14B8A6` |
| 强调色 | `#EC4899` |
| 成功 | `#10B981` |
| 警告 | `#F59E0B` |
| 错误 | `#EF4444` |
| 主背景 | `#09090B` |
| 卡片背景 | `#18181B` |
| 主文本 | `#FFFFFF` |
| 次文本 | `#A1A1AA` |

### 浅色模式常用色值

| 用途 | 色值 |
|------|------|
| 主色 | `#7C3AED` |
| 辅助色 | `#0D9488` |
| 强调色 | `#DB2777` |
| 成功 | `#059669` |
| 警告 | `#D97706` |
| 错误 | `#DC2626` |
| 主背景 | `#FFFFFF` |
| 卡片背景 | `#F8F9FA` |
| 主文本 | `#18181B` |
| 次文本 | `#52525B` |

### 常用尺寸

| 元素 | 尺寸 |
|------|------|
| 按钮高度 | 48px |
| 输入框高度 | 48px |
| 按钮圆角 | 20px |
| 输入框圆角 | 18px |
| 卡片圆角 | 24-32px |
| 页面边距 | 24px |
| 组件间距 | 16px |

### 字号

| 层级 | 大小 |
|------|------|
| H1 | 32px |
| H2 | 24px |
| H3 | 20px |
| Body Large | 16px |
| Body | 14px |
| Caption | 12px |

---

## 📝 更新日志

| 日期 | 内容 |
|------|------|
| 2026-03-23 | 初始版本，现代化紫色风格设计规范 |
