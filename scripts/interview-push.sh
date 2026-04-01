#!/bin/bash
# 面试题推送脚本 - AI实时生成随机前端面试题

CONFIG_FILE="$HOME/.openclaw/config/feishu-notify.json"
TIME=$(date "+%Y-%m-%d %H:%M")

# 获取 token
python3 -c "
import json
import subprocess
import os

CONFIG_FILE = os.path.expanduser('$CONFIG_FILE')
with open(CONFIG_FILE) as f:
    config = json.load(f)

app_id = config['app_id']
app_secret = config['app_secret']
chat_id = 'oc_50106962c3cef1cfd7e0e77bb4e6fb7e'

# 获取 token
result = subprocess.run([
    'curl', '-s', '-X', 'POST',
    'https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal',
    '-H', 'Content-Type: application/json',
    '-d', json.dumps({'app_id': app_id, 'app_secret': app_secret})
], capture_output=True, text=True)

token = json.loads(result.stdout)['tenant_access_token']

# 构建面试题生成提示
prompt = '''你是一位资深前端面试官。请出一道中高级前端面试题，要求：

1. 随机选择以下方向之一：JavaScript、CSS、HTML、React、浏览器原理、计算机网络、性能优化、TypeScript
2. 题目要贴合实际面试场景
3. 必须包含【详细解析】（10行以上，越详细越好）
4. 如果是手写题或代码题，要给出完整答案

请严格按以下格式输出（不要加任何前缀，直接输出内容）：

【方向】：xxx
【题目】：xxx
【解析】：
xxx
xxx
...（至少10行）

'''

# 发送消息给 AI 生成面试题
data = {
    'receive_id': chat_id,
    'msg_type': 'text',
    'content': json.dumps({'text': '🤖 AI 面试题生成中，请稍候...' })
}

subprocess.run([
    'curl', '-s', '-X', 'POST',
    'https://open.feishu.cn/open-apis/im/v1/messages?receive_id_type=chat_id',
    '-H', f'Authorization: Bearer {token}',
    '-H', 'Content-Type: application/json',
    '-d', json.dumps(data)
])

print('已发送生成中消息')
"
