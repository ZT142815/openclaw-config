# MEMORY.md - Developer Agent 长期记忆

> **最后更新**：2026-03-27
> **更新人**：Developer Agent
> **更新原因**：补充完整配置

---

## 一、团队架构

### 1.1 团队成员

| Agent | ID | 名字 | 核心职责 |
|-------|-----|------|-----------|
| CEO | main | 周小墨 | 任务调度、协调、汇报 |
| Product | product | 周小产 | 需求分析、PRD编写 |
| Developer | developer | 周小码 | 代码开发、技术实现 |
| Tester | tester | 周小测 | 测试执行、BUG跟踪 |

### 1.2 Agent 协作关系

```
CEO ←→ Product ←→ Developer ←→ Tester
         ↓            ↓
      PRD 输出    代码开发
         ↓            ↓
      技术设计    自测验证
```

---

## 二、用户偏好

### 2.1 沟通偏好

- **回复语言**：中文
- **沟通风格**：简洁直接，不废话
- **汇报频率**：关键节点必报，不要每一步都汇报
- **决策风格**：重要决策先询问

### 2.2 代码偏好

- **代码风格**：遵循社区最佳实践
- **命名规范**：小写下划线（变量/函数）、大写开驼峰（类）
- **质量标准**：宁可慢一点，也要保证质量
- **自测要求**：flutter analyze 0 errors + SHA1 验证

---

## 三、技术栈

### 3.1 App 框架

| App 类型 | 推荐框架 | 选择理由 |
|----------|----------|----------|
| 快速原型 / MVP | Expo + React Native | 开发快、热更新 |
| 中等复杂度 App | 纯 React Native | 性能好、控制强 |
| 高性能 / 游戏类 | Flutter | 原生性能、最佳跨平台 |

### 3.2 后端技术

**默认使用 Supabase（BaaS）**

| 能力 | 用途 |
|------|------|
| PostgreSQL | 数据库存储 |
| Auth | 用户认证 |
| Realtime | 实时功能 |
| Storage | 文件存储 |
| Edge Functions | Serverless 后端逻辑 |

### 3.3 设计规范

**Flutter 项目必须遵循**：
- `DESIGN-SYSTEM.md` - 基础设计系统规范
- `FLUTTER-DESIGN-GENERAL.md` - Flutter 通用设计规范
- `components/` - Flutter 组件库（27个组件）

**色彩系统（Apple HIG）**：
- 主色：#007AFF
- 成功：#34C759
- 警告：#FF9500
- 危险：#FF3B30

**间距系统（8px 网格）**：
- xs: 4px / sm: 8px / md: 16px / lg: 24px / xl: 32px

---

## 四、Supabase 配置

### 4.1 环境变量

| 变量 | 状态 | 说明 |
|------|------|------|
| SUPABASE_ACCESS_TOKEN | ✅ 已配置 | sbp_2a2970c... (CLI 操作) |

### 4.2 Supabase 项目列表

| 项目名 | URL | 用途 | 状态 |
|--------|-----|------|------|
| FocusFlow | kxkkchhjdyoiietcisij.supabase.co | 番茄钟 App | 本地 Flutter |
| Focus Timer | vwcrxptckwmhqbccraxg.supabase.co | 待确认 | - |
| 每日一记 | nvufatrbkoguiakssdxt.supabase.co | Flutter + Supabase | ✅ 完整 |
| test-agent-app | rizuncelbtvolxpiaebm | East US | 测试项目 |

### 4.3 数据库 Migration 流程

```bash
# 1. 创建 migration 文件
mkdir -p supabase/migrations
cat > supabase/migrations/001_init.sql << 'EOF'
CREATE TABLE users (...);
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
CREATE POLICY "..." ON users FOR SELECT ...;
EOF

# 2. 链接项目
supabase link --project-ref <ref> --password <pwd>

# 3. 推送
supabase db push
```

---

## 五、项目记录

### 5.1 进行中项目

| 项目名称 | 阶段 | 开始时间 | 技术栈 |
|----------|------|----------|--------|
| （暂无） | - | - | - |

### 5.2 已完成项目

| 项目名称 | 完成时间 | 技术栈 | 代码量 |
|----------|----------|--------|--------|
| 智能运营中心 Dashboard | 2026-03-26 | React + FastAPI | ~2000行 |

---

## 六、技术积累

### 6.1 常见问题解决方案

| 问题 | 解决方案 | 日期 |
|------|----------|------|
| 无法访问 Supabase API（SSL_ERROR_SYSCALL） | 沙箱环境网络限制，需手动在浏览器操作或等待网络恢复 | 2026-03-21 |
| flutter analyze 报错 | 检查代码语法、导入路径、依赖版本 | - |
| iOS Simulator 无法启动 | xcrun simctl list devices available 检查设备 | - |

### 6.2 代码规范

使用 `skills/CODING-STANDARDS.md` 作为完整规范。

> ⚠️ **2026-03-29 更新：统一为 Flutter/Dart 社区规范**

**命名规范**：
- 变量：`userName`（camelCase 小写驼峰）
- 函数：`getUser()`（camelCase 小写驼峰）
- 类：`UserService`（PascalCase 大写开驼峰）
- 常量：`maxRetries` 或 `MAX_RETRIES` 均可
- 文件：`user_service.dart`（snake_case 下划线）

**测试要求**：
- 覆盖率 > 80%
- 边界条件测试
- 异常情况处理

### 6.3 GitHub 规范

**分支命名**：
```
feature/[功能名]
fix/[问题名]
refactor/[重构名]
```

**Commit 规范**：
```
feat: 新功能
fix: 修复 Bug
docs: 文档更新
style: 代码格式
refactor: 重构
test: 测试相关
```

---

## 七、Skills 索引

| 文件 | 作用 |
|------|------|
| skills/CODING-STANDARDS.md | 代码规范（775行） |
| skills/SUPABASE.md | Supabase 指南 |
| DESIGN-SYSTEM.md | 设计系统规范 |
| FLUTTER-DESIGN-GENERAL.md | Flutter 设计规范 |
| components/ | Flutter 组件库（27个） |

---

## 八、每周总结

### 2026年第12周（03.10-03.16）
- （暂无记录）

### 2026年第13周（03.17-03.23）

**本周完成**：
1. 完成 OpenClaw Control UI 项目初始化
2. 修复记忆系统问题

**关键决策**：
- 统一 Flutter 社区规范

**下周计划**：
1. 完善 Tester Agent 规范
2. 继续开发新项目

### 2026年第14周（03.24-03.30）

**本周完成**：
1. 完成记忆系统修复
2. 统一团队命名规范

**关键决策**：
- 命名规范统一为 camelCase

**下周计划**：
1. 完善 Tester Agent 规范

---

## 九、待处理事项

- [ ] 完善项目记录
- [ ] 补充技术问题解决方案
- [ ] 积累部署经验

---

> **维护规则**：
> 1. 每完成一个项目，更新"项目记录"
> 2. 遇到技术问题并解决后，记录到"技术积累"
> 3. 每周五下午整理本周工作
> 4. MEMORY.md 保持精简，不要变成日记
