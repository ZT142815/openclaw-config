# TOOLS.md - Tester Agent 工具配置

## 第一层：工具层

> **每次启动时读取此文件，了解可用工具**

---

## 一、测试工具

### 1.1 接口测试工具

| 工具 | 命令 | 用途 |
|------|------|------|
| curl | `curl -X POST ...` | 快速 API 测试 |
| Python requests | `python3 -c "import requests"` | 复杂场景测试 |

### 1.2 页面测试工具

| 工具 | 命令 | 用途 |
|------|------|------|
| Appium | `appium &` | 启动 Appium Server |
| Flutter test | `flutter test` | Flutter 单元测试 |
| integration_test | `flutter test integration_test/` | Flutter 集成测试 |

---

## 二、文件操作工具

### 2.1 读取文件

```bash
# 读取项目文档
openclaw read --file ~/.openclaw/projects/<项目名>/docs/PRD.md
openclaw read --file ~/.openclaw/projects/<项目名>/docs/接口文档.md

# 读取模板
openclaw read --file ~/.openclaw/workspace-tester/skills/TEST-PLAN-TEMPLATE.md
```

### 2.2 写入文件

```bash
# 写入测试用例
openclaw write --file ~/.openclaw/projects/<项目名>/docs/测试用例.md --content "..."

# 写入测试报告
openclaw write --file ~/.openclaw/projects/<项目名>/docs/测试报告.md --content "..."
```

---

## 三、截图管理

### 3.1 截图保存位置

```
~/.openclaw/projects/<项目名>/docs/
├── 截图/
│   ├── TC-API-001-连接成功.png
│   ├── TC-UI-001-登录页.png
│   └── ...
└── BUG截图/
    ├── BUG-001-01.png
    └── ...
```

### 3.2 截图命名规范

```
接口测试：TC-API-XXX-描述.png
页面测试：TC-UI-XXX-描述.png
BUG 截图：BUG-XXX-序号.png
```

---

## 四、SHA1 验证

### 4.1 验证命令

```bash
cd ~/.openclaw/projects/<项目名>/docs/截图/
shasum *.png
```

### 4.2 验证规则

- 不同页面的截图 SHA1 必须不同
- 相同 = 测试造假 = 测试失败

---

## 五、测试数据管理

### 5.1 测试账号生成

Tester 自动生成随机账号：
```
邮箱：test_YYYYMMDD_HHMMSS@example.com
密码：Test123456
```

### 5.2 测试数据清理

测试完成后清理测试数据：
```bash
DELETE FROM [表名] WHERE email LIKE 'test_%@example.com';
```

---

## 六、使用规范

### 6.1 安全原则

- ⛔ 不要删除生产环境数据
- ⛔ 不要修改测试代码
- ⛔ 不要跳过测试用例

### 6.2 效率原则

- 📁 优先使用标准化模板
- 🔄 重复任务考虑自动化
- 📊 定期清理过期截图

---

> **工具层维护规则**：
> 1. 每次新增工具或能力，更新此文件
> 2. 定期清理不再使用的工具配置
> 3. 保持命令示例的准确性
