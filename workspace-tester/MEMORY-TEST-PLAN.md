# 通用自动化测试流程 - Tester Agent

> ⚠️ **已停用**（2026-03-26）
> 自动化测试流程已暂停，此文档保留作为历史参考。

> **适用项目**：所有 App（Flutter / iOS / Android / Web）
> **版本**：2.0
> **更新日期**：2026-03-25
> **重大更新**：Appium 已废弃，改用 Maestro

---

## 一、三层测试架构

```
┌─────────────────────────────────────────────────────────┐
│           第一层：接口测试（API）                        │
│  执行者：Developer Agent                                │
│  工具：curl                                           │
│  目标：验证后端 API 正常                              │
│  时机：代码开发完成后                                  │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│           第二层：Flutter 集成测试                     │
│  执行者：Developer Agent                                │
│  工具：flutter test integration_test/                  │
│  目标：验证 App 内部逻辑、Widget                      │
│  时机：接口测试通过后                                  │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│           第三层：Maestro E2E 测试                    │
│  执行者：Tester Agent                                   │
│  工具：Maestro + YAML                                 │
│  目标：验证真实 UI 流程                               │
│  时机：Flutter 测试通过后                              │
└─────────────────────────────────────────────────────────┘
```

---

## 二、准备工作

### 2.1 安装 Maestro

```bash
# 安装 Maestro
curl -fsSL "https://get.maestro.mobile.dev" | /bin/bash

# 验证安装
maestro --version

# 需要 Java 17+
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
```

### 2.2 项目要求

**开发者必须为测试添加以下属性**：

```dart
// ✅ 为图标添加 semanticLabel
FloatingActionButton(
  onPressed: () => context.push('/add'),
  child: Icon(Icons.add, semanticLabel: 'add_item'),
)

// ✅ 为输入框添加 Semantics wrapper
Semantics(
  label: 'email_field',
  child: TextFormField(...),
)

// ✅ 为按钮添加 Semantics
Semantics(
  label: 'login_button',
  child: ElevatedButton(...),
)

// ❌ 错误：Maestro 找不到 ValueKey
ValueKey('xxx')  // 不行！
```

---

## 三、第一层：接口测试（Developer Agent）

### 3.1 测试脚本模板

**文件位置**：`tests/api_test.py`

```python
#!/usr/bin/env python3
"""
{项目名称} - 接口测试
使用 curl 代替 Python requests（避免 SSL 问题）
"""

import subprocess
import json
import time
from typing import List, Tuple, Dict

class APITester:
    def __init__(self, base_url: str, api_key: str = ""):
        self.base_url = base_url
        self.api_key = api_key
        self.access_token = None
        self.results: List[Tuple[str, bool, str]] = []
    
    def curl(self, method: str, path: str, data: str = None, auth: bool = False) -> Dict:
        """使用 curl 执行请求"""
        headers = [
            f"apikey: {self.api_key}",
            "Content-Type: application/json"
        ]
        if auth and self.access_token:
            headers.append(f"Authorization: Bearer {self.access_token}")
        
        cmd = ["curl", "-s", "-X", method.upper()]
        for h in headers:
            cmd.extend(["-H", h])
        
        if data:
            cmd.extend(["-d", json.dumps(data)])
        
        cmd.append(f"{self.base_url}{path}")
        
        result = subprocess.run(cmd, capture_output=True, text=True)
        try:
            return json.loads(result.stdout) if result.stdout else {}
        except:
            return {"raw": result.stdout}
    
    def log_result(self, name: str, passed: bool, note: str = ""):
        """记录测试结果"""
        self.results.append((name, passed, note))
        status = "✅ PASS" if passed else "❌ FAIL"
        print(f"   {status}: {note}")
    
    def test_rest_api(self) -> bool:
        """TC-API-001: Rest API 连接测试"""
        print("\n[TC-API-001] Rest API 连接...")
        try:
            result = self.curl("GET", "/rest/v1/")
            # 返回 400 表示连接成功（需要表名）
            if "message" in result or result == {}:
                self.log_result("Rest API", True, "连接正常")
                return True
            self.log_result("Rest API", False, str(result))
            return False
        except Exception as e:
            self.log_result("Rest API", False, str(e))
            return False
    
    def test_query_items(self) -> bool:
        """TC-API-002: 查询 items 表"""
        print("\n[TC-API-002] 查询 items 表...")
        try:
            result = self.curl("GET", "/rest/v1/items?select=*")
            if isinstance(result, list):
                self.log_result("查询 items", True, f"返回 {len(result)} 条记录")
                return True
            self.log_result("查询 items", False, str(result))
            return False
        except Exception as e:
            self.log_result("查询 items", False, str(e))
            return False
    
    def test_signup(self, email: str = None, password: str = "123123") -> bool:
        """TC-API-003: 用户注册"""
        print("\n[TC-API-003] 用户注册...")
        if not email:
            email = f"test_{int(time.time())}@test.com"
        
        try:
            result = self.curl("POST", "/auth/v1/signup", {"email": email, "password": password})
            if "id" in result or "access_token" in result:
                self.log_result("用户注册", True, email)
                return True
            # 429 表示频率限制，也算成功
            if result.get("code") == "over_email_send_rate_limit":
                self.log_result("用户注册", True, "频率限制（正常）")
                return True
            self.log_result("用户注册", False, str(result)[:100])
            return False
        except Exception as e:
            self.log_result("用户注册", False, str(e))
            return False
    
    def test_login(self, email: str, password: str = "123123") -> bool:
        """TC-API-004: 用户登录"""
        print("\n[TC-API-004] 用户登录...")
        try:
            result = self.curl("POST", "/auth/v1/token?grant_type=password", {
                "email": email,
                "password": password
            })
            if "access_token" in result:
                self.access_token = result["access_token"]
                self.log_result("用户登录", True, "获取 token 成功")
                return True
            self.log_result("用户登录", False, str(result)[:100])
            return False
        except Exception as e:
            self.log_result("用户登录", False, str(e))
            return False
    
    def generate_report(self) -> Dict:
        """生成测试报告"""
        passed = sum(1 for _, r, _ in self.results if r)
        total = len(self.results)
        
        return {
            "total": total,
            "passed": passed,
            "failed": total - passed,
            "pass_rate": f"{(passed/total*100):.1f}%" if total > 0 else "0%",
            "results": self.results
        }


def run_api_tests(base_url: str, api_key: str, email: str = None, password: str = "123123") -> bool:
    """运行接口测试"""
    print("=" * 60)
    print("🚀 接口测试")
    print("=" * 60)
    
    tester = APITester(base_url, api_key)
    
    # 1. Rest API 连接测试
    tester.test_rest_api()
    
    # 2. 查询 items 表
    tester.test_query_items()
    
    # 3. 注册
    tester.test_signup(email)
    
    # 4. 登录
    tester.test_login(email or f"test_{int(time.time())}@test.com", password)
    
    # 生成报告
    report = tester.generate_report()
    
    print("\n" + "=" * 60)
    print("📊 接口测试报告")
    print("=" * 60)
    print(f"   总计: {report['passed']}/{report['total']} 通过")
    print(f"   通过率: {report['pass_rate']}")
    
    return report['passed'] == report['total']


if __name__ == "__main__":
    import sys
    base_url = sys.argv[1] if len(sys.argv) > 1 else "https://xxx.supabase.co"
    api_key = sys.argv[2] if len(sys.argv) > 2 else ""
    
    success = run_api_tests(base_url, api_key)
    exit(0 if success else 1)
```

### 3.2 运行方式

```bash
# 基本运行
python3 tests/api_test.py <BASE_URL> <API_KEY>

# 示例
python3 tests/api_test.py https://vevwqlocoafodgqfocqd.supabase.co eyJxxx...
```

### 3.3 常见问题

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| SSL 错误 | Python requests 不支持某些 SSL 版本 | 用 curl 代替 |
| 401/403 | API Key 错误 | 检查 supabaseAnonKey |
| 404 | 路径错误 | 检查 REST API 路径 |

---

## 四、第二层：Flutter 集成测试（Developer Agent）

### 4.1 测试脚本模板

**文件位置**：`integration_test/app_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:{package_name}/app.dart';

// Supabase 配置
const supabaseUrl = 'https://xxx.supabase.co';
const supabaseAnonKey = 'eyJxxx...';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  // 初始化 Supabase（必须！）
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  group('功能模块测试', () {
    testWidgets('TC-001: 测试用例名称', (WidgetTester tester) async {
      // 启动 App
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // 测试步骤...
      print('TC-001: 测试完成');
    });
  });
}
```

### 4.2 运行方式

```bash
cd <项目目录>
flutter test integration_test/app_test.dart
```

### 4.3 常见问题

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| No ProviderScope | 未包裹 ProviderScope | 添加 ProviderScope wrapper |
| Bad state: No ProviderScope | Riverpod 需要 ProviderScope | 在 pumpWidget 中包裹 |

---

## 五、第三层：Maestro E2E 测试（Tester Agent）

### 5.1 测试文件结构

```
项目目录/
├── .maestro/
│   ├── LoginFlow.yaml       # 登录流程
│   ├── AddItemFlow.yaml    # 添加物品流程
│   └── CommonFlow.yaml     # 公共流程（如处理通知权限）
└── docs/
    └── 测试截图/            # ⭐ 截图必须放在项目目录内
```

### 5.2 测试模板

**文件位置**：`.maestro/LoginFlow.yaml`

```yaml
appId: com.minimalist.minimalistButler
name: 登录测试
---
# 1. 清空状态并启动
- clearState
- stopApp
- launchApp
- waitForAnimationToEnd

# 2. 处理通知权限弹窗（如果出现）
- tapOn:
    text: "不允许"
    optional: true

# 3. 登录页截图
- takeScreenshot: "docs/测试截图/TC001-login.png"

# 4. 输入邮箱（使用 semanticLabel）
- tapOn:
    id: "email_field"
- inputText: "15651758280@163.com"

# 5. 输入密码
- tapOn:
    id: "password_field"
- inputText: "123123"

# 6. 隐藏键盘
- hideKeyboard

# 7. 登录页截图（填写后）
- takeScreenshot: "docs/测试截图/TC002-form-filled.png"

# 8. 点击登录按钮
- tapOn:
    text: "登录"

# 9. 等待页面跳转
- waitForAnimationToEnd
- waitForAnimationToEnd
- takeScreenshot: "docs/测试截图/TC003-home.png"

# 10. 验证进入首页
- extendedWaitUntil:
    visible: "首页"
    timeout: 15000
```

### 5.3 常用命令

| 命令 | 说明 | 示例 |
|------|------|------|
| `launchApp` | 启动 App | `launchApp` |
| `stopApp` | 停止 App | `stopApp` |
| `clearState` | 清空 App 状态 | `clearState` |
| `tapOn` | 点击元素 | `tapOn: "登录"` 或 `tapOn: id: "xxx"` |
| `inputText` | 输入文本 | `inputText: "test@example.com"` |
| `hideKeyboard` | 隐藏键盘 | `hideKeyboard` |
| `takeScreenshot` | 截图 | `takeScreenshot: "docs/测试截图/test.png"` |
| `waitForAnimationToEnd` | 等待动画结束 | `waitForAnimationToEnd` |
| `extendedWaitUntil` | 等待元素出现 | `extendedWaitUntil: visible: "xxx" timeout: 5000` |
| `assertVisible` | 断言元素可见 | `assertVisible: "首页"` |
| `back` | 返回 | `back` |

### 5.4 运行方式

```bash
# 设置 Java
export JAVA_HOME=$(/usr/libexec/java_home -v 17)

# 运行单个测试
maestro test .maestro/LoginFlow.yaml

# 运行所有测试
maestro test .maestro/
```

### 5.5 常见问题

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| Element not found | 元素选择器错误 | 用 `semanticLabel` 而不是 `ValueKey` |
| 页面没跳转 | 点击没触发导航 | 增加 `waitForAnimationToEnd` 次数 |
| 截图相同 | 页面没变化 | 确认页面已跳转，增加等待时间 |
| 找不到按钮 | FAB 在底部 | 用坐标 `tapOn: point: "370,680"` |

### 5.6 semanticLabel 使用规范

**Flutter 端必须添加 semanticLabel**：

```dart
// ✅ 正确：Icon 添加 semanticLabel
Icon(Icons.add, semanticLabel: 'add_item')

// ✅ 正确：Semantics wrapper
Semantics(
  label: 'email_field',
  child: TextFormField(...),
)

// ✅ 正确：Semantics wrapper
Semantics(
  label: 'login_button',
  child: ElevatedButton(...),
)

// ❌ 错误：ValueKey - Maestro 找不到
ValueKey('xxx')

// ❌ 错误：identifier - Maestro 找不到
Semantics(identifier: 'xxx', ...)
```

**Maestro 端定位方式**：

```yaml
# 方式1：直接用文本（如果元素有可见文本）
- tapOn: "登录"

# 方式2：用 semanticLabel 的值
- tapOn: "add_item"  # 对应 semanticLabel: 'add_item'

# 方式3：用 id（如果用了 Semantics label）
- tapOn:
    id: "email_field"

# 方式4：坐标（最后的选择）
- tapOn:
    point: "370,680"
```

---

## 六、SHA1 验证（必须执行）

### 6.1 验证命令

```bash
cd <截图目录>
shasum *.png
```

### 6.2 验证规则

| 情况 | 结论 |
|------|------|
| 所有 SHA1 不同 | ✅ 通过 |
| 部分 SHA1 相同 | ⚠️ 检查是否页面真的不同 |
| 所有 SHA1 相同 | ❌ 失败，页面没有变化 |

### 6.3 验证示例

```bash
$ shasum docs/测试截图/*.png
a236a997... TC001-login.png
02d5c506... TC002-form-filled.png
c13b5681... TC003-home.png
fecdd0ff... TC004-add-item.png
fecdd0ff... TC005-item-form.png  # ⚠️ 与 TC004 相同

# TC004 和 TC005 相同？可能是：
# 1. 页面真的没变化
# 2. 截图时机太早
# 3. 需要增加等待时间
```

---

## 七、完整测试流程

### 7.1 执行顺序

```
1. 接口测试（Developer）
   ↓ 通过
2. Flutter 集成测试（Developer）
   ↓ 通过
3. Maestro E2E 测试（Tester）
```

### 7.2 执行脚本

**文件位置**：`tests/run_tests.sh`

```bash
#!/bin/bash
set -e

PROJECT_DIR=$1
BASE_URL=$2
API_KEY=$3

echo "========================================"
echo "🚀 开始测试流程"
echo "========================================"

# 1. 接口测试
echo ""
echo "📋 第一层：接口测试"
echo "========================================"
python3 tests/api_test.py $BASE_URL $API_KEY

# 2. Flutter 集成测试
echo ""
echo "📋 第二层：Flutter 集成测试"
echo "========================================"
cd $PROJECT_DIR
flutter test integration_test/app_test.dart

# 3. Maestro E2E 测试
echo ""
echo "📋 第三层：Maestro E2E 测试"
echo "========================================"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
maestro test .maestro/

# 4. SHA1 验证
echo ""
echo "📋 第四层：SHA1 验证"
echo "========================================"
cd screenshots
shasum *.png

echo ""
echo "========================================"
echo "✅ 测试完成"
echo "========================================"
```

---

## 八、目录结构

```
项目目录/
├── tests/
│   ├── api_test.py           # 接口测试（curl）
│   └── run_tests.sh         # 完整测试脚本
├── integration_test/
│   └── app_test.dart        # Flutter 集成测试
├── .maestro/
│   ├── LoginFlow.yaml       # 登录流程
│   └── AddItemFlow.yaml     # 添加物品流程
└── docs/
    └── 测试截图/              # ⭐ 测试截图必须放在项目目录内
```

---

## 九、测试报告模板

**文件位置**：`docs/测试报告/测试报告-YYYYMMDD.md`

```markdown
# 测试报告 - YYYY-MM-DD

## 测试概述

| 项目 | 值 |
|------|-----|
| 测试日期 | YYYY-MM-DD |
| 测试执行者 | Tester Agent |
| 测试结果 | 通过/失败 |

## 测试结果

### 第一层：接口测试

| 用例 | 结果 | 备注 |
|------|------|------|
| TC-API-001 | ✅ 通过 | Rest API 连接正常 |
| TC-API-002 | ✅ 通过 | items 表查询成功 |
| TC-API-003 | ✅ 通过 | 用户注册成功 |
| TC-API-004 | ✅ 通过 | 用户登录成功 |

**通过率：4/4 (100%)**

### 第二层：Flutter 集成测试

| 用例 | 结果 | 备注 |
|------|------|------|
| TC-Widget-001 | ✅ 通过 | App 启动正常 |
| ... | ... | ... |

**通过率：X/X (XX%)**

### 第三层：Maestro E2E 测试

| 用例 | 结果 | 截图 | SHA1 |
|------|------|------|------|
| TC-E2E-001 | ✅ 通过 | TC001-login.png | abc123... |
| ... | ... | ... | ... |

**通过率：X/X (XX%)**

## SHA1 验证

```
$ shasum docs/测试截图/*.png
abc123... TC001-login.png
def456... TC002-form-filled.png
...
```

**验证结论：✅ 通过（所有截图 SHA1 不同）**

## 问题记录

（如有）

## 测试结论

✅ **测试通过** / ❌ **测试失败**

---
```

---

## 十、踩坑记录（2026-03-25）

| 坑 | 问题 | 解决方案 |
|----|------|----------|
| Python requests SSL | SSL 握手失败 | 用 curl 代替 |
| integration_test ProviderScope | Riverpod 需要 ProviderScope | 在 pumpWidget 中包裹 |
| Maestro ValueKey | 找不到 ValueKey | 用 semanticLabel |
| Maestro identifier | identifier 不工作 | 用 label |
| FAB 找不到 | FAB 在 accessibilityText 中 | 用 Icon(semanticLabel: 'xxx') |
| 通知权限弹窗 | 阻止页面显示 | tapOn "不允许" optional: true |
| 截图 SHA1 相同 | 页面没变化 | 增加 waitForAnimationToEnd |

---

## 十一、适用项目类型

| 项目类型 | 接口测试 | Flutter 测试 | E2E 测试 |
|----------|---------|--------------|----------|
| Flutter iOS | ✅ curl | ✅ flutter test | ✅ Maestro |
| Flutter Android | ✅ curl | ✅ flutter test | ✅ Maestro |
| Flutter Web | ✅ curl | ✅ flutter test | ⚠️ Playwright |
| React Web | ✅ curl | ❌ | ⚠️ Playwright |
| iOS 原生 | ✅ curl | ❌ | ⚠️ Appium |
| Android 原生 | ✅ curl | ❌ | ⚠️ Appium |

---

## 十二、测试脚本模板（完整版）

### 12.1 接口测试模板

**文件**：`tests/api_test.py`

```python
#!/usr/bin/env python3
"""
{项目名} - 接口测试
根据 docs/接口文档.md 生成
"""

import subprocess
import json
import time
from typing import List, Tuple, Dict

class APITester:
    def __init__(self, base_url: str, api_key: str = ""):
        self.base_url = base_url
        self.api_key = api_key
        self.access_token = None
        self.results: List[Tuple[str, bool, str]] = []
    
    def curl(self, method: str, path: str, data: dict = None, auth: bool = False) -> dict:
        """使用 curl 执行请求"""
        headers = [f"apikey: {self.api_key}", "Content-Type: application/json"]
        if auth and self.access_token:
            headers.append(f"Authorization: Bearer {self.access_token}")
        
        cmd = ["curl", "-s", "-X", method.upper()]
        for h in headers:
            cmd.extend(["-H", h])
        if data:
            cmd.extend(["-d", json.dumps(data)])
        cmd.append(f"{self.base_url}{path}")
        
        result = subprocess.run(cmd, capture_output=True, text=True)
        try:
            return json.loads(result.stdout) if result.stdout else {}
        except:
            return {"raw": result.stdout}
    
    def test_api(self, name: str, method: str, path: str, data: dict = None, auth: bool = False) -> bool:
        """测试单个 API"""
        print(f"\n[{name}]...")
        try:
            result = self.curl(method, path, data, auth)
            # 根据实际情况判断成功
            self.results.append((name, True, str(result)[:100]))
            return True
        except Exception as e:
            self.results.append((name, False, str(e)))
            return False

# 根据 docs/接口文档.md 中的 API 列表生成测试用例
def run_tests(base_url: str, api_key: str) -> bool:
    tester = APITester(base_url, api_key)
    
    # TODO: 根据 docs/接口文档.md 填充测试用例
    # tester.test_api("TC-API-001: xxx", "GET", "/rest/v1/xxx")
    
    # 示例
    tester.test_api("TC-API-001: Rest API", "GET", "/rest/v1/")
    tester.test_api("TC-API-002: 查询", "GET", "/rest/v1/items?select=*")
    
    passed = sum(1 for _, r, _ in tester.results if r)
    print(f"\n通过率: {passed}/{len(tester.results)}")
    return passed == len(tester.results)

if __name__ == "__main__":
    import sys
    base_url = sys.argv[1] if len(sys.argv) > 1 else ""
    api_key = sys.argv[2] if len(sys.argv) > 2 else ""
    success = run_tests(base_url, api_key)
    exit(0 if success else 1)
```

### 12.2 Flutter 集成测试模板

**文件**：`integration_test/app_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:{package_name}/app.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  // 初始化 Supabase
  await Supabase.initialize(
    url: 'https://xxx.supabase.co',
    anonKey: 'eyJxxx...',
  );

  group('{功能模块}', () {
    // TODO: 根据 docs/PRD.md 验收标准生成测试用例
    testWidgets('TC-001: {测试用例名称}', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: App()),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // TODO: 根据验收标准编写测试步骤
      
      print('TC-001: 测试完成');
    });
  });
}
```

### 12.3 Maestro E2E 测试模板

**目录**：`code/.maestro/`

#### Common.yaml
```yaml
# 公共流程
notification_permission:
  - tapOn:
      text: "不允许"
      optional: true

clear_and_launch:
  - clearState
  - stopApp
  - launchApp
  - waitForAnimationToEnd
```

#### 01-Login.yaml
```yaml
appId: com.example.app
name: TC-E2E-001 登录测试
---
# 1. 清空并启动
- clearState
- stopApp
- launchApp
- waitForAnimationToEnd

# 2. 处理通知权限
- tapOn:
    text: "不允许"
    optional: true

# 3. 登录
- tapOn:
    id: "email_field"
- inputText: "test@example.com"
- tapOn:
    id: "password_field"
- inputText: "123456"
- hideKeyboard
- tapOn:
    text: "登录"

# 4. 验证
- extendedWaitUntil:
    visible: "{首页标识}"
    timeout: 15000
- takeScreenshot: "docs/测试截图/TC001-login-success.png"
```

#### 02-{Feature}.yaml
```yaml
appId: com.example.app
name: TC-E2E-002 {功能名}测试
---
# TODO: 根据 docs/PRD.md 功能列表生成

# 1. 登录（如需登录）
- runFlow:
    file: .maestro/01-Login.yaml

# 2. 测试步骤
# TODO: 根据功能编写

# 3. 截图验证
- takeScreenshot: "docs/测试截图/TC002-{feature}.png"
```

---

## 十三、生成规则

### 谁来生成？

| 测试类型 | 生成者 | 依据 |
|----------|--------|------|
| 接口测试 | **Developer** | `docs/接口文档.md` |
| Flutter 集成测试 | **Developer** | `docs/PRD.md` |
| Maestro E2E | **Developer** | `docs/PRD.md` |
| 测试用例文档 | **Developer** | `docs/PRD.md` |

### 何时生成？

```
开发流程第 12-15 步：
12. 生成接口测试脚本（tests/api_test.py）
13. 生成 Flutter 集成测试脚本（integration_test/app_test.dart）
14. 生成 Maestro E2E 测试脚本（code/.maestro/*.yaml）
15. 生成测试用例文档（docs/测试用例/测试用例-YYYYMMDD.md）
```

### Tester 职责

Tester 只负责：
- 读取 Developer 生成的测试用例文档
- 执行 E2E 测试（maestro test）
- SHA1 截图验证
- 生成测试报告

### 目录位置

```
项目目录/
├── tests/
│   └── api_test.py              # 接口测试（Developer 生成）
├── integration_test/
│   └── app_test.dart           # Flutter 测试（Developer 生成）
├── code/
│   └── .maestro/               # E2E 测试（Developer 生成）
│       ├── Common.yaml
│       ├── 01-Login.yaml
│       ├── 02-{Feature}.yaml
│       └── ...
└── docs/
    └── 截图/                   # 测试截图
```
