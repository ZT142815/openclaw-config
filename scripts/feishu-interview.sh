#!/bin/bash
# 飞书群通知脚本 - 面试群专用

CONFIG_FILE="$HOME/.openclaw/config/feishu-interview.json"

# 读取所有参数并合并成一条消息
MESSAGE=""
while [ $# -gt 0 ]; do
    if [ -z "$MESSAGE" ]; then
        MESSAGE="$1"
    else
        MESSAGE="$MESSAGE"$'\n'"$1"
    fi
    shift
done

if [ -z "$MESSAGE" ]; then
    echo "用法: $0 \"消息第1行\" \"消息第2行\" ..."
    exit 1
fi

python3 -c "
import json
import subprocess
import os

CONFIG_FILE = os.path.expanduser('$CONFIG_FILE')
with open(CONFIG_FILE) as f:
    config = json.load(f)

chat_id = config['chat_id']
app_id = config['app_id']
app_secret = config['app_secret']

# 获取 token
result = subprocess.run([
    'curl', '-s', '-X', 'POST',
    'https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal',
    '-H', 'Content-Type: application/json',
    '-d', json.dumps({'app_id': app_id, 'app_secret': app_secret})
], capture_output=True, text=True)

token = json.loads(result.stdout)['tenant_access_token']

# 发送消息
data = {
    'receive_id': chat_id,
    'msg_type': 'text', 
    'content': json.dumps({'text': '''$MESSAGE'''})
}

result = subprocess.run([
    'curl', '-s', '-X', 'POST',
    'https://open.feishu.cn/open-apis/im/v1/messages?receive_id_type=chat_id',
    '-H', f'Authorization: Bearer {token}',
    '-H', 'Content-Type: application/json',
    '-d', json.dumps(data)
], capture_output=True, text=True)

response = json.loads(result.stdout)
if response.get('code') == 0:
    print('已发送消息到面试群')
else:
    print('发送失败:', response)
"
