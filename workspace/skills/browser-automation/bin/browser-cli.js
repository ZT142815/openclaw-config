#!/usr/bin/env node

const { chromium } = require('playwright');

async function main() {
  const args = process.argv.slice(2);
  const command = args[0];
  
  let browser;
  let page;
  
  try {
    // 启动带有调试端口的 Chrome
    browser = await chromium.launch({
      headless: false,
      args: ['--remote-debugging-port=9222']
    });
    
    const context = browser.contexts()[0];
    page = await context.newPage();
    
    switch (command) {
      case 'navigate':
        const url = args[1];
        if (url) {
          await page.goto(url, { waitUntil: 'networkidle' });
          console.log('✅ Navigated to:', url);
        }
        break;
        
      case 'click':
        const selector = args[1];
        if (selector) {
          await page.click(selector, { timeout: 10000 }).catch(() => {
            // 如果 selector 失败，尝试点击文本
            return page.getByText(selector).click();
          });
          console.log('✅ Clicked:', selector);
        }
        break;
        
      case 'type':
        const text = args.slice(1).join(' ');
        await page.keyboard.type(text);
        console.log('✅ Typed:', text);
        break;
        
      case 'screenshot':
        await page.screenshot({ path: args[1] || 'screenshot.png', fullPage: true });
        console.log('✅ Screenshot saved to:', args[1] || 'screenshot.png');
        break;
        
      case 'html':
        const html = await page.content();
        console.log(html);
        break;
        
      case 'evaluate':
        const script = args.slice(1).join(' ');
        const result = await page.evaluate(script);
        console.log(JSON.stringify(result, null, 2));
        break;
        
      case 'title':
        const title = await page.title();
        console.log('Page title:', title);
        break;
        
      case 'url':
        console.log('Current URL:', page.url());
        break;
        
      case 'waitForSelector':
        await page.waitForSelector(args[1], { timeout: 10000 });
        console.log('✅ Element found:', args[1]);
        break;
        
      case 'act':
        // 使用 page.act() 进行自然语言操作（需要 AI）
        const action = args.slice(1).join(' ');
        console.log('Action not supported without AI model');
        console.log('Use navigate/click/type commands instead');
        break;
        
      default:
        console.log('Available commands:');
        console.log('  browser navigate <url>');
        console.log('  browser click <selector>');
        console.log('  browser type <text>');
        console.log('  browser screenshot [path]');
        console.log('  browser html');
        console.log('  browser evaluate <js>');
        console.log('  browser title');
        console.log('  browser url');
    }
    
    // 不关闭浏览器，保持运行
    console.log('Browser is running on http://localhost:9222');
    
  } catch (error) {
    console.error('Error:', error.message);
    if (browser) await browser.close();
    process.exit(1);
  }
}

main();
