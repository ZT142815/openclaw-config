#!/usr/bin/env python3
"""
飞书通知示例 - Python 实现

使用前请先设置环境变量：
export FEISHU_WEBHOOK="https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx"
"""

import os
import requests
import json
from datetime import datetime


class FeishuNotifier:
    """飞书通知器"""
    
    def __init__(self, webhook_url: str):
        self.webhook_url = webhook_url
    
    def send(self, message_type: str, **kwargs):
        """发送飞书消息"""
        
        templates = {
            "待确认": self._template_pending,
            "完成": self._template_complete,
            "日报": self._template_daily,
            "周报": self._template_weekly,
            "阻塞": self._template_blocked,
            "立项": self._template_launch,
            "里程碑": self._template_milestone,
            "发布": self._template_release
        }
        
        template = templates.get(message_type, templates["完成"])
        payload = template(**kwargs)
        
        try:
            response = requests.post(
                self.webhook_url,
                headers={"Content-Type": "application/json"},
                data=json.dumps(payload),
                timeout=10
            )
            
            result = response.json()
            if result.get("code") == 0:
                print(f"✅ 飞书通知发送成功")
                return True
            else:
                print(f"⚠️ 飞书通知发送失败: {result.get('msg')}")
                return False
                
        except Exception as e:
            print(f"⚠️ 飞书通知异常: {e}")
            return False
    
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
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**时间**：{kwargs.get('time', datetime.now().strftime('%Y-%m-%d %H:%M'))}"}}
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
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**完成时间**：{kwargs.get('time', datetime.now().strftime('%Y-%m-%d %H:%M'))}"}}
                ]
            }
        }
    
    def _template_blocked(self, **kwargs):
        """阻塞模板"""
        return {
            "msg_type": "interactive",
            "card": {
                "header": {
                    "title": {"tag": "plain_text", "content": f"⚠️ {kwargs.get('title', '任务阻塞')}"},
                    "template": "orange"
                },
                "elements": [
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**问题描述**：{kwargs.get('problem', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**影响范围**：{kwargs.get('impact', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**建议措施**：{kwargs.get('suggestion', '')}"}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**负责人**：{kwargs.get('owner', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**时间**：{kwargs.get('time', datetime.now().strftime('%Y-%m-%d %H:%M'))}"}}
                ]
            }
        }
    
    def _template_daily(self, **kwargs):
        """日报模板"""
        return {
            "msg_type": "interactive",
            "card": {
                "header": {
                    "title": {"tag": "plain_text", "content": f"📋 {kwargs.get('date', datetime.now().strftime('%Y-%m-%d'))} 日报"},
                    "template": "grey"
                },
                "elements": [
                    {"tag": "div", "content": {"tag": "lark_md", "content": "**今日完成**"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": kwargs.get('completed', '暂无')}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": "**进行中**"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": kwargs.get('in_progress', '暂无')}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": "**明日计划**"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": kwargs.get('tomorrow', '暂无')}}
                ]
            }
        }
    
    def _template_launch(self, **kwargs):
        """立项模板"""
        return {
            "msg_type": "interactive",
            "card": {
                "header": {
                    "title": {"tag": "plain_text", "content": f"🚀 {kwargs.get('title', '项目立项')}"},
                    "template": "purple"
                },
                "elements": [
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**项目名称**：{kwargs.get('project', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**项目目标**：{kwargs.get('goal', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**负责人**：{kwargs.get('owner', '')}"}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**计划里程碑**：{kwargs.get('milestones', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**立项时间**：{kwargs.get('time', datetime.now().strftime('%Y-%m-%d %H:%M'))}"}}
                ]
            }
        }
    
    def _template_milestone(self, **kwargs):
        """里程碑模板"""
        return {
            "msg_type": "interactive",
            "card": {
                "header": {
                    "title": {"tag": "plain_text", "content": f"🏆 {kwargs.get('title', '里程碑达成')}"},
                    "template": "gold"
                },
                "elements": [
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**项目**：{kwargs.get('project', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**里程碑**：{kwargs.get('milestone', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**完成状态**：✅ {kwargs.get('status', '')}"}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**负责人**：{kwargs.get('owner', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**达成时间**：{kwargs.get('time', datetime.now().strftime('%Y-%m-%d %H:%M'))}"}}
                ]
            }
        }
    
    def _template_release(self, **kwargs):
        """发布模板"""
        return {
            "msg_type": "interactive",
            "card": {
                "header": {
                    "title": {"tag": "plain_text", "content": f"🎉 {kwargs.get('title', '版本发布')}"},
                    "template": "green"
                },
                "elements": [
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**项目**：{kwargs.get('project', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**版本**：{kwargs.get('version', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**发布说明**：{kwargs.get('release_note', '')}"}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**负责人**：{kwargs.get('owner', '')}"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": f"**发布时间**：{kwargs.get('time', datetime.now().strftime('%Y-%m-%d %H:%M'))}"}}
                ]
            }
        }
    
    def _template_weekly(self, **kwargs):
        """周报模板"""
        return {
            "msg_type": "interactive",
            "card": {
                "header": {
                    "title": {"tag": "plain_text", "content": f"📊 {kwargs.get('week', datetime.now().strftime('%Y-W%W'))} 周报"},
                    "template": "blue"
                },
                "elements": [
                    {"tag": "div", "content": {"tag": "lark_md", "content": "**本周完成**"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": kwargs.get('completed', '暂无')}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": "**下周计划**"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": kwargs.get('next_week', '暂无')}},
                    {"tag": "hr"},
                    {"tag": "div", "content": {"tag": "lark_md", "content": "**风险与问题**"}},
                    {"tag": "div", "content": {"tag": "lark_md", "content": kwargs.get('risks', '暂无')}}
                ]
            }
        }


# ==================== 使用示例 ====================

if __name__ == "__main__":
    # 获取 Webhook URL
    webhook_url = os.environ.get("FEISHU_WEBHOOK")
    
    if not webhook_url:
        print("⚠️ 请先设置 FEISHU_WEBHOOK 环境变量")
        print("export FEISHU_WEBHOOK='https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx'")
        exit(1)
    
    notifier = FeishuNotifier(webhook_url)
    
    # 示例1：发送完成通知
    print("\n📤 发送完成通知...")
    notifier.send("完成",
        title="开发完成",
        project="Budolist",
        status="代码已提交 GitHub",
        deliverable="code/budolist/",
        owner="周小码"
    )
    
    # 示例2：发送待确认通知
    print("\n📤 发送待确认通知...")
    notifier.send("待确认",
        title="PRD 待审核",
        project="Budolist",
        content="PRD 文档已完成，请确认",
        owner="周小产"
    )
    
    # 示例3：发送阻塞通知
    print("\n📤 发送阻塞通知...")
    notifier.send("阻塞",
        title="开发阻塞",
        project="Budolist",
        problem="数据库连接失败",
        impact="无法完成用户模块开发",
        suggestion="需要配置正确的 Supabase 连接信息",
        owner="周小码"
    )
    
    # 示例4：发送日报
    print("\n📤 发送日报...")
    notifier.send("日报",
        date="2026-04-01",
        completed="• Budolist v2.2.1 开发完成\n• 记忆系统重构",
        in_progress="• MoodTask 市场调研（5%）",
        tomorrow="• Budolist 真机验收"
    )
    
    print("\n✅ 所有示例发送完成")
