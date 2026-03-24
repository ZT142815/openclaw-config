# Supabase 使用指南

> Developer Agent 专用 - 每个新项目使用 Supabase 的完整流程

---

## 1. 环境配置

### 必需的环境变量

在 `~/.openclaw/.env` 中配置：

```bash
# Supabase Access Token (用于 CLI 操作)
SUPABASE_ACCESS_TOKEN=sbp_xxxxxxxxxxxxxxxxxxxx

# 项目级别的配置 (每个项目不同)
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_SERVICE_KEY=eyJxxxxx
```

### 获取 Supabase Access Token

1. 访问 https://supabase.com/dashboard/account/tokens
2. 创建新 token 或使用已有的 token
3. 将 token 添加到 `~/.openclaw/.env`

---

## 2. 项目操作

### 2.1 创建新项目

```bash
# 设置 token
export SUPABASE_ACCESS_TOKEN="your_token_here"

# 创建项目 (需要 org-id)
supabase projects create my-app \
  --org-id hyxsmxizqglteehkalae \
  --db-password "StrongPassword123!" \
  --region us-east-1
```

### 2.2 链接现有项目

```bash
# 在项目目录中链接
cd /path/to/project
supabase link --project-ref <project-ref> --password <db-password>
```

链接后会自动创建 `.supabase/config.toml` 配置文件。

### 2.3 获取项目 API Keys

```bash
# 获取项目 API Keys
supabase projects api-keys <project-ref>
```

返回：
- `anon` - 公开的匿名 key
- `service_role` - 服务端专用 key (绕过 RLS)
- `default` - 默认配置

---

## 3. 数据库操作

### 3.1 执行 SQL (通过 Dashboard)

由于 CLI 不支持直接执行 SQL，需要通过以下方式：

**方式 A: Supabase Dashboard**
1. 打开 https://supabase.com/dashboard
2. 选择项目 → SQL Editor
3. 粘贴并执行 SQL

**方式 B: 使用 service_role key 调用 REST API**
```bash
# 通过 Management API (需要项目 ID)
# 注意：直接执行 DDL 需要通过 Dashboard
```

### 3.2 推荐的工作流程

1. **开发时**：使用本地 Supabase (`supabase start`)
2. **部署时**：在 Dashboard SQL Editor 中执行 migration

---

## 4. Secrets 管理

### 4.1 列出 Secrets
```bash
supabase secrets list --project-ref <project-ref>
```

### 4.2 设置 Secret
```bash
supabase secrets set MY_SECRET=value --project-ref <project-ref>
```

### 4.3 删除 Secret
```bash
supabase secrets unset MY_SECRET --project-ref <project-ref>
```

---

## 5. Storage 操作

### 5.1 通过 REST API 管理

**创建 Bucket**
```bash
curl -X POST "https://<project-ref>.supabase.co/storage/v1/bucket" \
  -H "apikey: <service-role-key>" \
  -H "Authorization: Bearer <service-role-key>" \
  -H "Content-Type: application/json" \
  -d '{"name":"my-bucket","public":true}'
```

**上传文件**
```bash
curl -X POST "https://<project-ref>.supabase.co/storage/v1/object/bucket-name/file.jpg" \
  -H "apikey: <service-role-key>" \
  -H "Authorization: Bearer <service-role-key>" \
  --data-binary @file.jpg
```

---

## 6. Edge Functions

### 6.1 创建新 Function
```bash
supabase functions new my-function
```

### 6.2 部署 Function
```bash
supabase functions deploy my-function --project-ref <project-ref>
```

### 6.3 删除 Function
```bash
supabase functions delete my-function --project-ref <project-ref>
```

---

## 7. 常用项目 Reference

| 项目名 | Ref ID | Region |
|--------|--------|--------|
| test-agent-app | rizuncelbtvolxpiaebm | East US |

---

## 8. 代码集成示例

### Flutter/Dart
```dart
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://xxxxx.supabase.co',
    anonKey: 'eyJxxxxx-anon-key',
  );
}
```

### React/Vue (Web)
```javascript
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  'https://xxxxx.supabase.co',
  'eyJxxxxx-anon-key'
)
```

---

## 9. 注意事项

1. **不要在前端暴露 service_role key** - 只在后端使用
2. **使用 anon key + RLS** - 确保数据安全
3. **定期轮换 Secrets** - 特别是生产环境
4. **备份数据库** - 重要数据定期备份

---

> 文档更新时间: 2026-03-24
