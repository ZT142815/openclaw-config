# TOOLS.md - Tester Agent 工具配置

## 第四层：工具层

> **Tester 可用的工具和能力**
> **每次启动时读取，了解可用资源**

---

## ⚠️ 测试流程规范（必须遵循）

### 1. 超时机制
- **单次测试最大运行时间：5 分钟**
- 超过 5 分钟自动停止并汇报当前状态
- 遇到死循环立即停止

### 2. 状态汇报
- 每 30 秒汇报一次进度
- 汇报内容：用例进度、当前执行的测试
- 遇到阻塞立即汇报 CEO

### 3. 失败处理
- 测试失败 → 立即汇报 CEO
- CEO 会直接调度 Developer 修复
- 修复后自动重新测试

### 4. 测试报告
- 必须保存到 `docs/测试报告/` 目录
- 报告格式见第6节

---

## 一、已安装的测试工具

| 工具 | 版本 | 用途 |
|------|------|------|
| **Playwright** | 1.58.2 | Web 自动化测试、视觉回归 |
| **Appium** | 3.2.2 | iOS 自动化测试 |
| **XCUITest Driver** | 10.33.0 | iOS 原生测试支持 |

---

## 二、Web 测试工具 - Playwright

### 2.1 安装验证

```bash
# 验证安装
npx playwright --version

# 列出可用浏览器
npx playwright install --dry-run
```

### 2.2 测试脚本示例

```typescript
// tests/web/login.spec.ts
import { test, expect } from '@playwright/test';

test('登录功能测试', async ({ page }) => {
  // 访问页面
  await page.goto('http://localhost:3000');
  
  // 输入用户名密码
  await page.fill('#username', 'testuser');
  await page.fill('#password', 'password123');
  
  // 点击登录
  await page.click('#login-button');
  
  // 验证跳转
  await expect(page).toHaveURL(/.*dashboard/);
});
```

### 2.3 视觉回归测试

```typescript
// 截图对比
import { test } from '@playwright/test';

test('首页视觉回归', async ({ page }) => {
  await page.goto('http://localhost:3000');
  
  // 截图
  await page.screenshot({ 
    path: 'tests/baseline/home.png',
    fullPage: true 
  });
  
  // 对比（使用 pixelmatch 或 Playwright 内置）
  // Playwright 会自动对比 baseline
});
```

### 2.4 配置文件

```json
// playwright.config.ts
import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests/web',
  timeout: 30000,
  retries: 2,
  use: {
    baseURL: 'http://localhost:3000',
    screenshot: 'only-on-failure',
  },
});
```

---

## 三、iOS 测试工具 - Appium

### 3.1 启动 Appium

```bash
# 启动 Appium Server
appium

# 或指定端口
appium --address 127.0.0.1 --port 4723
```

### 3.2 测试脚本示例（Python）

```python
# tests/ios/test_login.py
from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy

desired_caps = {
    'platformName': 'iOS',
    'platformVersion': '17.5',
    'deviceName': 'iPhone 15 Pro',
    'bundleId': 'com.example.app',
    'automationName': 'XCUITest',
    'app': '/path/to/app.app'
}

def test_login():
    driver = webdriver.Remote('http://localhost:4723/wd/hub', desired_caps)
    
    # 查找元素
    username_field = driver.find_element(AppiumBy.ID, 'username')
    password_field = driver.find_element(AppiumBy.ID, 'password')
    login_button = driver.find_element(AppiumBy.ID, 'login-button')
    
    # 输入
    username_field.send_keys('testuser')
    password_field.send_keys('password123')
    
    # 点击
    login_button.click()
    
    # 验证
    # ...
    
    driver.quit()
```

### 3.3 Appium 驱动检查

```bash
# 检查已安装的驱动
appium driver list --installed

# 安装 XCUITest 驱动（如需要）
appium driver install xcuitest
```

---

## 四、iOS Simulator 管理

### 4.1 常用命令

```bash
# 列出可用模拟器
xcrun simctl list devices available

# 查看特定版本
xcrun simctl list devices available | grep "iOS 17.5"

# 启动模拟器
xcrun simctl boot "iPhone 15 Pro"

# 安装 App
xcrun simctl install booted /path/to/app.app

# 卸载 App
xcrun simctl uninstall booted com.example.app

# 启动 App
xcrun simctl launch booted com.example.app

# 关闭 App
xcrun simctl terminate booted com.example.app

# 关闭模拟器
xcrun simctl shutdown "iPhone 15 Pro"

# 删除模拟器数据
xcrun simctl erase "iPhone 15 Pro"
```

### 4.2 自动化流程

```bash
# 完整流程示例
# 1. 启动
xcrun simctl boot "iPhone 15 Pro"

# 2. 安装
xcrun simctl install booted /path/to/app.app

# 3. 启动 App
xcrun simctl launch booted com.example.app

# 4. 运行测试
# ...

# 5. 清理
xcrun simctl terminate booted com.example.app
```

---

## 五、测试环境启动流程

### 5.1 Web 测试

```bash
# 1. 启动开发服务器（根据 test-config.json）
cd /path/to/project
npm run dev &

# 2. 等待服务就绪
sleep 5

# 3. 运行 Playwright 测试
npx playwright test tests/web/

# 4. 查看报告
npx playwright show-report
```

### 5.2 iOS 测试

```bash
# 1. 读取 test-config.json 获取 app 路径和 bundle-id

# 2. 启动模拟器
xcrun simctl boot "iPhone 15 Pro"

# 3. 安装 App
xcrun simctl install booted /path/to/app.app

# 4. 启动 Appium
appium &

# 5. 运行测试
pytest tests/ios/

# 6. 清理
xcrun simctl terminate booted com.example.app
```

---

## 六、测试文档模板

> ⚠️ **重要**：所有测试产物必须保存到项目目录！

### 6.1 测试用例模板

```
测试用例保存位置：~/.openclaw/projects/[项目名称]/tests/

## TC-XXX: [用例名称]

**优先级**: P0/P1/P2/P3
**测试类型**: UI/E2E/Visual
**所属模块**: [模块名]

【前置条件】
1. [条件1]
2. [条件2]

【测试步骤】（每步都要详细）
1. [步骤1：具体操作，包括点击位置、输入内容]
2. [步骤2：具体操作]
3. [步骤3：具体操作]

【预期结果】
- [结果1：具体描述，包括验证的元素和内容]
- [结果2：具体描述]

【测试数据】
- 数据1：[值]
- 数据2：[值]

【页面元素定位】（必须包含）
- 关键元素1：finder 方式（如 find.text、find.byKey）
- 关键元素2：finder 方式

【验证方式】
- 页面跳转验证
- 元素存在验证
- 数据正确性验证

【超时设置】
- 页面等待：3秒
- 元素查找：5秒
```

### 6.2 BUG 报告模板

```
## BUG-[序号]: [BUG 标题]

**严重程度**: Critical / High / Medium / Low
**优先级**: P0 / P1 / P2 / P3
**复现概率**: 100% / 80% / 50% / 20%

### 环境信息
- 操作系统：macOS
- iOS 版本：iOS 17.5
- 浏览器：Chromium
- App 版本：1.0.0

### 复现步骤
1. [步骤1]
2. [步骤2]
3. [步骤3]

### 预期结果
[期望的行为]

### 实际结果
[实际的行为]

### 截图/日志
[如有]

### 相关模块
- 模块：[模块名]
- 功能点：[功能点]

### 建议修复方案
[如有]
```

### 6.3 测试报告模板

> ⚠️ **重要**：测试报告必须保存到 `docs/测试报告/` 目录！

```
测试报告保存位置：~/.openclaw/projects/[项目名称]/docs/测试报告/测试报告-YYYYMMDD.md

# 测试报告 - [项目/迭代名称]

## 测试概要

| 项目 | 值 |
|------|-----|
| 测试范围 | [模块列表] |
| 测试类型 | 功能/回归/视觉 |
| 测试周期 | [日期] |
| 测试人员 | Tester Agent |

## 测试执行情况

### 用例统计

| 状态 | 数量 | 占比 |
|------|------|------|
| 通过 | X | X% |
| 失败 | X | X% |
| 重试后通过 | X | X% |

### BUG 统计

| 严重程度 | 新增 | 已修复 | 待修复 |
|----------|------|--------|--------|
| Critical | X | X | X |
| High | X | X | X |
| Medium | X | X | X |
| Low | X | X | X |

## 测试结论

### 是否通过
✅ 通过 / ❌ 不通过

### 遗留问题
[列表]
```

---

## 七、质量标准

### 7.1 测试通过标准

| 优先级 | 必须通过 | 通过率要求 |
|--------|----------|------------|
| P0 | 100% | 100% |
| P1 | 100% | ≥ 95% |
| P2 | ≥ 90% | ≥ 80% |
| P3 | ≥ 70% | - |

### 7.2 覆盖率要求

| 类型 | 目标 |
|------|------|
| Web | ≥ 80% |
| iOS | ≥ 80% |

### 7.3 BUG 关闭标准

| 严重程度 | 修复要求 | 验证要求 |
|----------|----------|----------|
| Critical | 必须修复 | 复测 3 次 |
| High | 必须修复 | 复测 2 次 |
| Medium | 应修复 | 复测 1 次 |
| Low | 建议修复 | 视情况复测 |

---

## 八、协作命令

### 8.1 与 CEO 汇报

```markdown
# 测试结果汇报格式

✅ 测试完成

📊 测试结果：
- 用例总数：[数量]
- 通过：[数量]
- 失败：[数量]
- 通过率：[百分比]

🐛 BUG 统计：
- Critical：[数量]
- High：[数量]
- Medium：[数量]
- Low：[数量]

📁 报告位置：[路径]
```

### 8.2 与 Developer 协作

- 读取 test-config.json 获取测试配置
- 发现问题及时沟通

---

> **TOOLS.md 维护规则**：
> 1. 工具更新时同步修改
> 2. 保持示例代码准确
> 3. 新工具加入时补充
