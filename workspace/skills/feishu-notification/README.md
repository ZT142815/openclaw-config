# 飞书通知 Skill · Feishu Notification

> **版本**：v1.0
> **更新日期**：2026-04-01
> **功能**：自动同步任务状态到飞书群

---

## ✨ 功能特性

- 🔔 **主动通知**：任务完成、待确认等关键节点自动同步
- 📋 **多场景覆盖**：17 个触发场景，覆盖完整项目生命周期
- 🎨 **卡片消息**：美观的飞书卡片格式，支持按钮交互
- ⚡ **一键集成**：Python/Shell 多语言实现，开箱即用

---

## 📋 触发场景

| 类别 | 场景数 | 说明 |
|------|--------|------|
| ⏸️ 待确认 | 6 | 需要用户决策的节点 |
| ✅ 完成 | 5 | 阶段性完成通知 |
| 📅 周期汇报 | 2 | 早晚报、周报 |
| ⚠️ 关键节点 | 4 | 立项、里程碑、阻塞、紧急 |

---

## 🚀 快速开始

### 第一步：获取飞书 Webhook

1. 打开飞书群 → 群设置 → 群机器人
2. 添加机器人 → 自定义机器人
3. 复制 Webhook 地址

### 第二步：配置环境变量

```bash
export FEISHU_WEBHOOK="https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx"
```

### 第三步：调用通知

```python
from feishu_notifier import FeishuNotifier

notifier = FeishuNotifier(webhook_url=FEISHU_WEBHOOK)

# 发送完成通知
notifier.send("完成",
    title="开发完成",
    project="Budolist",
    status="代码已提交 GitHub",
    deliverable="code/budolist/",
    owner="周小码"
)
```

---

## 📁 文件结构

```
feishu-notification/
├── SKILL.md          # 核心 Skill 文件
├── README.md         # 使用说明（本文件）
└── examples/        # 使用示例
    ├── python_example.py
    └── shell_example.sh
```

---

## 💬 使用示例

### 场景1：PRD 完成，需要用户确认

```
🔵 PRD 待审核 - 待确认

项目：Budolist
内容：PRD 文档已完成，请确认

负责人：周小产
时间：2026-04-01 11:05
```

### 场景2：开发完成

```
🟢 开发完成

项目：Budolist
状态：✅ 代码已提交 GitHub
交付物：code/budolist/
负责人：周小码
完成时间：2026-04-01 11:10
```

### 场景3：遇到阻塞

```
⚠️ 开发阻塞

问题描述：数据库连接失败
影响范围：无法完成用户模块开发
建议措施：需要配置正确的 Supabase 连接信息

负责人：周小码
时间：2026-04-01 11:15
```

---

## 🔧 集成到 CEO Agent

在 CEO Agent 的关键节点添加飞书通知调用：

```markdown
### PRD 完成
1. CEO 确认 PRD 内容
2. 发送飞书通知 → "PRD 待审核"
3. 等待用户确认

### 开发完成
1. Developer 汇报完成
2. 发送飞书通知 → "开发完成"
3. 等待用户确认是否需要 Review
```

---

## 📚 相关文档

- [SKILL.md](./SKILL.md) - 完整 Skill 定义和模板
- [飞书卡片消息文档](https://open.feishu.cn/document/uAjLw4CM/ukTMukTMukTM/reference/im-v1/message-card/create) - 官方文档

---

## 🔄 更新日志

| 日期 | 版本 | 变更 |
|------|------|------|
| 2026-04-01 | v1.0 | 初始版本 |

---

*飞书通知 Skill · v1.0 · 2026-04-01*
