#!/bin/bash
#
# 飞书通知示例 - Shell 实现
#
# 使用前请先设置环境变量：
# export FEISHU_WEBHOOK="https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx"
#

# 检查环境变量
if [ -z "$FEISHU_WEBHOOK" ]; then
    echo "⚠️ 请先设置 FEISHU_WEBHOOK 环境变量"
    echo "export FEISHU_WEBHOOK='https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx'"
    exit 1
fi

WEBHOOK_URL="$FEISHU_WEBHOOK"
TIME=$(date "+%Y-%m-%d %H:%M")

# 发送飞书消息
send_feishu() {
    local title="$1"
    local template="$2"
    local project="${3:-}"
    local status="${4:-}"
    local owner="${5:-}"
    local content="${6:-}"
    local deliverable="${7:-}"
    
    case "$template" in
        "pending")
            payload=$(cat <<EOF
{
    "msg_type": "interactive",
    "card": {
        "header": {
            "title": {"tag": "plain_text", "content": "🔵 ${title}"},
            "template": "blue"
        },
        "elements": [
            {"tag": "div", "content": {"tag": "lark_md", "content": "**项目**：${project}"}},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**内容**：${content}"}},
            {"tag": "hr"},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**负责人**：${owner}"}},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**时间**：${TIME}"}}
        ]
    }
}
EOF
)
            ;;
        "complete")
            payload=$(cat <<EOF
{
    "msg_type": "interactive",
    "card": {
        "header": {
            "title": {"tag": "plain_text", "content": "🟢 ${title}"},
            "template": "green"
        },
        "elements": [
            {"tag": "div", "content": {"tag": "lark_md", "content": "**项目**：${project}"}},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**状态**：✅ ${status}"}},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**交付物**：${deliverable}"}},
            {"tag": "hr"},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**负责人**：${owner}"}},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**完成时间**：${TIME}"}}
        ]
    }
}
EOF
)
            ;;
        "blocked")
            payload=$(cat <<EOF
{
    "msg_type": "interactive",
    "card": {
        "header": {
            "title": {"tag": "plain_text", "content": "⚠️ ${title}"},
            "template": "orange"
        },
        "elements": [
            {"tag": "div", "content": {"tag": "lark_md", "content": "**问题**：${content}"}},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**状态**：${status}"}},
            {"tag": "hr"},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**负责人**：${owner}"}},
            {"tag": "div", "content": {"tag": "lark_md", "content": "**时间**：${TIME}"}}
        ]
    }
}
EOF
)
            ;;
        *)
            echo "⚠️ 未知模板类型: $template"
            return 1
            ;;
    esac
    
    # 发送请求
    response=$(curl -s -X POST "$WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "$payload")
    
    # 检查响应
    if echo "$response" | grep -q '"code":0'; then
        echo "✅ 飞书通知发送成功"
        return 0
    else
        echo "⚠️ 飞书通知发送失败: $response"
        return 1
    fi
}

# ==================== 使用示例 ====================

echo "📤 发送示例..."

# 示例1：发送完成通知
echo ""
echo "1️⃣ 发送完成通知..."
send_feishu "开发完成" "complete" \
    "Budolist" \
    "代码已提交 GitHub" \
    "周小码" \
    "" \
    "code/budolist/"

# 示例2：发送待确认通知
echo ""
echo "2️⃣ 发送待确认通知..."
send_feishu "PRD 待审核" "pending" \
    "Budolist" \
    "" \
    "周小产" \
    "PRD 文档已完成，请确认"

# 示例3：发送阻塞通知
echo ""
echo "3️⃣ 发送阻塞通知..."
send_feishu "开发阻塞" "blocked" \
    "Budolist" \
    "数据库连接失败，无法继续" \
    "周小码" \
    "需要配置 Supabase 连接信息"

echo ""
echo "✅ 所有示例发送完成"
