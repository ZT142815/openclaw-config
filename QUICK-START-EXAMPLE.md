# 🎯 OpenClaw 快速启动示例

## 场景：开发一个"待办事项管理应用"

---

## 第 1 步：告诉 CEO Agent 你的需求

**你说：**
```
我想做一个待办事项管理应用，帮助用户高效管理日常任务。
希望支持多平台（Web + 移动应用），有优先级管理、截止日期提醒等功能。
```

---

## 第 2 步：CEO Agent 自动启动 SOUL.md 流程

CEO 会按照 SOUL.md 中定义的 10 步启动流程：

1. ✅ 读取 IDENTITY.md → "我是周小墨，CEO"
2. ✅ 读取 USER.md → "当前用户是 chris"
3. ✅ 读取 MEMORY.md → "团队成员和历史项目"
4. ✅ 读取 AGENTS.md → "Product、Developer、Tester 的任务"
5. ✅ 读取 skills/PROJECT-COORDINATION.md → "项目协调标准"

**CEO 的回复：**
```
好的！我来帮你完成这个待办事项管理应用。

📋 在派发给团队之前，我需要跟你确认几个问题：

🎯 核心目标：
- 这个应用的核心价值是什么？（时间管理？习惯养成？）
- 目标用户是谁？（个人用户？团队协作？）

📱 平台要求：
- 需要支持哪些平台？（Web、iOS、Android）
- 需要第三方集成吗？（日历、邮件、推送通知）

⏰ 优先级：
- P0 必须有：（列出核心功能）
- P1 最好有：（列出增强功能）
- P2 可以后期加：（列出未来功能）

请告诉我你的想法，我来整理成完整需求后再交给团队执行。
```

---

## 第 3 步：你提供详细信息

**你说：**
```
核心目标：帮助个人用户有效管理和跟踪日常任务，提高生产力

目标用户：工作繁忙的专业人士（25-40岁）

平台：需要 Web 版本（优先），后期考虑移动应用

功能优先级：
- P0: 任务创建、编辑、删除；优先级和截止日期；任务状态跟踪
- P1: 任务分类和标签；定期提醒；任务统计和报表
- P2: AI 智能建议；团队协作；移动应用

无需第三方集成，只需邮件提醒即可。
```

---

## 第 4 步：CEO 整理需求并确认

**CEO 的回复：**
```
根据你的描述，我整理的需求如下：

📝 需求概要：
1. 任务CRUD操作（创建、编辑、删除、查看）
2. 优先级管理（高、中、低三个等级）
3. 截止日期和提醒
4. 任务状态管理（待做、进行中、完成）
5. 任务分类（工作、生活、健身等）
6. 任务统计仪表板

📋 我的计划：
1. Product Agent 编写详细 PRD（参考 PRD-TEMPLATE.md）
2. Developer Agent 进行技术设计
3. Developer Agent 实现代码
4. Tester Agent 进行测试

⏸️ 请确认需求是否正确？
```

**你说：** `确认！开始执行`

---

## 第 5 步：CEO 派发 Product Agent

**CEO 调度：**
```
@Product Agent，请根据以下需求编写 PRD：

用户：工作繁忙的专业人士
核心功能：任务管理、优先级、截止日期、提醒、分类、统计

请使用 skills/PRD-TEMPLATE.md 和 skills/REQUIREMENT-ANALYSIS.md 编写专业 PRD。
```

---

## 第 6 步：Product Agent 启动流程

Product 按照自己的 SOUL.md（10步流程）：

1. ✅ 读取 IDENTITY.md → "我是周小产，产品经理"
2. ✅ 读取 MEMORY.md → "团队历史和最佳实践"
3. ✅ 读取 skills/PRD-TEMPLATE.md → "PRD 标准模板"
4. ✅ 读取 skills/REQUIREMENT-ANALYSIS.md → "需求分析框架"

**Product 的输出：**
```
# 产品需求文档 - 待办事项管理应用

## 产品概述
面向工作繁忙的专业人士，提供高效的任务管理和跟踪能力...

## 用户故事
1. 作为项目经理，我想快速创建任务列表，这样我可以追踪团队进度
2. 作为忙碌的上班族，我想设置任务优先级，这样我可以先做最重要的事
3. ...

## 功能需求
1. 任务管理
   - 创建任务（标题、描述、优先级、截止日期、分类）
   - 编辑任务信息
   - 删除任务
   - 查看任务列表
   - 标记任务完成/未完成

2. 任务分类
   - 预设分类（工作、生活、健身）
   - 自定义分类
   - 按分类筛选

3. 提醒和截止日期
   - 设置截止日期
   - 邮件提醒（截止前24小时、1小时）
   - 逾期提醒

4. 仪表板
   - 任务统计（总数、完成率、按优先级分布）
   - 今日任务视图
   - 周任务视图

## 数据模型
- Task: id, title, description, priority, dueDate, status, category, createdAt, updatedAt
- Category: id, name, color, userId
- User: id, email, name, preferences

## API 设计
- POST /api/tasks - 创建任务
- GET /api/tasks - 获取任务列表
- PUT /api/tasks/:id - 更新任务
- DELETE /api/tasks/:id - 删除任务
- ...

## 非功能需求
- 性能：API 响应时间 < 200ms
- 可用性：99.5% 正常运行时间
- 安全性：用户数据加密存储
- 兼容性：Chrome、Safari、Firefox 最新版本

## 验收标准
- 所有功能按 PRD 实现
- 代码覆盖率 > 80%
- 界面美观易用
- 响应时间达到目标
- 无 Critical/High 级 BUG
```

CEO 汇报：`PRD 已完成，请确认是否可以开发？`

**你说：** `确认开发`

---

## 第 7 步：CEO 派发 Developer Agent

**CEO 调度：**
```
@Developer Agent，请根据 PRD 进行技术设计和实现。

使用技术栈：
- 前端：React + TypeScript
- 后端：Node.js + Express
- 数据库：PostgreSQL
- 托管：Supabase

请参考 skills/CODING-STANDARDS.md 和 skills/SUPABASE.md
```

---

## 第 8 步：Developer Agent 启动流程

Developer 按照自己的 SOUL.md：

1. ✅ 读取 IDENTITY.md → "我是周小码，开发工程师"
2. ✅ 读取 MEMORY.md → "技术栈和最佳实践"
3. ✅ 读取 skills/CODING-STANDARDS.md → "代码规范"
4. ✅ 读取 skills/SUPABASE.md → "Supabase 使用指南"

**Developer 的输出：**

### 技术设计文档
```
# 待办事项应用 - 技术设计文档

## 架构设计
- 前端：React SPA（单页应用）
- 后端：Node.js REST API
- 数据库：PostgreSQL（通过 Supabase）
- 认证：JWT + Supabase Auth
- 消息队列：Supabase 函数处理提醒

## 项目结构
```
frontend/
├── src/
│   ├── components/
│   │   ├── TaskList/
│   │   ├── TaskForm/
│   │   └── Dashboard/
│   ├── pages/
│   ├── hooks/
│   ├── services/ (API 调用)
│   └── App.tsx
backend/
├── routes/
│   ├── tasks.ts
│   ├── categories.ts
│   └── auth.ts
├── models/
├── middleware/
└── server.ts
```

## 数据库 Schema
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email TEXT UNIQUE,
  name TEXT,
  created_at TIMESTAMP
);

CREATE TABLE categories (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users,
  name TEXT,
  color TEXT
);

CREATE TABLE tasks (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users,
  category_id UUID REFERENCES categories,
  title TEXT,
  description TEXT,
  priority INT (1-3),
  status TEXT (pending, doing, done),
  due_date TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

## API 端点
```
POST   /api/v1/tasks           创建任务
GET    /api/v1/tasks           获取任务列表（支持筛选）
GET    /api/v1/tasks/:id       获取单个任务
PUT    /api/v1/tasks/:id       更新任务
DELETE /api/v1/tasks/:id       删除任务

POST   /api/v1/categories      创建分类
GET    /api/v1/categories      获取分类列表
PUT    /api/v1/categories/:id  更新分类
DELETE /api/v1/categories/:id  删除分类
```

## 开发计划（按代码规范实现）
- Day 1-2: 数据库设计和后端框架搭建
- Day 3-4: 实现任务 CRUD API
- Day 5: 实现分类和提醒功能
- Day 6-7: 前端 UI 开发
- Day 8: 集成和调试
```

### 核心代码示例（遵循 CODING-STANDARDS.md）

```typescript
// backend/routes/tasks.ts
import { Router, Request, Response } from 'express';
import { supabase } from '../config/supabase';

const router = Router();

// 获取用户的所有任务
router.get('/', async (req: Request, res: Response) => {
  try {
    const userId = req.user.id;
    const { priority, status, category } = req.query;

    let query = supabase
      .from('tasks')
      .select('*')
      .eq('user_id', userId)
      .order('due_date', { ascending: true });

    if (priority) query = query.eq('priority', priority);
    if (status) query = query.eq('status', status);
    if (category) query = query.eq('category_id', category);

    const { data, error } = await query;

    if (error) throw error;
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 创建新任务
router.post('/', async (req: Request, res: Response) => {
  try {
    const { title, description, priority, dueDate, categoryId } = req.body;
    const userId = req.user.id;

    // 验证输入
    if (!title || !priority) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const { data, error } = await supabase
      .from('tasks')
      .insert({
        user_id: userId,
        title,
        description,
        priority,
        due_date: dueDate,
        category_id: categoryId,
        status: 'pending',
      })
      .select()
      .single();

    if (error) throw error;
    res.status(201).json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// ... 其他端点
```

CEO 汇报：`开发完成，已通过代码审查，请进行测试？`

**你说：** `进行测试`

---

## 第 9 步：CEO 派发 Tester Agent

**CEO 调度：**
```
@Tester Agent，请对待办事项应用进行完整测试。

参考 skills/ACCEPTANCE-CRITERIA.md 中的验收标准：
- 所有功能点
- 边界情况
- 用户流程
- 性能指标

请生成详细的测试报告。
```

---

## 第 10 步：Tester Agent 启动流程

Tester 按照自己的 SOUL.md：

1. ✅ 读取 IDENTITY.md → "我是周小测，QA工程师"
2. ✅ 读取 MEMORY.md → "测试方法和标准"
3. ✅ 读取 skills/ACCEPTANCE-CRITERIA.md → "DoD 检查清单"

**Tester 的输出：**

```
# 待办事项应用 - 测试报告

## 功能测试

### 任务管理模块
✅ TC-001: 创建任务
  - 步骤：点击"新建"，填写标题和优先级，点击保存
  - 预期：任务出现在列表中
  - 结果：通过

✅ TC-002: 编辑任务
  - 步骤：点击任务，修改内容，保存
  - 预期：任务内容更新
  - 结果：通过

✅ TC-003: 删除任务
  - 步骤：选择任务，点击删除
  - 预期：任务从列表删除
  - 结果：通过

...

### BUG 报告
❌ BUG-001: 邮件提醒延迟
  - 复现步骤：
    1. 创建截止时间为今天下午3点的任务
    2. 等待提醒触发
  - 预期：2:00 PM 时收到邮件
  - 实际：邮件延迟15分钟才发送
  - 严重程度：Medium
  - 建议：检查邮件队列配置

## 性能测试
- 加载任务列表（1000条）: 150ms ✅
- 创建任务: 100ms ✅
- 邮件发送延迟: 20s（需要优化）

## 验收清单
✅ 所有 P0 功能完整
✅ 代码覆盖率 85%
⚠️ 1 个 Medium BUG 需要修复
✅ 界面美观易用
✅ 响应时间达到目标
```

---

## 第 11 步：BUG 修复和复测

CEO 汇报测试结果，Developer 修复 BUG，Tester 复测确认。

---

## 第 12 步：项目上线

**CEO 最终汇报：**
```
🎉 恭喜！待办事项应用已完成开发和测试，准备上线！

📊 项目总结：
- 功能完整度：100%
- 代码质量：A
- 测试覆盖率：85%
- 性能达标：✅
- BUG：0 个未解决

✨ 成果亮点：
- 完整的任务管理系统
- 优先级和分类支持
- 邮件提醒功能
- 完整的数据统计

📈 下一步：
1. 上线到生产环境
2. 收集用户反馈
3. 规划 V2 功能（AI 建议、团队协作、移动应用）
```

---

## 📚 关键数字

| 指标 | 数值 |
|------|------|
| 总开发周期 | 2 周 |
| 代码行数 | ~3,000 行 |
| 测试用例 | 50+ 个 |
| BUG 发现 | 12 个（11 个已修复） |
| 代码覆盖率 | 85% |
| 性能达成率 | 100% |

---

## 🎯 这个例子展示了什么？

✅ **完整的工作流程**
- CEO 需求分析和任务分配
- Product 需求文档编写
- Developer 技术设计和实现
- Tester 质量保证

✅ **标准化的输出**
- 每个 Agent 按照自己的 SOUL.md 启动
- 使用 skills/ 中的标准模板和规范
- 所有文档格式统一

✅ **高效的协作**
- 每个 Agent 专注自己的领域
- CEO 负责整体协调
- 清晰的交接点和验收标准

✅ **可复用的知识**
- PRD 模板可用于所有产品
- 代码规范确保代码质量
- DoD 检查清单确保质量门禁

---

**现在你就可以告诉 CEO Agent 你的新项目需求，系统会自动按照这个流程执行！** 🚀
