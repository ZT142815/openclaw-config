---
name: maestro
description: Mobile E2E testing tool using YAML. Use when testing Flutter/iOS/Android apps. Supports semanticLabel, coordinate taps, and screenshot verification.
allowed-tools: Bash
---

# Maestro E2E Testing

Maestro is a mobile UI testing framework that uses YAML files to define test flows.

## Installation

```bash
# Install Maestro
curl -fsSL "https://get.maestro.mobile.dev" | /bin/bash

# Verify
maestro --version

# Required: Java 17
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
```

## Project Setup

### Directory Structure

```
项目目录/
├── .maestro/              # Maestro 测试文件
│   ├── Common.yaml         # 公共流程（清理/启动/权限）
│   ├── 01-Login.yaml       # 登录测试
│   ├── 02-FeatureA.yaml    # 功能A测试
│   └── 03-FeatureB.yaml    # 功能B测试
└── docs/
    └── 测试截图/           # 截图输出目录
```

### Flutter App Requirements

For Maestro to locate elements, add `semanticLabel` to Flutter widgets:

```dart
// ✅ 正确：Icon 添加 semanticLabel
FloatingActionButton(
  onPressed: () => context.push('/add'),
  child: Icon(Icons.add, semanticLabel: 'add_item'),
)

// ✅ 正确：输入框 Semantics wrapper
Semantics(
  label: 'email_field',
  child: TextFormField(keyboardType: TextInputType.emailAddress),
)

// ✅ 正确：按钮 Semantics wrapper
Semantics(
  label: 'login_button',
  child: ElevatedButton(
    onPressed: () => login(),
    child: const Text('登录'),
  ),
)

// ❌ 错误：ValueKey - Maestro 找不到
ValueKey('xxx')

// ❌ 错误：identifier - Maestro 不识别
Semantics(identifier: 'xxx', ...)
```

## YAML Syntax

### Basic Structure

```yaml
appId: com.example.app
name: 测试名称
---
# 步骤
- clearState
- stopApp
- launchApp
```

### Element Selection (优先级)

```yaml
# 1️⃣ 最高优先级：直接文本匹配
- tapOn: "登录"

# 2️⃣ 高优先级：semanticLabel（Flutter推荐）
- tapOn: "add_item"

# 3️⃣ 中优先级：id（需Flutter添加 Semantics(label:)）
- tapOn:
    id: "email_field"

# 4️⃣ 最后选择：坐标点击
- tapOn:
    point: "370,680"
```

## Common Commands

| 命令 | 说明 | 示例 |
|------|------|------|
| `clearState` | 清空App状态 | `clearState` |
| `stopApp` | 停止App | `stopApp` |
| `launchApp` | 启动App | `launchApp` |
| `tapOn` | 点击元素 | `tapOn: "按钮文字"` |
| `inputText` | 输入文本 | `inputText: "test@example.com"` |
| `hideKeyboard` | 隐藏键盘 | `hideKeyboard` |
| `takeScreenshot` | 截图 | `takeScreenshot: "docs/测试截图/xxx.png"` |
| `waitForAnimationToEnd` | 等待动画 | `waitForAnimationToEnd` |
| `extendedWaitUntil` | 等待元素 | `extendedWaitUntil: visible: "文字" timeout: 15000` |
| `assertVisible` | 断言可见 | `assertVisible: "首页"` |
| `back` | 返回 | `back` |
| `scroll` | 滚动 | `scroll` |
| `runFlow` | 运行子流程 | `runFlow: .maestro/Common.yaml` |

## Complete Example

### Common.yaml（必须先创建）

```yaml
appId: com.example.emotionDecoder
name: Common Flows
---
# 清空并启动
- clearState
- stopApp
- launchApp
- waitForAnimationToEnd

# 处理通知权限弹窗
- tapOn:
    text: "不允许"
    optional: true
```

### LoginFlow.yaml

```yaml
appId: com.example.emotionDecoder
name: TC-E2E-001 登录测试
---
# 1. 公共流程
- runFlow: .maestro/Common.yaml

# 2. 登录页截图
- takeScreenshot: "docs/测试截图/TC001-login.png"

# 3. 输入邮箱
- tapOn: "email_field"
- inputText: "test@example.com"

# 4. 输入密码
- tapOn: "password_field"
- inputText: "123123"

# 5. 隐藏键盘
- hideKeyboard

# 6. 截图（填写后）
- takeScreenshot: "docs/测试截图/TC002-form-filled.png"

# 7. 点击登录
- tapOn: "login_button"

# 8. 等待跳转
- waitForAnimationToEnd
- waitForAnimationToEnd

# 9. 截图（首页）
- takeScreenshot: "docs/测试截图/TC003-home.png"

# 10. 验证
- extendedWaitUntil:
    visible: "首页"
    timeout: 15000
```

## Running Tests

```bash
# 设置 Java（必须！）
export JAVA_HOME=$(/usr/libexec/java_home -v 17)

# 运行单个测试
maestro test .maestro/LoginFlow.yaml

# 运行所有测试
maestro test .maestro/

# 指定设备
maestro test .maestro/ --device "iPhone 15 Pro"
```

## SHA1 Verification

After running tests, verify screenshots are unique:

```bash
cd docs/测试截图/
shasum *.png
```

**规则**：
- ✅ 所有 SHA1 不同 = 通过
- ⚠️ 部分相同 = 检查页面是否真的不同
- ❌ 全部相同 = 测试失败，页面没有变化

## Troubleshooting

| 问题 | 原因 | 解决 |
|------|------|------|
| Element not found | 选择器错误 | 改用 semanticLabel |
| 页面没跳转 | 点击没生效 | 增加 `waitForAnimationToEnd` |
| 截图相同 | 页面没变化 | 增加等待时间 |
| 找不到按钮 | FAB 在底部 | 用坐标 `tapOn: point: "370,680"` |
| 通知弹窗阻挡 | iOS权限弹窗 | `tapOn: "不允许" optional: true` |
| 输入文字无效 | 键盘问题 | 先 `tapOn` 输入框，再 `inputText` |

## Workflow

```
1. 读取项目配置
   - test-config.json（appId、bundleId）

2. 检查 semanticLabel
   - 确认关键元素有 semanticLabel
   - 如缺失，报告 Developer 添加

3. 创建/更新 YAML 文件
   - 根据 PRD 功能列表编写测试用例

4. 运行测试
   - maestro test .maestro/

5. 截图验证
   - shasum 验证 SHA1

6. 生成报告
   - 保存到 docs/测试报告/
```

## Quick Reference

```yaml
# 最常用模板
---
- clearState
- stopApp
- launchApp
- waitForAnimationToEnd
- tapOn:
    text: "不允许"
    optional: true
- tapOn: "element_label"
- inputText: "text"
- hideKeyboard
- takeScreenshot: "path/to/screenshot.png"
- waitForAnimationToEnd
- extendedWaitUntil:
    visible: "expected_text"
    timeout: 15000
```

---

**版本**：1.0
**更新日期**：2026-03-26
**维护**：Tester Agent
