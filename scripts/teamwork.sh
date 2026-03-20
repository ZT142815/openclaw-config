#!/bin/bash
# OpenClaw 多Agent协作工作流

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

# 日志函数
ceo() { echo -e "${BLUE}[CEO]${NC} \$1"; }
success() { echo -e "${GREEN}[✓]${NC} \$1"; }

# 显示菜单
show_menu() {
    echo ""
    echo "╔═══════════════════════════════════════════╗"
    echo "║     OpenClaw 多Agent协作工作流          ║"
    echo "╠═══════════════════════════════════════════╣"
    echo "║  1. 完整流程 (需求→开发→测试)          ║"
    echo "║  2. 仅需求分析 (Product)                 ║"
    echo "║  3. 仅代码开发 (Developer)              ║"
    echo "║  4. 仅测试验证 (Tester)                 ║"
    echo "║  5. BUG修复流程                         ║"
    echo "║  0. 退出                                ║"
    echo "╚═══════════════════════════════════════════╝"
    echo ""
}

# 完整流程
full_flow() {
    local task="\$1"
    [ -z "$task" ] && read -p "请输入任务描述: " task
    
    ceo "收到任务: $task"
    echo ""
    
    # 阶段1：Product
    ceo "→ 调度 Product Agent 进行需求分析..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    openclaw agent --agent product -m "分析需求并编写PRD: $task"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    read -p "PRD确认后按回车继续..."
    
    # 阶段2：Developer
    ceo "→ 调度 Developer Agent 进行开发..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    openclaw agent --agent developer -m "根据需求开发代码: $task"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    read -p "代码确认后按回车继续..."
    
    # 阶段3：Tester
    ceo "→ 调度 Tester Agent 进行测试..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    openclaw agent --agent tester -m "测试开发完成的代码: $task"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    success "完整流程结束!"
}

# 单独调用
call_product() {
    read -p "请输入需求: " task
    openclaw agent --agent product -m "$task"
}

call_developer() {
    read -p "请输入开发任务: " task
    openclaw agent --agent developer -m "$task"
}

call_tester() {
    read -p "请输入测试任务: " task
    openclaw agent --agent tester -m "$task"
}

# BUG修复流程
bug_fix() {
    read -p "请描述BUG: " bug
    
    ceo "→ Developer 修复BUG..."
    openclaw agent --agent developer -m "修复以下BUG: $bug"
    
    echo ""
    read -p "修复后按回车让Tester复测..."
    
    ceo "→ Tester 复测验证..."
    openclaw agent --agent tester -m "复测验证: $bug"
    
    success "BUG修复流程结束!"
}

# 主程序
case "\$1" in
    1|full) shift; full_flow "$*" ;;
    2|product) call_product ;;
    3|develop|dev) call_developer ;;
    4|test) call_tester ;;
    5|bug) bug_fix ;;
    *) show_menu; read -p "选择: " choice; \$0 $choice "\$2" ;;
esac
