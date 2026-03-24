# Flutter 设计规范 - Apple 风格

> ⚠️ **重要**：所有 Flutter App 开发必须遵循此规范
>
> 📅 更新日期：2026-03-23
> 📁 文件位置：`~/.openclaw/workspace-developer/FLUTTER-DESIGN.md`

---

## 📋 设计原则

> **核心目标**：所有 App 视觉体验一致，通过统一的色彩、字号、间距、圆角实现

| 框架 | 推荐 | 说明 |
|------|------|------|
| **iOS** | Cupertino | 100% 原生体验 |
| **Android** | Material 3 | 跨平台可用 |

**关键**：无论用什么框架，视觉规范（色彩、字号、圆角）必须统一！

---

## 📑 目录

- [1️⃣ 核心理念](#1️⃣-核心理念)
- [2️⃣ 色彩系统](#2️⃣-色彩系统)
- [3️⃣ 字号体系](#3️⃣-字号体系)
- [4️⃣ 间距与圆角](#4️⃣-间距与圆角)
- [5️⃣ 按钮](#5️⃣-按钮)
- [6️⃣ 输入框](#6️⃣-输入框)
- [7️⃣ 卡片](#7️⃣-卡片)
- [8️⃣ 列表](#8️⃣-列表)
- [9️⃣ 导航](#9️⃣-导航)
- [🔟 弹窗与提示](#🔟-弹窗与提示)
- [📋 使用检查清单](#📋-使用检查清单)
- [🎯 快速参考](#🎯-快速参考)

---

## 1️⃣ 核心理念

| 理念 | 说明 |
|------|------|
| **Apple 风格** | 遵循 iOS Human Interface Guidelines |
| **简洁现代** | 界面干净、留白合理 |
| **层级分明** | 信息层次清晰，主次分明 |
| **原生体验** | 接近 iOS 原生应用体验 |

---

## 2️⃣ 色彩系统

### 2.1 系统色彩

| 颜色名称 | 色值 | 用途 |
|----------|------|------|
| **Blue** | `#007AFF` | 主要操作、链接、选中状态 |
| **Green** | `#34C759` | 成功、完成、正确 |
| **Orange** | `#FF9500` | 警告、注意 |
| **Red** | `#FF3B30` | 错误、删除、危险操作 |
| **Purple** | `#AF52DE` | 辅助强调 |
| **Pink** | `#FF2D55` | 辅助强调 |

### 2.2 背景色

| 名称 | 色值 | 用途 |
|------|------|------|
| 主要背景 | `#FFFFFF` | 卡片、浮层 |
| 次要背景 | `#F2F2F7` | 页面背景 |
| 三级背景 | `#E5E5EA` | 分隔线、输入框背景 |

### 2.3 文字色

| 名称 | 色值 | 用途 |
|------|------|------|
| 主要文字 | `#000000` | 标题、重要内容 |
| 次要文字 | `#3C3C43` (60%) | 正文内容 |
| 三级文字 | `#3C3C43` (30%) | 辅助信息 |
| 占位文字 | `#3C3C43` (18%) | placeholder |

---

## 3️⃣ 字号体系

| 名称 | 大小 | 字重 | 用途 |
|------|------|------|------|
| Large Title | 34px | 700 | 页面大标题 |
| Title 1 | 28px | 700 | 标题 |
| Title 2 | 22px | 700 | 章节标题 |
| Title 3 | 20px | 600 | 小节标题 |
| Headline | 17px | 600 | 列表标题 |
| Body | 17px | 400 | 正文内容 |
| Callout | 16px | 400 | 说明文字 |
| Subhead | 15px | 400 | 副标题 |
| Footnote | 13px | 400 | 注释、备注 |
| Caption 1 | 12px | 400 | 小标签 |

### Flutter 实现

```dart
// 在 ThemeData 中配置
textTheme: TextTheme(
  displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
  titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
  titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
  titleSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  headlineMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
  bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  bodySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
  labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
  labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
)
```

---

## 4️⃣ 间距与圆角

### 4.1 间距（8px 网格）

| 名称 | 大小 | 用途 |
|------|------|------|
| xs | 4px | 元素内部 |
| sm | 8px | 紧凑间距 |
| md | 16px | 标准间距 |
| lg | 24px | 模块间距 |
| xl | 32px | 区块间距 |
| xxl | 48px | 页面间距 |

### 4.2 圆角

| 名称 | 大小 | 用途 |
|------|------|------|
| sm | 8px | 按钮、小元素 |
| md | 12px | 输入框 |
| lg | 16px | 卡片 |
| xl | 20px | 大卡片、浮层 |

---

## 5️⃣ 按钮

### 5.1 主按钮

```dart
// 主要按钮
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF007AFF),
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
  ),
  onPressed: () {},
  child: Text('主要按钮'),
)
```

### 5.2 按钮类型

| 类型 | 样式 |
|------|------|
| **Primary** | 蓝色填充 + 白色文字 |
| **Secondary** | 白色背景 + 边框 + 蓝色文字 |
| **Danger** | 红色填充 + 白色文字 |
| **Text** | 透明背景 + 蓝色文字 |

### 5.3 交互状态

- 按下：scale(0.98) + opacity(0.9)
- 禁用：opacity(0.4)

---

## 6️⃣ 输入框

### 6.1 基本样式

```dart
TextField(
  style: TextStyle(fontSize: 17),
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFC6C6C8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFC6C6C8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF007AFF), width: 2),
    ),
    hintStyle: TextStyle(color: Color(0x3C3C4399)),
  ),
)
```

### 6.2 样式规范

| 属性 | 值 |
|------|------|
| 圆角 | 12px |
| 边框 | 1px #C6C6C8 |
| 聚焦边框 | 2px #007AFF |
| 内边距 | 16px 水平, 14px 垂直 |
| 字号 | 17px |

---

## 7️⃣ 卡片

### 7.1 基本样式

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
  padding: EdgeInsets.all(20),
  child: Column(
    children: [
      // 卡片内容
    ],
  ),
)
```

### 7.2 样式规范

| 属性 | 值 |
|------|------|
| 背景 | 白色 |
| 圆角 | 16px |
| 阴影 | 0 2px 8px rgba(0,0,0,0.1) |
| 内边距 | 20px |

---

## 8️⃣ 列表

### 8.1 列表项样式

```dart
ListTile(
  leading: Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        colors: [Color(0xFF007AFF), Color(0xFF5AC8FA)],
      ),
    ),
    child: Center(child: Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
  ),
  title: Text('标题', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
  subtitle: Text('副标题', style: TextStyle(fontSize: 15, color: Color(0xFF3C3C43))),
  trailing: Icon(Icons.chevron_right, color: Color(0xFF3C3C4366)),
)
```

### 8.2 分隔线

| 属性 | 值 |
|------|------|
| 颜色 | #3C3C4333 (20% 透明度) |
| 粗细 | 0.5px |
| 边距 | 左侧 16px 开始 |

---

## 9️⃣ 导航

### 9.1 底部导航 TabBar

```dart
BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  selectedItemColor: Color(0xFF007AFF),
  unselectedItemColor: Color(0xFF3C3C4366),
  selectedFontSize: 10,
  unselectedFontSize: 10,
)
```

### 9.2 样式规范

| 属性 | 值 |
|------|------|
| 选中颜色 | #007AFF |
| 未选颜色 | #3C3C4366 |
| 背景 | 白色 |
| 图标大小 | 24px |
| 字体大小 | 10px |

---

## 🔟 弹窗与提示

### 10.1 Alert 弹窗

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    title: Text('确认删除', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
    content: Text('确定要删除这条记录吗？', style: TextStyle(fontSize: 13, color: Color(0xFF3C3C43))),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: Text('取消')),
      TextButton(onPressed: () => Navigator.pop(context), child: Text('删除', style: TextStyle(color: Color(0xFFFF3B30)))),
    ],
  ),
)
```

### 10.2 Toast 提示

| 类型 | 背景色 | 文字色 |
|------|--------|--------|
| 成功 | #34C759 | 白色 |
| 警告 | #FF9500 | 白色 |
| 错误 | #FF3B30 | 白色 |

---

## 📋 使用检查清单

开发时确保：

- [ ] 使用系统色彩（Blue #007AFF 为主色）
- [ ] 字号按层级使用（Large Title 到 Caption）
- [ ] 按钮圆角 8px
- [ ] 输入框圆角 12px
- [ ] 卡片圆角 16px + 阴影
- [ ] 列表有分隔线（0.5px）
- [ ] 底部导航选中蓝色
- [ ] 启用 Material 3

---

## 🎯 快速参考

### 常用色值

| 用途 | 色值 |
|------|------|
| 主色 | `#007AFF` |
| 成功 | `#34C759` |
| 警告 | `#FF9500` |
| 错误 | `#FF3B30` |
| 背景 | `#F2F2F7` |
| 卡片 | `#FFFFFF` |
| 文字 | `#000000` |
| 次要文字 | `#3C3C43` |

### 常用尺寸

| 元素 | 尺寸 |
|------|------|
| 按钮圆角 | 8px |
| 输入框圆角 | 12px |
| 卡片圆角 | 16px |
| 页面边距 | 16px |
| 列表项高度 | 44px+ |

### 字号

| 层级 | 大小 |
|------|------|
| 页面标题 | 34px |
| 章节标题 | 22px |
| 列表标题 | 17px |
| 正文 | 17px |
| 副标题 | 15px |
| 注释 | 13px |

---

## 📝 更新日志

| 日期 | 内容 |
|------|------|
| 2026-03-23 | 初始版本，Apple 风格设计规范 |
