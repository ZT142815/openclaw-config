# 团队规范索引

> **版本**: v1.0
> **更新日期**: 2026-03-29
> **维护者**: CEO Agent (周小墨)

---

## 一、核心规范

| 规范 | 位置 | 说明 |
|------|------|------|
| **流程规范** | `~/.openclaw/templates/流程文档.md` | 完整开发流程 |
| **开发文档模板** | `~/.openclaw/templates/开发文档.md` | 技术设计文档 |
| **接口文档模板** | `~/.openclaw/templates/接口文档.md` | API 接口文档 |
| **测试用例模板** | `~/.openclaw/templates/测试用例.md` | 测试用例 |
| **测试报告模板** | `~/.openclaw/templates/测试报告.md` | 测试报告 |
| **BUG报告模板** | `~/.openclaw/templates/BUG报告.md` | BUG 报告 |
| **项目模板** | `~/.openclaw/templates/项目模板.md` | 项目初始化 |
| **PRD模板** | `~/.openclaw/templates/PRD.md` ✅ | 产品需求文档 |

---

## 二、Agent 规范

### CEO Agent (周小墨)

| 文件 | 说明 |
|------|------|
| `workspace/SOUL.md` | 启动流程、核心能力 |
| `workspace/IDENTITY.md` | 身份定义 |
| `workspace/MEMORY.md` | 长期记忆、团队配置 |
| `workspace/AGENTS.md` | 调度命令、团队管理 |
| `workspace/TOOLS.md` | 工具配置 |
| `workspace/skills/PROJECT-COORDINATION.md` | 项目协调指南 |

### Product Agent (周小产)

| 文件 | 说明 |
|------|------|
| `workspace-product/SOUL.md` | 启动流程 |
| `workspace-product/IDENTITY.md` | 身份定义 |
| `workspace-product/MEMORY.md` | 长期记忆 |
| `workspace-product/AGENTS.md` | 工作规范 |
| `workspace-product/skills/PRD-TEMPLATE.md` | PRD 模板 |
| `workspace-product/skills/REQUIREMENT-ANALYSIS.md` | 需求分析方法 |

### Developer Agent (周小码)

| 文件 | 说明 |
|------|------|
| `workspace-developer/SOUL.md` | 启动流程 |
| `workspace-developer/IDENTITY.md` | 身份定义 |
| `workspace-developer/MEMORY.md` | 长期记忆、技术栈 |
| `workspace-developer/AGENTS.md` | 开发规范、组件库要求 |
| `workspace-developer/RULES.md` | 代码规范 |
| `workspace-developer/skills/CODING-STANDARDS.md` | 完整代码规范 |
| `workspace-developer/skills/SUPABASE.md` | Supabase 指南 |
| `workspace-developer/DESIGN-SYSTEM.md` | 设计系统 |
| `workspace-developer/FLUTTER-DESIGN-GENERAL.md` | Flutter 设计规范 |
| `workspace-developer/components/` | Flutter 组件库（27个） |

### Tester Agent (周小测)

| 文件 | 说明 |
|------|------|
| `workspace-tester/SOUL.md` | 启动流程 |
| `workspace-tester/IDENTITY.md` | 身份定义 |
| `workspace-tester/MEMORY.md` | 长期记忆 |
| `workspace-tester/AGENTS.md` | 测试规范 |
| `workspace-tester/TOOLS.md` | 工具配置 |
| `workspace-tester/skills/TEST-PLAN-TEMPLATE.md` | 测试计划模板 |
| `workspace-tester/skills/TEST-EXECUTION-GUIDE.md` | 测试执行指南 |
| `workspace-tester/skills/BUG-REPORT-TEMPLATE.md` | BUG 报告模板 |

---

## 三、命名规范（⚠️ 2026-03-29 统一）

> 统一为 Flutter/Dart 社区标准

| 类型 | 规范 | 示例 |
|------|------|------|
| 变量 | camelCase | `userName`, `orderList` |
| 函数 | camelCase | `getUser()`, `fetchOrder()` |
| 类 | PascalCase | `UserService`, `OrderController` |
| 常量 | camelCase 或 SCREAMING_SNAKE | `maxRetries` 或 `MAX_RETRIES` |
| 文件 | snake_case | `user_service.dart` |
| 资源 | snake_case | `app_colors.dart` |

---

## 四、更新频率

| 内容 | 更新频率 | 说明 |
|------|----------|------|
| MEMORY.md | 每周五 | 更新本周总结 |
| 每周总结 | 每周日 | 汇总本周工作 |
| 规范版本 | 按需 | 变更时更新版本号 |
| 规范审查 | 每月末 | 检查规范完整性 |

---

## 五、变更记录

| 日期 | 版本 | 变更内容 | 作者 |
|------|------|----------|------|
| 2026-03-29 | v1.0 | 初始版本，修复8个规范问题 | 周小墨 |

---

## 六、常见问题

### Q1: 规范冲突怎么办？
A: 以本索引文档为准，或联系 CEO Agent 更新。

### Q2: 找不到模板文件？
A: 检查 `~/.openclaw/templates/` 目录。

### Q3: 需要新增规范？
A: 联系 CEO Agent 创建，并更新本索引。

### Q4: 组件库使用有疑问？
A: 参考 `workspace-developer/AGENTS.md` 中的组件库规范。
