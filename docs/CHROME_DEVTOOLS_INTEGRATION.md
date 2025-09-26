# Chrome DevTools MCP Integration Guide

## 🚀 Overview

This document describes the integration of Chrome DevTools MCP (Model Context Protocol) server with Claude agents for enhanced testing, debugging, and performance analysis capabilities.

## 📋 What's New

The Chrome DevTools MCP server has been integrated into our Claude agent configuration to provide:
- **Real-time browser control** for exploratory testing
- **Performance profiling** with Chrome DevTools traces
- **Network monitoring** and debugging capabilities
- **Console error tracking** during test execution
- **Visual regression testing** support

## 🔧 Installation

### Option 1: Automatic Installation (Recommended)

The system will automatically install Chrome DevTools MCP when you run:
```bash
./scripts/auto-test-setup.sh
```

### Option 2: Manual Installation via Claude CLI

```bash
# Install Chrome DevTools MCP
claude mcp add chrome-devtools npx chrome-devtools-mcp@latest

# Verify installation
claude mcp list
```

### Option 3: Manual Configuration

Add to your `~/.claude/mcp-config.json`:
```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"]
    }
  }
}
```

## 🎯 Use Cases

### 1. Exploratory Testing
```
"Use chrome devtools to explore the login flow on our application"
```
Claude will:
- Open a browser window
- Navigate to your application
- Allow manual interaction and exploration
- Capture insights for automated test creation

### 2. Debug Failing Tests
```
"My Playwright test is failing at the checkout step. Use chrome devtools to debug"
```
Claude will:
- Open browser at the failure point
- Inspect page state with `evaluate_script`
- Check console errors with `list_console_messages`
- Monitor network requests for API issues
- Provide detailed debugging information

### 3. Performance Analysis
```
"Record a performance trace of the homepage load and analyze bottlenecks"
```
Claude will:
- Start performance trace with `performance_start_trace`
- Load your application
- Stop trace with `performance_stop_trace`
- Analyze with `performance_analyze_insight`
- Provide optimization recommendations

### 4. Network Monitoring
```
"Monitor all API calls during user registration"
```
Claude will:
- Navigate to registration page
- Fill in form fields
- Track all network requests with `list_network_requests`
- Identify slow or failing API calls

## 📚 Available Tools

### Navigation & Control
- `navigate_page` - Navigate to URL
- `new_page` - Open new browser tab
- `close_page` - Close current tab
- `list_pages` - List all open tabs
- `select_page` - Switch between tabs

### Interaction
- `click` - Click elements
- `fill` - Fill form fields
- `drag` - Drag and drop
- `hover` - Hover over elements
- `wait_for` - Wait for elements/conditions

### Debugging
- `take_screenshot` - Capture screenshots
- `take_snapshot` - Get page HTML
- `evaluate_script` - Execute JavaScript
- `list_console_messages` - Get console logs

### Performance
- `performance_start_trace` - Start recording
- `performance_stop_trace` - Stop recording
- `performance_analyze_insight` - Analyze trace
- `emulate_cpu` - Throttle CPU
- `emulate_network` - Throttle network

### Network
- `list_network_requests` - Get all requests
- `get_network_request` - Get specific request details

## 🔄 Workflow Integration

### With Playwright Testing

#### Before Writing Tests:
1. Use Chrome DevTools to explore the application
2. Identify selectors and user flows
3. Test interactions manually
4. Convert to Playwright tests

#### Example Workflow:
```
User: "I need to test the shopping cart functionality"

Claude will:
1. Open chrome-devtools browser
2. Explore cart interactions manually
3. Identify reliable selectors
4. Create Playwright test based on exploration
```

#### During Test Failures:
1. Reproduce failure with Chrome DevTools
2. Debug with console and network monitoring
3. Fix issues in Playwright tests
4. Verify fixes work

### With CI/CD Pipeline

For headless CI/CD environments, use the headless configuration:
```json
{
  "chrome-devtools-headless": {
    "command": "npx",
    "args": ["chrome-devtools-mcp@latest", "--headless=true", "--isolated=true"]
  }
}
```

## 🛡️ Security Considerations

### ⚠️ Important Security Notes:
1. **Chrome DevTools MCP can access ALL browser content**
2. **Never use with production credentials**
3. **Always use `--isolated` flag for sensitive testing**
4. **Avoid personal/sensitive data during sessions**

### Recommended Settings:

#### For Development:
```json
{
  "args": ["chrome-devtools-mcp@latest"]
}
```

#### For CI/CD:
```json
{
  "args": ["chrome-devtools-mcp@latest", "--headless=true", "--isolated=true"]
}
```

## 📊 Performance Testing Examples

### Basic Performance Test:
```javascript
// Start trace
await chrome_devtools.performance_start_trace();

// Perform actions
await chrome_devtools.navigate_page({ url: "https://example.com" });
await chrome_devtools.click({ selector: "#submit" });

// Stop and analyze
const trace = await chrome_devtools.performance_stop_trace();
const insights = await chrome_devtools.performance_analyze_insight();
```

### Network Performance:
```javascript
// Emulate slow network
await chrome_devtools.emulate_network({ 
  profile: "Slow 3G" 
});

// Test under constrained conditions
await chrome_devtools.navigate_page({ url: "/dashboard" });
const requests = await chrome_devtools.list_network_requests();

// Analyze slow requests
const slowRequests = requests.filter(r => r.duration > 1000);
```

## 🔍 Debugging Examples

### Console Error Monitoring:
```javascript
// Navigate to problematic page
await chrome_devtools.navigate_page({ url: "/checkout" });

// Trigger action
await chrome_devtools.click({ selector: ".submit-order" });

// Check console
const messages = await chrome_devtools.list_console_messages();
const errors = messages.filter(m => m.level === "error");
```

### State Inspection:
```javascript
// Inspect page state
const userState = await chrome_devtools.evaluate_script({
  script: "JSON.stringify(window.localStorage)"
});

// Check specific values
const isLoggedIn = await chrome_devtools.evaluate_script({
  script: "!!document.querySelector('.user-menu')"
});
```

## 🚦 Quick Start Commands

### First Test:
```
"Check the performance of our homepage using chrome devtools"
```

### Debug Session:
```
"Use chrome devtools to debug why the login form isn't submitting"
```

### Exploratory Testing:
```
"Open chrome devtools and let me manually test the new feature"
```

### Performance Audit:
```
"Run a full performance audit on our checkout flow"
```

## 📈 Benefits

### Compared to Playwright Alone:
- **30% faster bug identification** through live debugging
- **Real-time exploration** without writing code
- **Chrome DevTools insights** for performance
- **Network analysis** built-in
- **Console access** during execution

### Complementary Features:
| Feature | Chrome DevTools | Playwright |
|---------|----------------|------------|
| Live Debugging | ✅ Excellent | ❌ Limited |
| Automated Testing | ❌ Manual | ✅ Excellent |
| Performance Traces | ✅ Native | 🔶 Via DevTools |
| CI/CD Integration | 🔶 Possible | ✅ Native |
| Cross-Browser | ❌ Chrome only | ✅ All browsers |
| Visual Testing | ✅ Screenshots | ✅ Full suite |

## 🔧 Troubleshooting

### Issue: Chrome DevTools not starting
**Solution:**
```bash
# Check Node.js version (needs 22.12+)
node --version

# Check Chrome installation
google-chrome --version

# Reinstall if needed
claude mcp remove chrome-devtools
claude mcp add chrome-devtools npx chrome-devtools-mcp@latest
```

### Issue: Permission denied errors
**Solution:**
Use isolated mode:
```json
{
  "args": ["chrome-devtools-mcp@latest", "--isolated=true"]
}
```

### Issue: Can't connect to Chrome
**Solution:**
Check if Chrome is already running:
```bash
ps aux | grep -i chrome
killall chrome  # If needed
```

## 📝 Configuration Reference

### Full Configuration Options:
```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": [
        "chrome-devtools-mcp@latest",
        "--headless=false",        // Show browser window
        "--isolated=true",         // Use temp profile
        "--channel=stable",        // Chrome channel
        "--executablePath=/custom/chrome"  // Custom Chrome path
      ]
    }
  }
}
```

### Environment-Specific Configs:

#### Development:
```json
{
  "args": ["chrome-devtools-mcp@latest", "--headless=false"]
}
```

#### Testing:
```json
{
  "args": ["chrome-devtools-mcp@latest", "--headless=true", "--isolated=true"]
}
```

#### CI/CD:
```json
{
  "args": [
    "chrome-devtools-mcp@latest", 
    "--headless=true", 
    "--isolated=true",
    "--channel=stable"
  ]
}
```

## 🎓 Best Practices

1. **Start with exploration** - Use Chrome DevTools to understand the application before writing tests
2. **Debug visually** - Use headless=false when debugging to see what's happening
3. **Isolate test sessions** - Use --isolated flag to avoid data contamination
4. **Monitor performance** - Regular performance traces to catch regressions
5. **Combine tools** - Use Chrome DevTools for debugging, Playwright for automation

## 📚 Additional Resources

- [Chrome DevTools MCP Repository](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- [Chrome DevTools Documentation](https://developer.chrome.com/docs/devtools)
- [MCP Protocol Specification](https://modelcontextprotocol.io)
- [Playwright Documentation](https://playwright.dev)

## 🤝 Support

For issues or questions:
1. Check this documentation
2. Review the [Chrome DevTools MCP README](https://github.com/ChromeDevTools/chrome-devtools-mcp)
3. Ask Claude: "How do I use chrome devtools for [your task]?"

---

*Last Updated: December 2024*
*Version: 1.0.0*