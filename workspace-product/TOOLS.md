



# TOOLS.md - Product Agent 工具配置

## 第四层：工具层

> **每次启动时读取此文件，了解可用工具**

---

## 一、文档工具

### 1.1 文档编辑器

| 工具 | 用途 | 快捷命令 |
|------|------|----------|
| Typora | Markdown 编辑 | - |
| VSCode | 代码/文档编辑 | `code .` |
| Obsidian | 知识管理 | - |

### 1.2 协作工具

| 工具 | 用途 | 说明 |
|------|------|------|
| 飞书 | 文档协作 | 主要沟通工具 |
| 钉钉 | 备用协作 | - |

---

## 二、文件操作工具

### 2.1 项目文件操作

```bash
# 创建 PRD 文档
openclaw write --file ~/.openclaw/projects/[项目名]/PRD.md --content "[内容]"

# 读取 PRD 模板
openclaw read --file ~/.openclaw/projects/_templates/PRD_TEMPLATE.md

# 更新需求文档
openclaw write --file ~/.openclaw/projects/[项目名]/PRD.md --append "[更新内容]"
```

### 2.2 记忆文件操作

```bash
# 更新今日日志
openclaw write --file memory/2026-03-19.md --append "[工作记录]"

# 更新长期记忆
openclaw write --file MEMORY.md --content "[更新内容]"
```

---

## 三、竞品分析工具

### 3.1 调研工具

| 工具 | 用途 | 网址 |
|------|------|------|
| 百度指数 | 热度分析 | index.baidu.com |
| 蝉妈妈 | 电商数据 | chanmama.com |
| App Annie | App 数据 | appannie.com |

### 3.2 用户调研模板

```markdown
## 用户访谈模板

1. 基本信息
   - 用户画像：[描述]
   - 使用场景：[描述]

2. 核心需求
   - 痛点：[描述]
   - 期望：[描述]

3. 使用习惯
   - 频率：[描述]
   - 场景：[描述]

4. 反馈建议
   - [内容]
```

---

## 四、项目模板

### 4.1 项目存放目录

```
~/.openclaw/projects/
├── [项目名]/
│   ├── PRD.md              # 产品需求文档
│   ├── SPEC.md             # 技术规格说明（Developer输出）
│   ├── TEST_REPORT.md      # 测试报告（Tester输出）
│   ├── src/                # 源代码
│   └── docs/               # 文档目录
└── _templates/             # 模板目录
    ├── PRD_TEMPLATE.md     # PRD模板
    └── USER_STORY.md       # 用户故事模板
```

---

## 五、分析工具

### 5.1 用户画像模板

```markdown
## 用户画像

### 基础信息
- 姓名：[名称]
- 年龄：[范围]
- 职业：[描述]
- 收入：[范围]

### 行为特征
- 使用频率：[频率]
- 主要场景：[场景]
- 常用设备：[设备]

### 核心需求
- [需求1]
- [需求2]

### 痛点
- [痛点1]
- [痛点2]
```

### 5.2 竞品分析模板

```markdown
## 竞品分析

### 竞品基本信息
- 名称：[名称]
- 官网：[网址]
- 下载量：[数量]
- 评分：[评分]

### 功能对比
| 功能 | 我们的产品 | 竞品A | 竞品B |
|------|-----------|-------|-------|
| [功能] | [有/无] | [有/无] | [有/无] |

### 优劣势分析
**优势：**
- [优势1]

**劣势：**
- [劣势1]

### 借鉴价值
- [价值点]
```

---

## 六、汇报工具

### 6.1 向 CEO 汇报

```bash
# 汇报 PRD 完成
openclaw feishu send --message "📋 PRD 已完成：[项目名]，请审核"

# 汇报需求变更
openclaw feishu send --message "⚠️ 需求变更：[描述]，请确认"
```

---

## 七、Skills 技能扩展

### 7.1 已安装的 Skills

| Skill | 功能 | 使用命令 | 安装位置 |
|-------|------|----------|----------|
| feishu | 飞书集成 | /feishu | 内置 |
| baidu-search | 百度中文搜索 | /baidu-search | ✅ 已安装 |
| product-manager-toolkit | 产品经理工具包 | /pm-toolkit | ✅ 已安装 |
| data-analyst | 数据分析图表 | /data-analyst | ✅ 已安装 |
| competitor-analysis | 竞品分析 | /competitor-analysis | CEO 共享 |

### 7.2 Skills 使用指南

#### 竞品分析
```bash
/competitor-analysis
分析 [竞品名称] 的相关信息
```

#### 产品经理工具包
```bash
/pm-toolkit
使用 RICE 模型评估需求优先级
```

#### 数据分析
```bash
/data-analyst
分析 [数据文件路径] 并生成可视化图表
```

#### 中文搜索
```bash
/baidu-search
搜索 [关键词] 相关的中文信息
```

### 7.3 安装新 Skills

```bash
# 安装到 Product 工作空间
npx clawhub@latest install [skill-name] --workdir ~/.openclaw/workspace-product
```

---

> **工具层维护规则**：
> 1. 每次新增工具或能力，更新此文件
> 2. 定期清理不再使用的工具配置
> 3. 保持命令示例的准确性
