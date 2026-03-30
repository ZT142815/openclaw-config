# 📋 产品需求文档 (PRD) 模板

> **用途**: 供 Product Agent 使用
> **版本**: v1.0
> **说明**: 这是Product Agent编写需求文档的标准模板。每个项目都应该使用这个结构。

---

## 📝 文档填写说明

### ⚠️ 必填项
以下内容**必须完整填写**，不能为空：
- Vision & Objective
- User Stories (至少3个)
- Acceptance Criteria
- Data Model / API Design

### 📋 可选项
- Wireframes / Mockups (建议但不强制)
- Competitive Analysis (如果是新功能)
- Performance Requirements (如果有特殊需求)

---

# 【项目名】产品需求文档

> **文档ID**: PRD-YYYY-001
> **版本**: v1.0
> **编写日期**: YYYY-MM-DD
> **编写者**: Product Agent
> **最后更新**: YYYY-MM-DD
> **状态**: ✅ 完成 / ⏳ 进行中 / 🔴 待审批

---

## 1️⃣ 概览 (Overview)

### 1.1 项目简述

一句话描述这个项目：
> [用一句话简洁地说明这个项目是什么]

**示例**: "实现一个用户认证系统，支持邮箱注册、第三方登录和密码重置"

### 1.2 项目背景

**为什么要做这个项目？** (业务驱动)

- 背景1: [描述市场或业务的需求]
- 背景2: [用户反馈或竞争对手分析]
- 背景3: [公司的战略目标]

**示例**:
- 用户要求提供更安全的登录方式
- 竞争对手已支持谷歌/GitHub登录
- 公司计划拓展国际市场，需要多语言登录支持

### 1.3 目标用户

| 用户群体 | 描述 | 比例 |
|---------|------|------|
| 个人开发者 | 需要快速接入认证系统 | 60% |
| 企业用户 | 需要企业级安全和集成 | 30% |
| 第三方开发者 | 通过API接入 | 10% |

### 1.4 成功指标 (KPI)

项目完成后，我们如何衡量成功？

| 指标 | 目标 | 衡量方法 |
|------|------|----------|
| 用户注册转化率 | >= 5% | 分析系统数据 |
| 登录成功率 | >= 99.9% | 监控API可用性 |
| 用户满意度 | >= 4.0 / 5.0 | 用户调查 |
| 支持工单数 | < 10 / 1000用户 | 计算支持成本 |

---

## 2️⃣ 用户故事与需求 (User Stories & Requirements)

### 2.1 用户故事 (User Stories)

这是**最重要的部分**。每个用户故事包含：
- **Who**: 谁？(哪种用户)
- **What**: 想要什么？(什么功能)
- **Why**: 为什么？(什么收益)

#### 故事 1: 邮箱注册

```
作为: 新用户
我想要: 能够用邮箱地址和密码注册一个新账户
这样我就能: 立即开始使用应用程序

验收标准:
- [ ] 用户可以输入邮箱和密码
- [ ] 系统验证邮箱格式正确
- [ ] 系统验证密码强度 (至少8个字符)
- [ ] 系统发送确认邮件
- [ ] 用户点击邮件中的链接后账户激活
- [ ] 注册成功后自动登录
- [ ] 注册页面有"已有账号？登录"链接
```

#### 故事 2: 邮箱登录

```
作为: 已注册用户
我想要: 能够用邮箱和密码登录
这样我就能: 安全地访问我的账户

验收标准:
- [ ] 用户输入邮箱和密码
- [ ] 系统验证凭证是否正确
- [ ] 如果正确，用户被重定向到首页
- [ ] 如果错误，显示"邮箱或密码错误"(不要区分哪个错)
- [ ] 连续错误5次后，显示验证码
- [ ] 有"忘记密码？"链接
- [ ] 登录信息被安全地存储在会话中
```

#### 故事 3: 第三方登录 (Google)

```
作为: 用户
我想要: 能够用Google账户登录
这样我就能: 无需记住另一个密码

验收标准:
- [ ] 登录页面显示"使用Google登录"按钮
- [ ] 点击后跳转到Google OAuth流程
- [ ] 授权后，系统自动创建或更新用户
- [ ] 用户被重定向到首页
- [ ] 如果用户第一次用Google登录，提示"欢迎！请完成个人资料"
- [ ] 支持的Google账户语言: 中文、英文、日文
```

#### 故事 4: 密码重置

```
作为: 忘记密码的用户
我想要: 能够重置我的密码
这样我就能: 恢复对账户的访问

验收标准:
- [ ] 登录页面有"忘记密码？"链接
- [ ] 点击后进入"邮箱输入"页面
- [ ] 用户输入邮箱后，系统发送重置链接
- [ ] 显示"请检查您的邮箱"提示
- [ ] 用户收到邮件，点击链接进入"重置密码"页面
- [ ] 用户输入新密码（验证强度）
- [ ] 密码重置成功后，显示"密码已更新，请重新登录"
- [ ] 重置链接有效期为24小时
```

#### 故事 5: 个人资料完善

```
作为: 新用户
我想要: 完善我的个人资料 (昵称、头像)
这样我就能: 让其他用户认识我

验收标准:
- [ ] 用户可以设置昵称 (2-20字符)
- [ ] 用户可以上传头像 (JPG/PNG, <= 2MB)
- [ ] 系统自动裁剪头像为正方形
- [ ] 用户可以随时修改个人资料
- [ ] 所有修改立即保存
- [ ] 用户头像在应用各处显示一致
```

### 2.2 功能需求列表

| 功能 | 优先级 | 描述 | 依赖 |
|------|--------|------|------|
| 邮箱注册 | P0 | 用户能用邮箱+密码注册 | 无 |
| 邮箱登录 | P0 | 用户能用邮箱+密码登录 | 邮箱注册 |
| Google登录 | P1 | 用户能用Google账户登录 | 无 |
| GitHub登录 | P2 | 用户能用GitHub账户登录 | 无 |
| 密码重置 | P1 | 用户能重置忘记的密码 | 邮箱注册 |
| 个人资料 | P2 | 用户能完善昵称和头像 | 邮箱注册 |
| 两步验证 (2FA) | P3 | 用户能启用2FA提高安全性 | 邮箱登录 |

---

## 3️⃣ 数据模型 (Data Model)

### 3.1 ER 图 (Entity-Relationship Diagram)

```
┌─────────────────┐
│     users       │
├─────────────────┤
│ id (UUID)       │ PK
│ email (TEXT)    │ UNIQUE
│ password_hash   │
│ nickname        │
│ avatar_url      │
│ created_at      │
│ updated_at      │
└─────────────────┘
        │
        │ 1:N
        ├──────────────┐
        │              │
┌──────────────────┐  ┌──────────────────┐
│   sessions       │  │  oauth_accounts  │
├──────────────────┤  ├──────────────────┤
│ id (UUID)        │  │ id (UUID)        │
│ user_id (FK)     │  │ user_id (FK)     │
│ token (TEXT)     │  │ provider (TEXT)  │
│ expires_at       │  │ provider_id      │
│ created_at       │  │ email            │
└──────────────────┘  │ created_at       │
                      └──────────────────┘
```

### 3.2 表结构定义

#### 表 1: users (用户表)

```sql
CREATE TABLE IF NOT EXISTS public.users (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  email       TEXT        UNIQUE NOT NULL,
  password_hash TEXT,
  nickname    TEXT        DEFAULT '用户',
  avatar_url  TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 索引
CREATE INDEX idx_users_email ON public.users(email);
```

**字段说明**:

| 字段 | 类型 | 说明 | 约束 |
|------|------|------|------|
| id | UUID | 用户ID | PK |
| email | TEXT | 邮箱地址 | NOT NULL, UNIQUE |
| password_hash | TEXT | 密码哈希值 | 使用bcrypt |
| nickname | TEXT | 昵称 | 默认值 |
| avatar_url | TEXT | 头像URL | 可为空 |
| created_at | TIMESTAMPTZ | 创建时间 | 自动 |
| updated_at | TIMESTAMPTZ | 更新时间 | 自动 |

#### 表 2: sessions (会话表)

```sql
CREATE TABLE IF NOT EXISTS public.sessions (
  id        UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id   UUID        NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  token     TEXT        NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_sessions_user_id ON public.sessions(user_id);
CREATE INDEX idx_sessions_token ON public.sessions(token);
```

#### 表 3: oauth_accounts (第三方账户表)

```sql
CREATE TABLE IF NOT EXISTS public.oauth_accounts (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID        NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  provider    TEXT        NOT NULL,  -- 'google', 'github'
  provider_id TEXT        NOT NULL,
  email       TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  CONSTRAINT unique_oauth_account UNIQUE (provider, provider_id)
);

CREATE INDEX idx_oauth_accounts_user_id ON public.oauth_accounts(user_id);
CREATE INDEX idx_oauth_accounts_provider ON public.oauth_accounts(provider);
```

---

## 4️⃣ API 设计 (API Specification)

### 4.1 API 设计原则
- 使用 RESTful 风格
- 所有请求返回 JSON
- 错误统一格式: `{ "error": "错误信息", "code": "ERROR_CODE" }`
- 所有时间戳使用 ISO 8601 格式

### 4.2 认证方式
- 使用 JWT Token
- Token 包含在 `Authorization: Bearer <token>` 头中
- Token 有效期 7 天，可刷新

### 4.3 API 端点定义

#### 1. 注册

```http
POST /api/auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePassword123"
}

响应 (201 Created):
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "email": "user@example.com",
  "nickname": "用户",
  "avatar_url": null,
  "created_at": "2024-03-27T10:00:00Z"
}

错误响应 (400):
{
  "error": "邮箱已存在",
  "code": "EMAIL_ALREADY_EXISTS"
}
```

**请求参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| email | string | ✅ | 邮箱地址，必须有效 |
| password | string | ✅ | 密码，至少8个字符 |

**响应**:
- 201: 注册成功
- 400: 参数验证失败
- 409: 邮箱已存在

---

#### 2. 登录

```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePassword123"
}

响应 (200 OK):
{
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "user@example.com",
    "nickname": "用户",
    "avatar_url": null
  },
  "expires_in": 604800  // 7天，单位秒
}

错误响应 (401):
{
  "error": "邮箱或密码错误",
  "code": "INVALID_CREDENTIALS"
}
```

---

#### 3. Google 登录

```http
POST /api/auth/google
Content-Type: application/json

{
  "id_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjExIn0..."
}

响应 (200 OK):
{
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "user@gmail.com",
    "nickname": "John Doe",
    "avatar_url": "https://lh3.googleusercontent.com/..."
  },
  "is_new_user": false  // 是否是新用户
}
```

---

#### 4. 密码重置 - 第1步：发送重置邮件

```http
POST /api/auth/forgot-password
Content-Type: application/json

{
  "email": "user@example.com"
}

响应 (200 OK):
{
  "message": "重置链接已发送到您的邮箱"
}
```

---

#### 5. 密码重置 - 第2步：重置密码

```http
POST /api/auth/reset-password
Content-Type: application/json

{
  "reset_token": "token_from_email_link",
  "new_password": "NewPassword123"
}

响应 (200 OK):
{
  "message": "密码已更新，请重新登录"
}
```

---

#### 6. 获取当前用户信息

```http
GET /api/user
Authorization: Bearer <token>

响应 (200 OK):
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "email": "user@example.com",
  "nickname": "用户昵称",
  "avatar_url": "https://...",
  "created_at": "2024-03-27T10:00:00Z"
}

错误响应 (401):
{
  "error": "未授权",
  "code": "UNAUTHORIZED"
}
```

---

#### 7. 更新个人资料

```http
PATCH /api/user/profile
Authorization: Bearer <token>
Content-Type: application/json

{
  "nickname": "新昵称",
  "avatar_url": "https://..."
}

响应 (200 OK):
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "email": "user@example.com",
  "nickname": "新昵称",
  "avatar_url": "https://...",
  "updated_at": "2024-03-27T11:00:00Z"
}
```

---

#### 8. 登出

```http
POST /api/auth/logout
Authorization: Bearer <token>

响应 (200 OK):
{
  "message": "已登出"
}
```

---

### 4.4 错误码列表

| 错误码 | HTTP状态 | 说明 |
|--------|---------|------|
| EMAIL_ALREADY_EXISTS | 409 | 邮箱已注册 |
| INVALID_CREDENTIALS | 401 | 邮箱或密码错误 |
| INVALID_EMAIL_FORMAT | 400 | 邮箱格式不正确 |
| WEAK_PASSWORD | 400 | 密码强度不足 |
| UNAUTHORIZED | 401 | 未授权或Token无效 |
| TOKEN_EXPIRED | 401 | Token已过期 |
| INVALID_RESET_TOKEN | 400 | 重置链接无效或已过期 |
| INTERNAL_SERVER_ERROR | 500 | 服务器错误 |

---

## 5️⃣ 用户界面 (UI/UX)

### 5.1 页面流程

```
首页
 ├─ 点击"登录" → 登录页面
 │  ├─ 输入邮箱/密码 → 验证 → 首页
 │  ├─ "忘记密码?" → 重置密码页面
 │  └─ "使用Google登录" → Google OAuth → 首页
 │
 ├─ 点击"注册" → 注册页面
 │  ├─ 输入邮箱/密码 → 验证 → 确认邮件页面
 │  ├─ 点击邮件链接 → 账户激活 → 欢迎页面
 │  └─ 完善个人资料 → 首页
 │
 └─ 点击"个人资料" → 个人资料页面
    ├─ 编辑昵称、头像
    ├─ 查看账户信息
    └─ 登出
```

### 5.2 页面说明

#### 登录页面

```
┌─────────────────────────────────┐
│          欢迎回来！             │
├─────────────────────────────────┤
│                                 │
│  邮箱地址                       │
│  [________________]             │
│                                 │
│  密码                           │
│  [________________]             │
│  [ ] 记住我                     │
│                                 │
│  [登录]           [忘记密码?]   │
│                                 │
├─────────────────────────────────┤
│  ─────── 或 ───────             │
│  [Google 登录]                  │
│  [GitHub 登录]                  │
├─────────────────────────────────┤
│  还没有账号？ [立即注册]         │
└─────────────────────────────────┘
```

#### 注册页面

```
┌─────────────────────────────────┐
│       创建新账户                │
├─────────────────────────────────┤
│                                 │
│  邮箱地址                       │
│  [________________]             │
│  密码强度: ████░░░░░ 中         │
│                                 │
│  密码                           │
│  [________________]             │
│  确认密码                       │
│  [________________]             │
│  [ ] 我同意服务条款             │
│                                 │
│  [注册]                         │
│                                 │
├─────────────────────────────────┤
│  已有账号？ [立即登录]          │
└─────────────────────────────────┘
```

---

## 6️⃣ 非功能性需求 (Non-Functional Requirements)

### 6.1 性能要求

| 指标 | 目标 | 说明 |
|------|------|------|
| 登录响应时间 | < 200ms | P95延迟 |
| 注册响应时间 | < 500ms | P95延迟（包括邮件发送） |
| 邮件发送延迟 | < 10s | 注册确认邮件应在10秒内发送 |
| 系统可用性 | >= 99.9% | 平均故障恢复时间 < 5分钟 |

### 6.2 安全需求

| 需求 | 说明 |
|------|------|
| 密码加密 | 使用bcrypt进行密码哈希 (salt round >= 12) |
| HTTPS | 所有通信必须使用HTTPS |
| SQL注入防护 | 使用参数化查询 |
| XSS防护 | 输入数据进行转义 |
| CSRF防护 | 使用CSRF tokens |
| 密码强度 | 至少8个字符，必须包含大小写字母和数字 |
| Token有效期 | 7天，支持刷新 |
| 多次错误登录限制 | 5次错误后，需要验证码或等待15分钟 |

### 6.3 可扩展性需求

| 需求 | 说明 |
|------|------|
| 同时用户数 | 支持至少 10,000 并发用户 |
| 数据库 | 使用Supabase (PostgreSQL)，支持自动扩展 |
| 缓存 | 使用Redis缓存Token黑名单，减少数据库查询 |
| 日志 | 记录所有登录/注册事件，用于审计和分析 |

### 6.4 兼容性需求

| 项目 | 支持范围 |
|------|---------|
| 浏览器 | Chrome 90+, Firefox 88+, Safari 14+, Edge 90+ |
| 操作系统 | Windows 10+, macOS 10.15+, iOS 14+, Android 10+ |
| 响应式设计 | 支持桌面、平板、手机 |
| 国际化 | 支持中文、英文、日文 |

---

## 7️⃣ 上线检查清单 (Release Checklist)

在发布前，必须验证以下内容：

```
【功能检查】
- [ ] 所有P0功能都已实现并通过测试
- [ ] 所有P1功能都已实现并通过测试
- [ ] 邮件模板已本地化 (中文、英文)
- [ ] API文档已更新

【安全检查】
- [ ] 密码使用bcrypt加密
- [ ] HTTPS已配置
- [ ] SQL注入防护已验证
- [ ] XSS防护已验证
- [ ] CSRF防护已验证
- [ ] 敏感数据（密钥、Token）未硬编码

【性能检查】
- [ ] 登录响应时间 < 200ms
- [ ] 注册响应时间 < 500ms
- [ ] 数据库连接池已配置
- [ ] Redis缓存已启用

【测试检查】
- [ ] 单元测试覆盖率 >= 80%
- [ ] 集成测试全部通过
- [ ] 功能测试全部通过
- [ ] 兼容性测试通过
- [ ] 性能测试通过

【文档检查】
- [ ] API文档完整、示例正确
- [ ] 部署文档已准备
- [ ] 故障恢复文档已准备
- [ ] 用户帮助文档已准备

【上线前】
- [ ] 数据库备份已验证
- [ ] 监控和告警已配置
- [ ] 灰度发布计划已制定 (10% → 50% → 100%)
- [ ] 回滚方案已准备
- [ ] 团队培训已完成
```

---

## 📚 附录

### A. 参考文档

- 🔗 [Supabase 数据库操作](../developer/agent/skills/SUPABASE.md)
- 🔗 [测试方案](../tester/agent/skills/TEST-PLAN-TEMPLATE.md)
- 🔗 [API设计最佳实践](https://restfulapi.net/)

### B. 常见问题

**Q: 如何处理第三方登录的新用户？**
A: 如果用户第一次用Google/GitHub登录，系统自动创建账户，然后跳转到"完善资料"页面，要求用户设置昵称。

**Q: 密码重置邮件如何防止被拦截？**
A: 使用SendGrid或Mailgun等专业邮件服务，配置SPF/DKIM/DMARC提高投递率。重置链接包含有效期和一次性token。

**Q: 如何处理邮件发送失败？**
A: 如果发送失败，存储在数据库中标记为"待发送"，后台任务每5分钟重试一次，最多重试3次。用户可以手动点击"重新发送"。

---

**文档版本**: 1.0
**最后更新**: 2026-03-27
**维护者**: Product Agent
