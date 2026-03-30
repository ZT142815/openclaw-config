# 测试执行指南

> **版本**: v1.0
> **更新日期**: 2026-03-29

---

## 一、接口测试执行

### 1.1 测试 Supabase 连接

```bash
# 获取项目配置
SUPABASE_URL="https://<project>.supabase.co"
ANON_KEY="<ANON_KEY>"

# 测试连接
curl -X GET "${SUPABASE_URL}/rest/v1/" \
  -H "apikey: ${ANON_KEY}"
```

### 1.2 测试用户注册

```bash
curl -X POST "${SUPABASE_URL}/auth/v1/signup" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -H "Prefer: return=representation" \
  -d '{
    "email": "test_'"$(date +%Y%m%d_%H%M%S)"'@example.com",
    "password": "Test123456"
  }'
```

### 1.3 测试用户登录

```bash
curl -X POST "${SUPABASE_URL}/auth/v1/token?grant_type=password" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "Test123456"
  }'
```

### 1.4 测试业务接口

```bash
# 获取 token 后
ACCESS_TOKEN="<access_token>"

# 创建资源
curl -X POST "${SUPABASE_URL}/rest/v1/items" \
  -H "apikey: ${ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -H "Prefer: return=representation" \
  -d '{
    "name": "测试物品",
    "description": "测试描述"
  }'

# 查询资源
curl -X GET "${SUPABASE_URL}/rest/v1/items" \
  -H "apikey: ${ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}"
```

---

## 二、页面测试执行

### 2.1 启动 Appium

```bash
# 检查 Appium 是否运行
ps aux | grep appium

# 启动 Appium（如果未运行）
appium --address 127.0.0.1 --port 4723 &
```

### 2.2 启动 iOS 模拟器

```bash
# 列出可用设备
xcrun simctl list devices available

# 启动模拟器
xcrun simctl boot "iPhone 15 Pro"

# 打开模拟器
open -a Simulator
```

### 2.3 运行 Flutter 集成测试

```bash
# 进入项目目录
cd ~/.openclaw/projects/<项目名>/code/frontend

# 运行集成测试
flutter test integration_test/app_test.dart
```

---

## 三、截图管理

### 3.1 创建截图目录

```bash
mkdir -p docs/截图
mkdir -p docs/BUG截图
```

### 3.2 截图命名

```
接口测试：TC-API-XXX-描述.png
页面测试：TC-UI-XXX-描述.png
BUG 截图：BUG-XXX-序号.png
```

---

## 四、SHA1 验证

### 4.1 验证命令

```bash
cd ~/.openclaw/projects/<项目名>/docs/截图
shasum *.png
```

### 4.2 验证规则

- 不同页面的截图 SHA1 必须不同
- 相同 = 测试造假 = 测试失败

---

## 五、测试数据清理

### 5.1 清理测试账号

```bash
# 删除测试账号
curl -X DELETE "${SUPABASE_URL}/rest/v1/auth/users" \
  -H "apikey: ${ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json"
```

### 5.2 清理测试数据

```bash
# 删除测试数据
curl -X DELETE "${SUPABASE_URL}/rest/v1/items" \
  -H "apikey: ${ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d 'email=like.test_%@example.com'
```

---

## 六、常见问题处理

### 6.1 Appium 连接失败

```bash
# 重启 Appium
pkill -f appium
appium &
```

### 6.2 模拟器无法启动

```bash
# 重置模拟器
xcrun simctl erase all
xcrun simctl boot "iPhone 15 Pro"
```

---

> **维护记录**：
> - 2026-03-29 v1.0 初始版本
