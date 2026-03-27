

# MEMORY.md - CEO Agent 长期记忆

> **最后更新**：2026-03-25
> **更新人**：CEO Agent
> **更新原因**：流程规范优化（问题修复：自测规范、测试规范、阶段确认、Supabase 配置、BUG修复流程）

---

## 一、团队架构

### 1.1 团队成员

| Agent | ID | 名字 | 工作区路径 | 核心职责 |
|-------|-----|------|-----------|----------|
| CEO | main | 周小墨 | workspace/ | 任务调度、协调、汇报 |
| Product | product | 周小产 | workspace-product/ | 需求分析、PRD编写 |
| Developer | developer | 周小码 | workspace-developer/ | 代码开发、技术实现 |
| Tester | tester | 周小测 | workspace-tester/ | 测试执行、BUG跟踪 |

### 1.2 Agent 能力矩阵

| 能力 | CEO | Product | Developer | Tester |
|------|-----|---------|-----------|--------|
| 任务调度 | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ | ⭐⭐ |
| 需求分析 | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| 代码开发 | ⭐ | ⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| 测试验证 | ⭐⭐ | ⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ |

---

## 二、项目记录

### 2.1 正在进行的项目

| 项目名称 | 阶段 | 负责人 | 进度 | 开始日期 | 备注 |
|----------|------|--------|------|----------|------|
| （暂无） | - | - | - | - | - |

### 2.2 已完成项目

| 项目名称 | 完成日期 | 交付物 | 质量评分 |
|----------|----------|--------|----------|
| （暂无） | - | - | - |

---

## 三、用户偏好

### 3.1 沟通偏好

- **回复语言**：中文
- **沟通风格**：简洁直接，不废话
- **汇报频率**：关键节点必报，不要每一步都汇报
- **决策风格**：重要决策先询问，常规决策可自行决定

### 3.2 工作偏好

- **任务格式**：结构化，列出 1、2、3
- **文件格式**：Markdown
- **代码规范**：遵循社区最佳实践
- **质量标准**：宁可慢一点，也要保证质量

### 3.3 常用命令

- "做一个XXX" → 完整开发流程
- "需求分析" → 仅 Product Agent
- "开发代码" → 仅 Developer Agent
- "测试" → 仅 Tester Agent
- "BUG" → BUG 修复流程

---

## 四、关键决策记录

### 4.1 技术选型

| 决策 | 内容 | 日期 | 原因 |
|------|------|------|------|
| 后端平台 | Supabase | 2026-03-20 | 低成本、高效率，无需自建服务器 |

### 4.2 第三方服务配置

| 服务 | 配置状态 | 说明 |
|------|----------|------|
| **Supabase** | ✅ 已配置 Token | 可创建项目、管理数据库、部署边缘函数 |
| Supabase URL | ✅ 已配置 | vwcrxptckwmhqbccraxg |
| Supabase ANON_KEY | ⚠️ 待配置 | 需要用户提供 |

### 4.3 Supabase 能力说明

| 能力 | 状态 | 说明 |
|------|------|------|
| 创建项目 | ✅ | 可用 |
| 管理数据库 | ✅ | 可通过 migration 管理 |
| 部署 Edge Functions | ✅ | CLI 可部署 |
| 执行 SQL | ✅ | 通过 migration 推送 |
| Storage | ✅ | REST API 可用 |

### 4.4 工作流程

| 决策 | 内容 | 日期 | 原因 |
|------|------|------|------|
| 开发流程 | PRD → 开发 → 测试 → 交付 | 2026-03-19 | 标准流程 |

### 4.3 飞书通知配置

**配置文件**：~/.openclaw/config/feishu-notify.json
**通知脚本**：~/.openclaw/scripts/feishu-notify.sh

#### 通知节点清单（每次开发必须发送）

| 阶段 | 节点 | 通知内容 |
|------|------|----------|
| **需求** | 开始需求讨论 | 📋 开始分析需求，请确认需求方向 |
| **需求** | 需求确认 | 📋 需求已确认，待 Product 输出 PRD |
| **PRD** | 开始编写 | 📋 Product Agent 正在编写 PRD... |
| **PRD** | PRD 完成 | ✅ PRD 编写完成，待确认 |
| **设计** | 开始设计 | 💻 Developer 正在进行技术设计... |
| **设计** | 设计完成 | ✅ 技术设计完成，待确认 |
| **后端** | 开始创建数据库 | 🗄️ 正在创建 Supabase 数据库... |
| **后端** | 数据库完成 | ✅ 数据库创建完成，接口文档已更新 |
| **开发** | 开始开发 | 🚀 开始代码开发，请等待... |
| **开发** | 开发问题 | ⚠️ 开发遇到问题：[问题描述] |
| **开发** | 开发完成 | ✅ 代码开发完成，待自测 |
| **自测** | 开始自测 | 🔧 Developer 正在进行自测... |
| **自测** | 自测完成 | ✅ 自测通过，待预览确认 |
| **预览** | 预览确认 | 👀 App 已启动，请查看预览效果 |
| **测试** | 开始测试 | 🔍 Tester 正在准备测试用例... |
| **测试** | 用例完成 | ✅ 测试用例已输出，待确认 |
| **测试** | 测试执行 | 🔍 Tester 正在进行自动化测试... |
| **测试** | 测试通过 | ✅ 测试通过！App 开发完成 |
| **测试** | 测试失败 | ⚠️ 测试失败，发现 [N] 个 BUG，待修复 |
| **交付** | 项目完成 | 🎉 【项目名】开发完成！|
| **交付** | 项目清理 | 🧹 项目已清理，资源已释放 |

---

## 五、知识库

### 5.1 产品方法论

```
优先级定义：
- P0：核心功能，必须实现
- P1：重要功能，优先实现
- P2：优化功能，适时实现
- P3：锦上添花，可延后

PRD结构：
1. 产品概述
2. 用户故事
3. 功能需求
4. 非功能需求
5. 验收标准
```

### 5.2 代码规范摘要

```
命名规范：
- 变量：user_name (小写下划线)
- 函数：get_user() (小写下划线)
- 类：UserService (大写开驼峰)
- 常量：MAX_COUNT (大写下划线)

测试要求：
- 覆盖率 > 80%
- 边界条件测试
- 异常情况处理
```

### 5.4 Developer 自测规范（⚠️ 2026-03-26 更新）

```
Developer 完成代码开发后，必须执行以下自测流程：

## 自测流程（必须全部执行）

### 第一步：编译检查
1. flutter analyze - 必须 0 errors（warnings 可以忽略）
2. flutter build ios - 必须成功

### 第二步：启动 App 自测（⚠️ 必须执行）
1. 启动 App：flutter run -d <模拟器>
2. 测试核心页面可访问：
   - 登录/注册页面
   - 首页（已登录状态）
   - 添加物品页面
   - 物品详情页面
   - 统计页面
   - 设置页面
3. 每页面截图保存到 docs/screenshots/
4. 验证 Supabase 连接成功（日志显示 "Supabase init completed"）

### 第三步：UI 美观检查（⚠️ 必须执行）
按以下清单逐项检查，每项必须通过：

```
📋 UI 美观检查清单

□ 颜色使用正确（主色 #007AFF）
□ 字体层级清晰（标题/正文/辅助有区分）
□ 间距一致（8px 网格对齐，页面边距 16px）
□ 圆角统一（按钮 12px，卡片 16px，输入框 10px）
□ 深色模式正常（无白底黑字等异常）
□ 文字可读（对比度足够，无过小字号）
□ 按钮状态完整（默认/按下/禁用样式正确）
□ 图标风格统一（使用 Cupertino Icons）
□ 组件间距得当（不拥挤，留白合理）
□ 无明显布局问题（溢出、遮挡、重叠）
```

### 第四步：验证截图唯一性（⚠️ 必须执行）
```bash
cd docs/screenshots/
shasum *.png
```
- 如果所有 SHA1 值相同 = 自测失败 = 必须重新测试
- 不同页面的截图 SHA1 必须不同

### 第五步：汇报 CEO
汇报内容：
- flutter analyze 结果（必须 0 errors）
- flutter build ios 结果（必须成功）
- UI 美观检查清单通过情况
- 各页面截图路径
- SHA1 验证结果
- 发现的问题（如有）

### ⚠️ 重要提醒
- 发现 bug = 立即修复 = 重新自测 = 确认通过后再汇报 CEO
- 不要把未修复的问题留给 CEO 或 Tester
- 自测不完整 = 开发不完成
- UI 美观检查是自测的必要环节，发现问题立即修复
```

### 5.5 Tester 测试规范（⚠️ 2026-03-25 更新 - 接口+页面分层测试）

```
Tester Agent 必须遵循以下测试规范：

## 测试分层架构

### 第一层：接口测试（API）
- 工具：curl / Python requests
- 执行者：Tester Agent
- 目的：验证后端 API 是否正常

### 第二层：页面测试（UI）
- 工具：Appium + Python
- 执行者：Tester Agent
- 目的：验证 App UI 功能

## 测试流程（必须按顺序执行）

```
阶段 1：接口测试
├── 读取 Supabase 配置
├── 执行 API 测试
├── 记录测试结果
└── 全部通过 → 进入阶段 2
    或失败 → 报告 CEO → Developer 修复

阶段 2：页面测试
├── 启动 Appium Server
├── 启动 iOS 模拟器
├── 注册测试账号
├── 执行 Appium 测试
├── 每步截图保存
└── 全部通过 → 生成报告
    或失败 → 报告 CEO → Developer 修复

阶段 3：验证报告
├── SHA1 验证截图
├── 生成测试报告
└── 汇报 CEO
```

## 接口测试用例（第一阶段）

| 用例编号 | 测试项 | API 端点 |
|----------|--------|----------|
| TC-API-001 | Supabase 连接 | GET / |
| TC-API-002 | 用户注册 | POST /auth/v1/signup |
| TC-API-003 | 用户登录 | POST /auth/v1/token?grant_type=password |
| TC-API-004 | 创建物品 | POST /rest/v1/items |
| TC-API-005 | 查询物品 | GET /rest/v1/items |
| TC-API-006 | 更新物品 | PATCH /rest/v1/items |
| TC-API-007 | 删除物品 | DELETE /rest/v1/items |

## 页面测试用例（第二阶段）

| 用例编号 | 测试项 | 操作步骤 |
|----------|--------|----------|
| TC-UI-001 | 登录页显示 | 启动 App，验证元素 |
| TC-UI-002 | 注册功能 | 输入信息，注册账号 |
| TC-UI-003 | 登录功能 | 输入测试账号登录 |
| TC-UI-004 | 首页显示 | 验证房间 Tab、列表 |
| TC-UI-005 | 添加物品 | 拍照、填写、保存 |
| TC-UI-006 | 物品详情 | 查看详情页 |
| TC-UI-007 | 断舍离操作 | 选择处理方式 |
| TC-UI-008 | 统计页面 | 验证统计数据 |

## 测试账号生成

Tester 自动生成随机账号：
```
邮箱：test_YYYYMMDD_HHMMSS@example.com
密码：Test123456
```

## 截图规范

截图命名：TC-XXX-用例名称.png
保存位置：docs/测试截图/

## SHA1 验证（必须执行！）

```bash
cd docs/测试截图/
shasum *.png
```

验证规则：
- 不同页面的截图 SHA1 必须不同
- 相同 = 测试造假 = 测试失败

## 测试卡住处理

测试过程中如果卡在某个页面超过 2 分钟：
1. 立即截图记录卡住状态
2. 立即向 CEO 报告
3. 等待 Developer 修复后再继续

**不要假装测试通过了！**

## 重要提醒

- ⚠️ 先接口后页面
- ⚠️ 截图是测试的唯一证据
- ⚠️ SHA1 验证不通过 = 测试失败
- ⚠️ 测试卡住 = 立即报告 CEO
- 发现 bug = 立即报告 CEO = CEO 调度 Developer 修复

**测试方案模板**：参考 ~/.openclaw/workspace/MEMORY-TEST-PLAN.md

```markdown
## 3. 自动化测试方式（⚠️ 必填项）

### 3.1 选择的自动化测试方式

| 测试方式 | 适用场景 | 自动化程度 |
|---------|---------|-----------|
| Flutter integration_test | Flutter 项目 | ✅ 全自动 |
| Playwright | Web 项目 | ✅ 全自动 |
| Appium | 原生功能测试 | ✅ 全自动 |
| 手动测试 | 复杂交互 | ❌ 手动 |

### 3.2 本项目选择的测试工具

| 测试工具 | 选择理由 |
|---------|---------|
| Flutter integration_test | Flutter iOS 项目首选，稳定、快速 |

### 3.3 自动化测试执行命令

flutter test integration_test/app_test.dart
```

**测试方式选择规则**：
- Flutter iOS/Android → Flutter integration_test
- Flutter Web → Playwright
- React/Vue Web → Playwright
- 原生 iOS/Android → Appium
```

### 5.6 后端开发规范（Supabase）（⚠️ 2026-03-25 更新）

```
技术选型：Supabase（BaaS，无需自建服务器）

## 第一步：读取环境变量（⚠️ 必须执行）
在开始任何 Supabase 操作前，必须先检查环境变量：

1. 读取 ~/.openclaw/.env 文件
2. 确认 SUPABASE_ACCESS_TOKEN 是否存在
3. 如果不存在，报告 CEO：「缺少 SUPABASE_ACCESS_TOKEN，需要用户提供」
4. 如果存在，使用该 Token 进行操作

## 第二步：创建/配置 Supabase 项目

### 使用 Supabase CLI 创建项目：
```bash
supabase projects create --name <项目名> --org <org-id> --region <region>
```

### 使用 API 创建项目：
```bash
curl -X POST 'https://api.supabase.com/v1/projects' \
  -H 'Authorization: Bearer <SUPABASE_ACCESS_TOKEN>' \
  -H 'Content-Type: application/json' \
  -d '{"name": "<项目名>", "region": " Southeast Asia (Singapore)"}'
```

## 第三步：数据库 Migration 流程
1. 创建 supabase/migrations/001_init.sql
2. 编写建表语句
3. 配置 RLS 策略
4. 执行：supabase db push

接口文档必须包含：
- 数据库表结构（字段、类型、约束）
- RLS 策略
- API 接口列表

后端完成检查清单：
- [ ] 检查 ~/.openclaw/.env 环境变量
- [ ] Supabase 项目已创建
- [ ] 数据库表已创建
- [ ] RLS 策略已配置
- [ ] 接口测试通过
- [ ] 配置已保存到代码

## ⚠️ 重要提醒
- 不要提示用户手动创建 Supabase 项目，除非环境变量不存在
- 所有 Supabase 操作必须使用 ~/.openclaw/.env 中的 Token
- 如果 Token 无效或过期，立即报告 CEO
```

### 5.7 设计规范（⚠️ 2026-03-26 新增）

**通用 Flutter 设计规范**：`~/.openclaw/workspace-developer/FLUTTER-DESIGN-GENERAL.md`

| 项目 | 内容 |
|------|------|
| **定位** | 适用于所有类型 Flutter iOS App |
| **风格** | Apple HIG + Material Design 3 |
| **主色** | `#007AFF`（iOS 系统蓝）|
| **组件库** | Cupertino（主）+ Material（辅）|

### 5.7.1 组件库（⚠️ 2026-03-26 新增）

**组件库目录**：`~/.openclaw/workspace-developer/components/`

| 统计 | 数值 |
|------|------|
| 总文件数 | 27个 |
| 总代码行数 | ~9,884行 |

**基础组件**：
| 文件 | 说明 |
|------|------|
| app_colors.dart | 颜色常量 |
| app_spacing.dart | 间距常量（8px网格）|
| app_radius.dart | 圆角常量 |
| app_theme.dart | ThemeData/CupertinoThemeData |

**业务组件**：
| 文件 | 说明 |
|------|------|
| primary_button.dart | 主按钮（渐变/阴影/动效）|
| secondary_button.dart | 次按钮 |
| icon_button.dart | 图标按钮 |
| app_card.dart | 卡片 |
| app_text_field.dart | 输入框 |
| app_list_tile.dart | 列表项 |
| app_chip.dart | 标签 |
| app_badge.dart | 徽章 |
| app_scaffold.dart | 页面脚手架 |
| app_bottom_nav.dart | 底部导航栏 |
| app_dialog.dart | 对话框 |
| app_loading.dart | 加载指示器 |
| app_empty_state.dart | 空状态 |
| app_section_header.dart | 分组标题 |
| app_toast.dart | Toast提示 |
| app_snackbar.dart | Snackbar提示 |
| app_search_bar.dart | 搜索框 |
| app_progress.dart | 进度条 |
| app_nav_bar.dart | 导航栏 |
| app_divider.dart | 分割线 |
| app_avatar.dart | 头像 |
| app_refresh.dart | 下拉刷新 |

**使用方式**：
```dart
import 'package:your_app/components/components.dart';

PrimaryButton(
  text: '登录',
  isFullWidth: true,
  onPressed: () => _login(),
)

AppCard(
  onTap: () => _detail(),
  child: Text('内容'),
)
```

**Developer 必须遵循**：
- 所有 UI 组件必须使用组件库中的封装组件
- 严格遵循规范中的颜色、字号、间距、圆角
- 遵循 8px 网格间距系统
- 支持深色/浅色双模式

### 5.8 目录结构规范

```
~/.openclaw/projects/<项目名>/
├── code/
│   ├── frontend/              # 前端代码
│   └── backend/               # 后端代码（如需要）
├── supabase/
│   └── migrations/
│       └── 001_init.sql      # 数据库迁移脚本
├── docs/
│   ├── PRD.md                # 产品需求文档
│   ├── 设计.md               # 技术设计文档
│   ├── 接口文档.md           # 接口文档（包含数据库设计）
│   ├── 测试用例/
│   ├── 测试报告/
│   └── 测试截图/
├── screenshots/              # 开发自测截图
├── test-config.json         # Tester 配置
└── README.md
```

### 5.8 BUG 分级

```
Critical：核心功能完全不可用
High：主要功能无法正常使用
Medium：功能有问题但有替代方案
Low：界面样式、文字等小问题
```

---

## 六、常见任务模板

### 6.1 完整开发流程（⚠️ 2026-03-25 更新）

```
阶段1：需求讨论 → CEO 与用户确认需求
阶段2：PRD 编写 → Product Agent 输出 docs/PRD.md → 用户确认
阶段3：技术设计 → Developer Agent 输出 docs/设计.md + docs/接口文档.md + supabase/migrations/ → 用户确认 ⚠️
阶段4：代码开发 → Developer Agent 开发 + 自测（含 SHA1 验证）+ GitHub 提交 → 用户确认 ⚠️
阶段5：测试准备 → Tester Agent 输出 docs/测试用例/ + docs/测试方案.md → 用户确认
阶段6：测试执行 → Tester Agent 执行测试（含截图 SHA1 验证）+ 输出 docs/测试报告/ → 用户确认
阶段7：项目交付 → CEO 验收 + 清理资源

⚠️ CEO 铁律：
- ❌ 不能修改/修复代码
- ❌ 不能启动 App 测试
- ❌ 不能手动运行测试
- 以上全部由对应 Agent 执行
```

### 6.2 阶段确认节点（⚠️ 必须遵守）

```
[需求讨论] → 用户确认
    ↓
[PRD 完成] → 用户确认 "确认开发" 或 "修改 XXX"
    ↓
【⚠️ 设计阶段必须汇报 CEO，等待用户确认后再开发】
[设计完成] → 汇报内容：技术方案、数据库设计、架构图
    ↓ 用户确认 "确认开发" 或 "修改 XXX"
    ↓
【⚠️ Developer 才开始写代码】
[代码开发] → Developer 自测（含 SHA1 验证）→ 汇报：截图 + SHA1 验证结果
    ↓
[预览完成] → 用户查看 App 效果 → 用户确认 "确认测试" 或 "有bug"
    ↓
[测试用例+方案完成] → 用户确认 "确认测试执行"
    ↓
[测试报告完成] → 汇报：测试用例数、通过率、截图 SHA1 验证结果 → 用户确认 "确认交付"
    ↓
[项目完成] → 清理资源
```

### 6.2.1 Developer 阶段汇报模板

Developer 完成设计/开发后，必须向 CEO 汇报：

```
✅ [阶段名称] 已完成

📋 汇报内容：
- [文件路径或说明]
- [自测截图路径]
- [SHA1 验证结果]

⚠️ 等待 CEO 确认后才能进入下一阶段
```

### 6.3 BUG 修复流程（⚠️ 2026-03-25 更新）

```
## 场景1：自测中发现 BUG

Developer 在自测过程中发现 BUG：
→ 立即修复 BUG
→ 重新自测验证
→ 确认通过后再汇报 CEO

## 场景2：Tester 报告 BUG

Tester 发现 BUG：
→ Tester 立即报告 CEO：「发现 BUG：[描述]」
→ CEO 调度 Developer 修复
→ Developer 修复后重新自测
→ Tester 复测验证
→ CEO 汇报用户

## 场景3：用户反馈问题

用户反馈问题：
→ CEO 记录问题
→ 调度 Developer 修复
→ Developer 直接修复，不需要等 CEO 进一步指示
→ Developer 修复后汇报 CEO
→ CEO 汇报用户

## ⚠️ Developer 自主修复规则

Developer 发现任何问题（包括但不限于）：
- 编译错误
- 运行时错误（如 Supabase 连接失败）
- 页面无法访问
- 功能异常

→ 立即修复 → 重新自测 → 确认通过后汇报

不需要等 CEO 调度！Developer 有权限直接修复开发相关的问题。

## 汇报内容

BUG 修复后必须汇报：
- 修改的文件
- 修改的内容
- 修复后的自测结果（含截图 + SHA1 验证）
```

---

### 7.1 Agent 超时配置

| Agent | 任务类型 | 超时时间 |
|-------|---------|----------|
| Product | PRD编写 | 900秒（15分钟） |
| Developer | 代码开发 | 900秒（15分钟） |
| Developer | 技术设计 | 900秒（15分钟） |
| Tester | 测试验证 | 900秒（15分钟） |

> 2026-03-24 更新：统一改为15分钟，避免复杂任务被中断

> 每次任务完成后，记得更新这里

- [ ] 飞书通知问题排查
  - 定时任务每日日报发送失败
  - 任务流转通知不推送到群里
  - 原因待查
- [ ] Appium iOS 26.0 兼容性问题
  - Tester Agent 测试超时
  - 需找到解决方案

---

## 🎯 团队目标（2026年）

### 一人公司模式
**目标**：依靠 AI 团队（CEO + Product + Developer + Tester）+ 创始人一个人，开发并上架 iOS App，建立一人公司。

**核心理念**：
- 创始人 = 产品经理 + 设计师（想创意、确认需求、验收结果）
- AI 团队 = 产品经理 + 开发 + 测试（执行具体工作）
- 技术选型 = Flutter + Supabase（低成本、高效率）

**成功标准**：
- 至少 1 个 App 成功上架 App Store

---

## 八、每周总结

> 每周日晚自动总结，写入此处

### 2026年第12周（03.10-03.16）

- （暂无记录）

### 2026年第13周（03.17-03.23）

- （暂无记录）

---

> **维护规则**：
> 1. 每完成一个任务，更新"项目记录"
> 2. 每周日晚自动总结到"每周总结"
> 3. MEMORY.md 保持精简，不要变成日记
> 4. 如果某个板块内容过多，拆分到独立文件