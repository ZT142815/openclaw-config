#!/usr/bin/env python3
"""
每日工作自动保存脚本
在每天 20:00 执行，询问 AI 今天完成了什么工作
"""

import os
from datetime import datetime

MEMORY_DIR = os.path.expanduser("~/.openclaw/memory")
WORK_FILE = os.path.join(MEMORY_DIR, "daily_work.md")

def save_daily_work(date_str, work_content):
    """保存每日工作"""
    with open(WORK_FILE, 'w', encoding='utf-8') as f:
        f.write(f"# {date_str} 工作记录\n\n")
        f.write(work_content)
    print(f"✅ 已保存到 {WORK_FILE}")

def main():
    date_str = datetime.now().strftime("%Y-%m-%d")
    work_content = input(f"请输入今天 ({date_str}) 完成的工作：\n")
    
    problems = input("遇到的问题（可选，直接回车跳过）：\n")
    tomorrow = input("明天计划（可选，直接回车跳过）：\n")
    
    content = f"## 今日完成\n{work_content}\n\n"
    
    if problems:
        content += f"## 遇到的问题\n{problems}\n\n"
    
    if tomorrow:
        content += f"## 明日计划\n{tomorrow}\n\n"
    
    save_daily_work(date_str, content)

if __name__ == "__main__":
    main()
