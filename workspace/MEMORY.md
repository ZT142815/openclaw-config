

# MEMORY.md - CEO Agent 长期记忆

> **最后更新**：2026-03-19
> **更新人**：CEO Agent
> **更新原因**：初始化配置

---

## 一、团队架构

### 1.1 团队成员

| Agent | ID | 工作区路径 | 核心职责 |
|-------|-----|-----------|----------|
| CEO | main | workspace/ | 任务调度、协调、汇报 |
| Product | product | workspace-product/ | 需求分析、PRD编写 |
| Developer | developer | workspace-developer/ | 代码开发、技术实现 |
| Tester | tester | workspace-tester/ | 测试执行、BUG跟踪 |

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
| （暂无） | - | - | - |

### 4.2 工作流程

| 决策 | 内容 | 日期 | 原因 |
|------|------|------|------|
| 开发流程 | PRD → 开发 → 测试 → 交付 | 2026-03-19 | 标准流程 |

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

### 5.3 BUG 分级

```
Critical：核心功能完全不可用
High：主要功能无法正常使用
Medium：功能有问题但有替代方案
Low：界面样式、文字等小问题
```

---

## 六、常见任务模板

### 6.1 完整开发流程

```
第一步：调度 Product Agent
sessions_spawn({
  task: "你是 Product Agent。分析需求并编写PRD: [需求描述]",
  label: "product-prd",
  runtime: "subagent",
  timeoutSeconds: 180
})

第二步：等待 PRD 完成

第三步：调度 Developer Agent
sessions_spawn({
  task: "你是 Developer Agent。开发代码: [任务]，参考PRD: [PRD路径]",
  label: "developer-code",
  runtime: "subagent",
  timeoutSeconds: 300
})

第四步：等待开发完成

第五步：调度 Tester Agent
sessions_spawn({
  task: "你是 Tester Agent。测试验证: [项目名称]，参考文档: [文档路径]",
  label: "tester-verify",
  runtime: "subagent",
  timeoutSeconds: 180
})

第六步：汇总结果，向用户汇报
```

### 6.2 BUG 修复流程

```
第一步：接收 BUG 报告
→ 记录 BUG 详情

第二步：调度 Developer Agent
sessions_spawn({
  task: "你是 Developer Agent。修复BUG: [BUG描述]",
  label: "developer-fix",
  runtime: "subagent",
  timeoutSeconds: 180
})

第三步：等待修复完成

第四步：调度 Tester Agent
sessions_spawn({
  task: "你是 Tester Agent。复测验证: [BUG ID]",
  label: "tester-retest",
  runtime: "subagent",
  timeoutSeconds: 120
})

第五步：向用户汇报结果
```

---

## 七、待处理事项

> 每次任务完成后，记得更新这里

- [ ] （暂无）

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