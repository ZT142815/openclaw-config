

# TOOLS.md - CEO Agent 工具配置

## 第四层：工具层

> **每次启动时读取此文件，了解可用工具**

---

## 一、Agent 调度工具

### 1.1 核心调度命令

```bash
# 调度 Product Agent
sessions_spawn({
  task: "你是 Product Agent。分析需求并编写PRD: [需求描述]",
  label: "product-prd",
  runtime: "subagent",
  timeoutSeconds: 180
})

# 调度 Developer Agent
sessions_spawn({
  task: "你是 Developer Agent。开发代码: [任务]，参考PRD: [PRD路径]",
  label: "developer-code",
  runtime: "subagent",
  timeoutSeconds: 300
})

# 调度 Tester Agent
sessions_spawn({
  task: "你是 Tester Agent。测试验证: [项目名称]，参考文档: [文档路径]",
  label: "tester-verify",
  runtime: "subagent",
  timeoutSeconds: 180
})

# 查看所有 Agent 状态
openclaw agents list
```

### 1.2 工作区路径

| Agent | 工作区路径 | agentDir 路径 |
|-------|-----------|--------------|
| main (CEO) | ~/.openclaw/workspace/ | - |
| product | ~/.openclaw/workspace-product/ | ~/.openclaw/agents/product/agent/ |
| developer | ~/.openclaw/workspace-developer/ | ~/.openclaw/agents/developer/agent/ |
| tester | ~/.openclaw/workspace-tester/ | ~/.openclaw/agents/tester/agent/ |

---

## 二、文件操作工具

### 2.1 读取文件

```bash
# 读取 MEMORY.md
openclaw read --file MEMORY.md

# 读取今日日志
openclaw read --file memory/2026-03-19.md
```

### 2.2 写入文件

```bash
# 更新 MEMORY.md
openclaw write --file MEMORY.md --content "[内容]"

# 更新今日日志
openclaw write --file memory/2026-03-19.md --append "[内容]"
```

### 2.3 项目文件操作

```bash
# 读取 PRD
openclaw read --file ~/.openclaw/projects/[项目名]/PRD.md

# 读取 SPEC
openclaw read --file ~/.openclaw/projects/[项目名]/SPEC.md

# 读取测试报告
openclaw read --file ~/.openclaw/projects/[项目名]/TEST_REPORT.md
```

---

## 三、任务管理工具

### 3.1 任务状态跟踪

```bash
# 查看任务列表
openclaw tasks list

# 更新任务状态
openclaw tasks update --id [任务ID] --status [状态]
```

### 3.2 任务状态定义

| 状态 | 说明 | 标识 |
|------|------|------|
| PENDING | 待处理 | ⬜ |
| IN_PROGRESS | 进行中 | 🔄 |
| WAITING_DEP | 等待依赖 | ⏳ |
| COMPLETED | 已完成 | ✅ |
| BLOCKED | 被阻塞 | ❌ |

---

## 四、飞书集成工具

### 4.1 发送消息

```bash
# 发送消息给用户
openclaw feishu send --message "[消息]"

# 发送文件
openclaw feishu send --file [文件路径]
```

### 4.2 配置信息

```yaml
飞书配置:
  appId: cli_a91436b647f99cb5
  connectionMode: websocket
  domain: feishu
```

---

## 五、记忆管理工具

### 5.1 写入记忆

```bash
# 记住新信息
openclaw memory write --content "[要记住的内容]"

# 记住决策
openclaw memory write --type decision --content "[决策内容]"

# 记住用户偏好
openclaw memory write --type preference --content "[偏好内容]"
```

### 5.2 读取记忆

```bash
# 读取所有记忆
openclaw memory read

# 搜索记忆
openclaw memory search --query "[关键词]"
```

---

## 六、定时任务工具

### 6.1 Cron 任务

```bash
# 创建每日任务
openclaw cron add --name "[任务名]" --cron "0 9 * * *" --tz "Asia/Shanghai"

# 查看所有任务
openclaw cron list

# 删除任务
openclaw cron delete --id [任务ID]
```

### 6.2 Heartbeat 任务

> 在 HEARTBEAT.md 中配置，参考：`~/.openclaw/workspace/HEARTBEAT.md`

---

## 七、使用规范

### 7.1 安全原则

- ⛔ 高风险操作（删除文件、系统命令）必须先确认
- 🔐 涉及用户隐私的信息必须保密
- 📝 所有重要操作必须记录到当日日志

### 7.2 效率原则

- 📁 优先使用已有的标准化模板
- 🔄 重复任务考虑封装成 Skills
- 📊 定期清理过期的临时文件

---

## 八、Skills 技能扩展

### 8.1 已安装的 Skills

| Skill | 功能 | 使用命令 | 状态 |
|-------|------|----------|------|
| feishu | 飞书集成 | /feishu | ✅ 已配置 |
| openclaw-tavily-search | 联网搜索 | /tavily-search | ✅ 已配置 |
| openclaw-mem0 | 语义记忆 | 内置 | ✅ 已配置 |
| ppt-generator | PPT 生成 | /ppt-generator | ✅ 已配置 |
| pdf-generator | PDF 生成 | /pdf-generator | ✅ 已配置 |
| competitor-analysis | 竞品分析 | /competitor-analysis | ✅ 已配置 |
| smart-weekly-report | 周报生成 | /smart-weekly-report | ✅ 已配置 |

### 8.2 安装新 Skills

```bash
# 搜索 Skills
clawhub search [关键词]

# 安装 Skills（使用 clawhub）
npx clawhub@latest install [skill-name]

# 或使用 openclaw skills
openclaw skills install @clawhub/[skill-name]
```

---

## 九、内容生成工具

### 9.1 PPT 生成（ppt-generator）

> **乔布斯风极简科技感竖屏 HTML 演示稿**

#### 使用场景
- 项目汇报
- 需求评审
- 技术分享
- 产品演示

#### 使用方法
```
/ppt-generator
根据你的讲稿内容生成 PPT
```

#### 输出格式
- 直接输出可运行的 HTML 文件
- 支持部署分享链接

---

### 9.2 PDF 生成（pdf-generator）

> **生成正式 PDF 文档**

#### 使用场景
- 测试报告
- 需求文档
- 项目交付物
- 正式文档

#### 使用方法
```
/pdf-generator
根据内容生成 PDF 文档
```

---

## 十、分析工具

### 10.1 竞品分析（competitor-analysis）

> **完整竞品分析工具**

#### 使用场景
- 新产品开发前的市场调研
- 现有产品的竞品对比
- 差异化定位分析

#### 使用方法
```
/competitor-analysis
分析 [竞品名称] 的相关信息
```

#### 分析维度
- 产品功能对比
- 定价策略
- 用户评价
- 市场表现

---

### 10.2 联网搜索（Tavily）

> **专为 AI Agent 优化的搜索工具**，输出结构化结果，无广告

#### 配置信息
- **API Key**：通过 `openclaw config set skills.tavily-search.apiKey` 配置
- **免费额度**：每月 1000 次搜索
- **官网**：https://tavily.com

#### 使用场景

| 场景 | 使用方法 |
|------|---------|
| 竞品分析 | 搜索竞品信息、用户评价、功能对比 |
| 技术调研 | 搜索技术方案、最佳实践、技术文档 |
| 行业趋势 | 搜索市场报告、行业动态、数据统计 |
| 问题解决 | 搜索问题解决方案、技术博客 |

#### 使用示例

```bash
# 直接在对话中使用自然语言
"帮我搜索一下竞品Notion的相关信息"

# 或者使用 Skill 命令
/tavily-search 搜索"竞品名"相关信息
```

---

## 十一、报告生成工具

### 11.1 周报生成（smart-weekly-report）

> **智能周报生成工具**

#### 使用场景
- 每周工作汇报
- 项目进度总结
- 团队周报汇总

#### 使用方法
```
/smart-weekly-report
生成本周工作周报
```

---

## 十二、记忆工具

### 12.1 Mem0 语义记忆

> **火山引擎 Mem0 持久化记忆**

#### 配置信息
- **模式**：platform
- **userId**：openclaw-user
- **功能**：自动记忆、自动召回

#### 使用场景
- 跨会话记忆用户偏好
- 记忆项目历史
- 上下文延续

---

> **工具层维护规则**：
> 1. 每次新增工具或能力，更新此文件
> 2. 定期清理不再使用的工具配置
> 3. 保持命令示例的准确性
