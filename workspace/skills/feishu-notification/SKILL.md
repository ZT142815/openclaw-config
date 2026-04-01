# 飞书通知 Skill · Feishu Notification

> **版本**：v1.0
> **更新日期**：2026-04-01
> **功能**：自动同步任务状态到飞书群

---

## 一、Skill 定义

你是飞书通知助手，负责在关键节点自动将任务状态同步到飞书群。

### 你的职责

1. **监控**：监听 CEO Agent 的任务状态变化
2. **判断**：识别需要同步的场景
3. **发送**：构造并发送飞书群消息
4. **确认**：记录发送状态

---

## 二、触发场景清单

> **任何需要用户确认的任务，都必须同步飞书群**

### ⏸️ 待确认节点（6个）

| 场景 | 触发时机 | 消息类型 |
|------|----------|----------|
| **需求待确认** | 需求讨论完成，等待用户确认方向 | 🔵 待确认 |
| **PRD 待审核** | PRD 文档已完成 | 🔵 待确认 |
| **设计待审核** | 技术方案已完成 | 🔵 待确认 |
| **代码待Review** | 代码开发完成 | 🔵 待确认 |
| **测试待验收** | 测试全部通过 | 🔵 待确认 |
| **发布待确认** | 版本准备就绪 | 🔵 待确认 |

### ✅ 执行完成（5个）

| 场景 | 说明 | 消息类型 |
|------|------|----------|
| **开发完成** | 代码开发完成 | 🟢 完成 |
| **测试通过** | 测试全部通过 | 🟢 完成 |
| **PRD 完成** | PRD 编写完成 | 🟢 完成 |
| **设计完成** | 技术/视觉设计完成 | 🟢 完成 |
| **版本发布** | App 正式发布/上架 | 🎉 发布 |

### 📅 周期汇报（2个）

| 场景 | 频率 | 消息类型 |
|------|------|----------|
| **早晚报** | 每日 9:00 / 18:00 | 📋 日报 |
| **周报** | 每周五 | 📊 周报 |

### ⚠️ 关键节点（4个）

| 场景 | 说明 | 消息类型 |
|------|------|----------|
| **项目立项** | 新项目正式启动 | 🚀 立项 |
| **里程碑达成** | 完成关键阶段（MVP等） | 🏆 里程碑 |
| **遇到阻塞** | 任务无法继续 | ⚠️ 阻塞 |
| **紧急问题** | 重大BUG或风险 | 🚨 紧急 |

---

## 三、飞书 Webhook 配置

### 3.1 获取 Webhook 地址

1. 打开飞书群
2. 点击群设置 → 群机器人
3. 添加机器人 → 自定义机器人
4. 复制 Webhook 地址

### 3.2 配置 Webhook（手动配置或使用环境变量）

```bash
# 方式1：环境变量
FEISHU_WEBHOOK=https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx

# 方式2：直接传入
webhook_url = "https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx"
```

---

## 四、消息模板库

### 4.1 待确认消息模板

```json
{
  "msg_type": "interactive",
  "card": {
    "header": {
      "title": {"tag": "plain_text", "content": "🔵 [场景名称] - 待确认"},
      "template": "blue"
    },
    "elements": [
      {"tag": "div", "content": {"tag": "lark_md", "content": "**项目**：{项目名称}"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**内容**：[具体内容描述]"}},
      {"tag": "hr"},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**负责人**：{Agent名称}"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**时间**：{时间}"}},
      {"tag": "hr"},
      {
        "tag": "action",
        "actions": [
          {"tag": "button", "text": {"tag": "plain_text", "content": "✅ 确认通过"}, "type": "primary"},
          {"tag": "button", "text": {"tag": "plain_text", "content": "📝 需要修改"}, "type": "default"}
        ]
      }
    ]
  }
}
```

### 4.2 完成消息模板

```json
{
  "msg_type": "interactive",
  "card": {
    "header": {
      "title": {"tag": "plain_text", "content": "🟢 [场景名称] 已完成"},
      "template": "green"
    },
    "elements": [
      {"tag": "div", "content": {"tag": "lark_md", "content": "**项目**：{项目名称}"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**状态**：✅ {完成状态}"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**交付物**：{交付物描述}"}},
      {"tag": "hr"},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**负责人**：{Agent名称}"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**完成时间**：{时间}"}}
    ]
  }
}
```

### 4.3 日报模板

```json
{
  "msg_type": "interactive",
  "card": {
    "header": {
      "title": {"tag": "plain_text", "content": "📋 {日期} 日报"},
      "template": "grey"}
    ,
    "elements": [
      {"tag": "div", "content": {"tag": "lark_md", "content": "**今日完成**"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "{完成列表}"}},
      {"tag": "hr"},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**进行中**"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "{进行中列表}"}},
      {"tag": "hr"},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**明日计划**"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "{明日计划列表}"}}
    ]
  }
}
```

### 4.4 阻塞/问题消息模板

```json
{
  "msg_type": "interactive",
  "card": {
    "header": {
      "title": {"tag": "plain_text", "content": "⚠️ [场景名称]"},
      "template": "orange"
    },
    "elements": [
      {"tag": "div", "content": {"tag": "lark_md", "content": "**问题描述**：[问题]"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**影响范围**：[影响]"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**建议措施**：[措施]"}},
      {"tag": "hr"},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**负责人**：{Agent名称}"}},
      {"tag": "div", "content": {"tag": "lark_md", "content": "**时间**：{时间}"}}
    ]
  }
}
```

---

## 五、发送函数

### 5.1 Python 实现

```python
import requests
import json
from datetime import datetime

class FeishuNotifier:
    def __init__(self, webhook_url):
        self.webhook_url = webhook_url
    
    def send(self, message_type, **kwargs):
        """发送飞书消息"""
        
        templates = {
            "待确认": self._template_pending(),
            "完成": self._template_complete(),
            "日报": self._template_daily(),
            "周报": self._template_weekly(),
            "阻塞": self._template_blocked(),
            "立项": self._template_launch(),
            "里程碑": self._template_milestone(),
            "发布": self._template_release()
        }
        
        template = templates.get(message_type, templates["完成"])
        payload = template(**kwargs)
        
        response = requests.post(
            self.webhook_url,
            headers={"Content-Type": "application/json"},
            data=json.dumps(payload)
        )
        
        return response.json()
    
    def _template_pending(self, **kwargs):
        """待确认模板"""
        return {
            "msg_type": "interactive",
            "card": {
                "header": {
                    "title": {"tag": "plain_text", "content": f"🔵 {kwargs.get('title', '任务待确认')}"},
                    "template": "blue"
                },
                "elements": [
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**项目**：{kwargs.get('project', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**内容**：{kwargs.get('content', '')}"}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**负责人**：{kwargs.get('owner', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**时间**：{kwargs.get('time', '')}"}}
                ]
            }
        }
    
    def _template_complete(self, **kwargs):
        """完成模板"""
        return {
            "msg_type": "interactive",
            "card": {
                "header": {
                    "title": {"tag": "plain_text", "content": f"🟢 {kwargs.get('title', '任务完成')}"},
                    "template": "green"
                },
                "elements": [
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**项目**：{kwargs.get('project', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**状态**：✅ {kwargs.get('status', '已完成')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**交付物**：{kwargs.get('deliverable', '')}"}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**负责人**：{kwargs.get('owner', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**完成时间**：{kwargs.get('time', '')}"}}
                ]
            }
        }
    
    # ... 其他模板方法

# 使用示例
notifier = FeishuNotifier(webhook_url="your-webhook-url")

# 发送完成消息
notifier.send("完成", 
    title="开发完成",
    project="Budolist",
    status="代码已提交 GitHub",
    deliverable="code/budolist/",
    owner="周小码",
    time=datetime.now().strftime("%Y-%m-%d %H:%M")
)
```

### 5.2 Shell/curl 实现（简单版）

```bash
#!/bin/bash

WEBHOOK_URL="your-webhook-url"
TIME=$(date "+%Y-%m-%d %H:%M")

send_feishu() {
    local title=$1
    local project=$2
    local status=$3
    local owner=$4
    
    curl -X POST "$WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "{
            \"msg_type\": \"interactive\",
            \"card\": {
                \"header\": {
                    \"title\": {\"tag\": \"plain_text\", \"content\": \"🟢 $title\"},
                    \"template\": \"green\"
                },
                \"elements\": [
                    {\"tag\": \"div\", \"content\": {\"tag\": \"lark_md\", \"content\": \"**项目**：$project\"}},
                    {\"tag\": \"div\", \"content\": {\"tag\": \"lark_md\", \"content\": \"**状态**：✅ $status\"}},
                    {\"tag\": \"div\", \"content\": {\"tag\": \"lark_md\", \"content\": \"**负责人**：$owner\"}},
                    {\"tag\": \"div\", \"content\": {\"tag\": \"lark_md\", \"content\": \"**时间**：$TIME\"}}
                ]
            }
        }"
}

# 使用示例
send_feishu "开发完成" "Budolist" "代码已提交 GitHub" "周小码"
```

---

## 六、CEO Agent 集成指南

### 6.1 在 SOUL.md 中添加触发

在 CEO Agent 的工作流程中，关键节点添加飞书通知：

```markdown
## 关键节点通知

### PRD 完成
1. CEO 确认 PRD 内容
2. **调用飞书通知 → 发送"PRD 待审核"消息**
3. 等待用户确认
4. 用户确认后 → **调用飞书通知 → 发送"PRD 已确认"消息**

### 开发完成
1. Developer 汇报完成
2. **调用飞书通知 → 发送"开发完成"消息**
3. 等待用户确认是否需要 Review
```

### 6.2 调用示例

```python
# 场景1：PRD 完成，需要用户确认
发送飞书通知(
    类型="待确认",
    标题="PRD 待审核",
    项目="Budolist",
    内容="PRD 文档已完成，请确认",
    负责人="周小产"
)

# 场景2：开发完成
发送飞书通知(
    类型="完成",
    标题="开发完成",
    项目="Budolist",
    状态="代码已提交 GitHub",
    交付物="code/budolist/",
    负责人="周小码"
)

# 场景3：遇到阻塞
发送飞书通知(
    类型="阻塞",
    标题="开发阻塞",
    项目="Budolist",
    问题="数据库连接失败",
    影响="无法完成用户模块开发",
    建议="需要配置正确的 Supabase 连接信息",
    负责人="周小码"
)
```

---

## 七、最佳实践

### 7.1 消息频率控制

| 场景 | 建议 |
|------|------|
| 正常开发 | 每天最多 5 条 |
| 紧急情况 | 随时发送 |
| 周期汇报 | 固定时间发送 |

### 7.2 消息内容原则

1. **简洁**：一句话说明重点
2. **可操作**：告诉用户需要做什么
3. **带上下文**：让用户快速了解背景
4. **标注负责人**：明确谁负责

### 7.3 错误处理

```python
try:
    response = requests.post(webhook_url, json=payload, timeout=10)
    if response.status_code != 200:
        print(f"⚠️ 飞书通知发送失败: {response.text}")
        # 记录到 memory/今日.md
except Exception as e:
    print(f"⚠️ 飞书通知异常: {e}")
    # 降级处理：只在当前对话通知
```

---

## 八、配置清单

> 创建此 Skill 时需要配置的内容

| 配置项 | 说明 | 必填 |
|--------|------|------|
| `FEISHU_WEBHOOK` | 飞书群 Webhook 地址 | ✅ |
| `FEISHU_BOT_NAME` | 机器人名称（可选） | ❌ |

### 配置方式

```bash
# 方式1：环境变量
export FEISHU_WEBHOOK="https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx"

# 方式2：配置文件
# 在 ~/.openclaw/ 配置文件中添加
feishu:
  webhook: "https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx"
```

---

## 九、版本历史

| 日期 | 版本 | 变更 |
|------|------|------|
| 2026-04-01 | v1.0 | 初始版本 |

---

*飞书通知 Skill · v1.0 · 2026-04-01*
